import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/data/repo/local/models/account_model.cg.dart';
import 'package:trenergy_wallet/logic/providers/fcm_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/blockchains_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/currencies_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/logic/repo/transactions/transactions_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_energy_pipe/tron_energy_pipe_provider.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/shared/app_alert.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';

part 'gen/hive_repo.cg.g.dart';

/// Связка риверпода и удаленного репозитория
@riverpod
LocalRepo localRepo(LocalRepoRef ref) => HiveRepoImpl(ref);

late Box<List<String>> _accountsBox;
late Box<String> _accountBox;
late Box<String> _secretKeyBox;
late Box<String> _authMessageBox;
late Box<String> _tokenBox;
late Box<String> _mnemonicBox;
late Box<String> _pinBox;
late Box<bool> _pushFlagBox;
late Box<bool> _onlyFavoritesBox;
late Box<bool> _buyEnergyFaqBox;

const _secretKeyBoxName = 'secretKey';

const _authMessageBoxName = 'authMessage';

const _tokenBoxName = 'token';
const _pinBoxName = 'pin';
const _pushFlagBoxName = 'pushFlag';
const _onlyFavoritesBoxName = 'onlyFavorites';
const _buyEnergyFaqBoxName = 'buyEnergyFaq';

const _mnemonicBoxName = 'mnemonic';
const _accountsBoxName = 'accounts';
const _accountBoxName = 'account';

const _accountsKey = 'accounts';
const _accountKey = 'account';
const _pushFlagKey = 'pushFlag';
const _buyEnergyFaqKey = 'buyEnergyFaq';

/// Инициализация Hive
Future<void> initHive({bool forTesting = false}) async {
  if (forTesting) {
    final path = Directory.current.path;
    Hive.init('$path/test/data/repo');
  } else {
    await Hive.initFlutter();
  }

  _accountsBox = await Hive.openBox<List<String>>(_accountsBoxName);
  _accountBox = await Hive.openBox<String>(_accountBoxName);

  _secretKeyBox = await Hive.openBox<String>(_secretKeyBoxName);
  _authMessageBox = await Hive.openBox<String>(_authMessageBoxName);
  _tokenBox = await Hive.openBox<String>(_tokenBoxName);
  _mnemonicBox = await Hive.openBox<String>(_mnemonicBoxName);
  _onlyFavoritesBox = await Hive.openBox<bool>(_onlyFavoritesBoxName);
  _pinBox = await Hive.openBox<String>(_pinBoxName);
  _pushFlagBox = await Hive.openBox<bool>(_pushFlagBoxName);
  _buyEnergyFaqBox = await Hive.openBox<bool>(_buyEnergyFaqBoxName);
}

/// Repository implementation.
class HiveRepoImpl implements LocalRepo {
  /// Repository implementation.
  HiveRepoImpl(this._ref);

  // ignore: unused_field
  final Ref _ref;

  @override
  String getPin() {
    final env = AppConfig.environment;
    return _pinBox.get(env.appIdSuffix) ?? '';
  }

  @override
  void savePin(String value) {
    final env = AppConfig.environment;
    _pinBox.put(env.appIdSuffix, value);
  }

  @override
  String getSecretKey() {
    final env = AppConfig.environment;
    return _secretKeyBox.get(env.appIdSuffix) ?? '';
  }

  @override
  void saveSecretKey(String value) {
    final env = AppConfig.environment;
    _secretKeyBox.put(env.appIdSuffix, value);
  }

  @override
  String getAuthMessage() {
    final env = AppConfig.environment;
    return _authMessageBox.get(env.appIdSuffix) ?? '';
  }

  @override
  void saveAuthMessage(String value) {
    final env = AppConfig.environment;
    _authMessageBox.put(env.appIdSuffix, value);
  }

  @override
  String getToken() {
    final env = AppConfig.environment;
    return _tokenBox.get(env.appIdSuffix) ?? '';
  }

  @override
  void saveToken(String value) {
    final env = AppConfig.environment;
    _tokenBox.put(env.appIdSuffix, value);
  }

  @override
  Future<String> getMnemonic(String secretKey) async {
    final env = AppConfig.environment;

    final decrypt = decryptUtils(
      secretKey: secretKey,
      encrypted: _mnemonicBox.get(env.appIdSuffix) ?? '',
    );

    return decrypt;
  }

  @override
  Future<void> saveMnemonic(String str, String secretKey) async {
    final env = AppConfig.environment;
    final encrypted = encryptUtils(secretKey: secretKey, str: str);
    await _mnemonicBox.put(env.appIdSuffix, encrypted);
  }

  @override
  bool getOnlyFavorites() {
    final env = AppConfig.environment;

    return _onlyFavoritesBox.get(env.appIdSuffix) ?? false;
  }

  @override
  Future<void> saveOnlyFavorites(bool b) async {
    final env = AppConfig.environment;

    await _onlyFavoritesBox.put(env.appIdSuffix, b);
  }

