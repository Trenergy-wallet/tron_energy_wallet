import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/data/repo/local/models/account_model.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/auth/app_scaffold_auth.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/start_screen.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';
part 'gen/enter_ctrl.cg.g.dart';
part 'enter_screen.dart';

/// Тип входа
enum EnterType {
  /// создание нового кошелька
  create,

  /// импорт кошелька
  import,
}

///
@riverpod
class EnterCtrl extends _$EnterCtrl {
  @override
  EnterType build() {
    return EnterType.create;
  }

  ///
  void goToPin({required EnterType type}) {
    switch (type) {
      case EnterType.create:
        state = type;
        appRouter.push(ScreenPaths.pinCode);
      case EnterType.import:
        state = type;
        appRouter.push(ScreenPaths.pinCode);
    }
  }
}

///
@riverpod
class CreateAccountCtrl extends _$CreateAccountCtrl {
  @override
  AccountModel build() {
    return AccountModel.empty;
  }

  /// Обновление аккаунта
  void updateAccount({
    String? name,
    String? description,
    String? iconPath,
    String? iconColorBg,
    String? address,
    String? privateKey,
    String? publicKey,
    String? mnemonic,
    String? token,
    String? pin,
  }) {
    state = state.copyWith(
      name: name ?? state.name,
      description: description ?? state.description,
      iconPath: iconPath ?? state.iconPath,
      iconColorBg: iconColorBg ?? state.iconColorBg,
      address: address ?? state.address,
      privateKey: privateKey ?? state.privateKey,
      publicKey: publicKey ?? state.publicKey,
      token: token ?? state.token,
      mnemonic: mnemonic ?? state.mnemonic,
    );
  }

  /// Очистка аккаунта
  void clearAccount() {
    state = AccountModel.empty;
  }
}
