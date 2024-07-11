import 'dart:convert';
import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:blockchain_utils/bip/mnemonic/mnemonic.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_chain/on_chain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/logic/repo/auth/auth_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/enter_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/wallet/models/confirm_seed_model.cg.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/wallet/models/mnemonic_phrase_model.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/app_alert.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_input.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_modal_bottom_sheet.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/auth/app_scaffold_auth.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/enter/app_scaffold.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/appbar_simple.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_text.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';
import 'package:wallet/wallet.dart' as wallet;

part 'confirm_wallet_screen.dart';
part 'create_wallet_screen.dart';
part 'gen/wallet_ctrl.cg.g.dart';
part 'import_wallet_screen.dart';
part 'widgets/_bottom_sheet.dart';
part 'widgets/_confirm_block.dart';
part 'widgets/_phrase_block.dart';

///
@riverpod
class WalletCtrl extends _$WalletCtrl {
  /// список выбранных слов
  final choosenWords = <String>[];

  /// Repo local
  LocalRepo get localRepo => ref.read(repoProvider).local;

  @override
  MnemonicPhraseModel build() {
    return MnemonicPhraseModel.empty;
  }

  /// Генерация мнемонической фразы
  Future<void> generateMnemonic() async {
    final sk = localRepo.getSecretKey();

    final mnemonic = bip39.generateMnemonic();

    localRepo.saveMnemonic(mnemonic, sk);

    state = state.copyWith(mnemonic: mnemonic);
  }

  /// Подтверждение мнемонической фразы - 1 этап
  void _confirmMnemonic(String m) {
    final rng = Random();

    /// мнемоник фраза разбита на список
    final mnemonic = m.split(' ');

    /// шаг генерации
    const step = 3;

    /// генерация от 0 до 11 чисел и перемешивание
    final numbers = List<int>.generate(12, (i) => i)..shuffle(rng);

    /// список cписков с тремя числами
    final listNumbers = <List<int>>[];

    /// добавляем по три числа в каждый список
    for (var i = 0; i < numbers.length; i += step) {
      listNumbers.add(numbers.sublist(i, min(i + step, numbers.length)));
    }

    final list = <ConfirmSeedModel>[];

    /// перебор списка из списка с тремя числами
    for (var i = 0; i < listNumbers.length; i++) {
      final c = ConfirmSeedModel(
        /// рандомное число из списка с тремя цифрами
        findNumber: listNumbers[i][rng.nextInt(listNumbers[i].length)] + 1,

        /// слова из фразы по индексу из списка с тремя цифрами
        findSeedWord: listNumbers[i].map(mnemonic.elementAt).toList(),
      );
      list.add(c);
    }

    state = state.copyWith(confirmList: list);
  }

  /// переход к подтверждению
  void goToConfirmWallet() {
    appRouter.push(ScreenPaths.confirmWallet);
    choosenWords.clear();
    _confirmMnemonic(state.mnemonic);
  }

  /// добавление слова
  void addWords(String word) {
    choosenWords.add(word);
  }

  /// удаление слова
  void removeWords(String word) {
    choosenWords.remove(word);
  }

  /// обновление состояния загрузки
  void updateIsLoading(bool b) {
    state = state.copyWith(isLoading: b);
  }

  /// Подтверждение мнемонической фразы - 1 этап
  void checkMnemonic() {
    final mnemonic = state.mnemonic.split(' ');
    final list = <int>[];

    /// вытаскиваем все индексы которые нужно подтвердить
    for (final cl in state.confirmList) {
      list.add(cl.findNumber);
    }

    /// по этим индексам находим слова из мнемоники
    final selectedWords = list.map((i) => mnemonic[i - 1]).toList();

    /// сравнение списков
    final areListsEqual = listEquals(
      selectedWords..sort(),
      choosenWords..sort(),
    );

    if (areListsEqual) {
      _createWallet(state.mnemonic);
    } else {
      choosenWords.isEmpty
          ? appAlert(value: 'mobile.select_words'.tr())
          : appAlert(value: 'mobile.not_true'.tr());
    }
  }

  /// Импорт кошелька
  void importWallet({required String mnemonic, String? name}) {
    updateIsLoading(true);
    final m = mnemonic.split(' ');
    final valid = wallet.validateMnemonic(m);
    if (valid) {
      _createWallet(mnemonic, name: name);
    } else {
      appAlert(value: 'mobile.not_true_sid_phrase'.tr());
      updateIsLoading(false);
    }
  }

  /// Создание кошелька после подтверждения мнемонической фразы
  void _createWallet(String mnemonic, {String? name}) {
    // Generate seed from the mnemonic
    final seed = Bip39SeedGenerator(Mnemonic.fromString(mnemonic)).generate();

    // Derive a TRON private key from the seed
    final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);

    // Derive a child key using the default path (first account)
    final childKey = bip44.deriveDefaultPath;

    final privateKey = TronPrivateKey.fromBytes(childKey.privateKey.raw);
    final publicKey = privateKey.publicKey();
    final address = publicKey.toAddress();

    final message = localRepo.getAuthMessage();
    final messageBytes = utf8.encode(message);

    final signature = privateKey.signPersonalMessage(messageBytes);

    final rng = Random();

    /// подготавливаем новый аккаунт
    ref.read(createAccountCtrlProvider.notifier).updateAccount(
          name: name ?? 'Account ${rng.nextInt(1000)}',
          address: address.toAddress(),
          privateKey: privateKey.toBytes().toString(),
          publicKey: privateKey.publicKey().toString(),
          mnemonic: mnemonic,
        );

    ref.read(authServiceProvider.notifier).authMessage(
          address: address.toAddress(),
          signature: '0x$signature',
          message: message,
        );
  }
}