  @override
  bool getBuyEnergyFaq() {
    final env = AppConfig.environment;

    return _buyEnergyFaqBox.get(env.appIdSuffix) ?? false;
  }

  @override
  Future<void> saveBuyEnergyFaq(bool b) async {
    final env = AppConfig.environment;

    await _buyEnergyFaqBox.put(env.appIdSuffix, b);
  }

  @override
  void deleteAccountList(AccountModel account) {
    final sk = getSecretKey();
    final listAccEncrypted = _accountsBox.get(_accountsKey) ?? [];

    final listAccModel = getAccountList(sk: sk);

    if (listAccModel.contains(account)) {
      listAccModel.remove(account);
    }

    if (listAccModel.isEmpty) {
      _accountBox.delete(_accountKey);
      _accountsBox.delete(_accountsKey);
      _secretKeyBox.delete(_secretKeyBoxName);
      appRouter.go(ScreenPaths.enterWallet);
      return;
    }

    listAccEncrypted.clear();
    for (final a in listAccModel) {
      final stringAccount = json.encode(a.toJson());
      final encrypted = encryptUtils(
        secretKey: sk,
        str: stringAccount,
      );
      listAccEncrypted.add(encrypted);
    }

    _accountsBox.put(_accountsKey, listAccEncrypted);
    _accountBox.put(_accountKey, listAccEncrypted[0]);
    updateAllService();
    goToWallet();
  }

  @override
  AccountModel getAccount({required String sk, AccountModel? account}) {
    var m = '';
    if (account != null) {
      m = json.encode(account.toJson());
    } else {
      m = _accountBox.get(_accountKey) ?? '';
    }

    if (m.isNotEmpty) {
      final decrypt = decryptUtils(
        secretKey: sk,
        encrypted: m,
      );
      return AccountModel.fromJson(
        json.decode(decrypt) as Map<String, dynamic>,
      );
    }
    return AccountModel.empty;
  }

  @override
  List<AccountModel> getAccountList({required String sk}) {
    final accounts = <AccountModel>[];

    final list = _accountsBox.get(_accountsKey) ?? [];

    for (final item in list) {
      final decrypt = decryptUtils(
        secretKey: sk,
        encrypted: item,
      );
      accounts.add(
        AccountModel.fromJson(json.decode(decrypt) as Map<String, dynamic>),
      );
    }

    return accounts;
  }

  @override
  void chooseAccount(AccountModel account) {
    final sk = getSecretKey();
    final stringAccount = json.encode(account.toJson());

    final encrypted = encryptUtils(
      secretKey: sk,
      str: stringAccount,
    );
    _accountBox.put(_accountKey, encrypted);

    updateAllService();
  }

  @override
  void saveAccount(AccountModel account) {
    final sk = getSecretKey();
    final list = getAccountList(sk: sk);

    final stringAccount = json.encode(account.toJson());

    final encrypted = encryptUtils(
      secretKey: sk,
      str: stringAccount,
    );

    if (!list.contains(account)) {
      _accountBox.put(_accountKey, encrypted);

      final accounts = _accountsBox.get(_accountsKey) ?? [];
      _accountsBox.put(_accountsKey, [...accounts, encrypted]);
      updateAllService();
    }
  }

  @override
  void updateAccount({
    String? name,
    String? description,
    String? iconPath,
    String? pin,
    String? iconColorBg,
  }) {
    final m = _accountBox.get(_accountKey) ?? '';
    if (m.isNotEmpty) {
      var account =
          AccountModel.fromJson(json.decode(m) as Map<String, dynamic>);

      account = account.copyWith(
        name: name ?? account.name,
        description: description ?? account.description,
        iconPath: iconPath ?? account.iconPath,
        iconColorBg: iconColorBg ?? account.iconColorBg,
      );

      final s = json.encode(account.toJson());
      _accountBox.put(_accountKey, s);

      final list = _accountsBox.get(_accountsKey) ?? [];
      final index = list.indexOf(m);

      list.replaceRange(index, index + 1, [s]);
      _accountsBox.put(_accountsKey, list);
    }
    appAlert(value: 'value');
  }

  @override
  void savePushFlag(bool value) {
    _pushFlagBox.put(_pushFlagKey, value);
  }

  @override
  bool getPushFlag() {
    return _pushFlagBox.get(_pushFlagKey) ?? true;
  }

  ///
  @override
  void updateAllService() {
    _ref
      ..read(appBottomSheetCtrlProvider.notifier).closeSheet()
      ..read(accountServiceProvider.notifier).getAccount()
      ..read(blockchainsServiceProvider.notifier).getListBlockchains()
      ..read(currenciesServiceProvider.notifier).getListCurrency()
      ..invalidate(transactionsServiceProvider)
      ..invalidate(favoritesServiceProvider)
      ..invalidate(tronEnergyPipeServiceProvider)
      ..read(fcmProvider)
      // ..read(fcm2Provider)
      ..read(repoProvider).local;
  }
}
