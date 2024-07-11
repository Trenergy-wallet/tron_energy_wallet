import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/screens/safety/model/pincode_model.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_pin_ui.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/enter/app_scaffold.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/appbar_simple.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/item_container.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'gen/change_pincode_ctrl.cg.g.dart';

part 'safety_screen.dart';
part 'change_pin_screen.dart';
part 'screen_bottom_sheet/change_pin.dart';
part 'screen_bottom_sheet/changed_pin.dart';

/// change Pin Code Ctrl
@riverpod
class ChangePinCodeCtrl extends _$ChangePinCodeCtrl {
  /// Repo local
  LocalRepo get localRepo => ref.read(repoProvider).local;

  /// локальный пин
  String localPin = '';

  /// текущий пин
  String currentPin = '';

  /// повторный пин
  String repeatedPin = '';

  @override
  ChangePinCodeModel build() {
    localPin = localRepo.getPin();
    return const ChangePinCodeModel();
  }

  /// Очистить пин код который для ui
  void clearUIPin() {
    if (!state.isAllGood) {
      if (state.isError) {
        delayMs(Consts.delayTimePin)
            .then((value) => state = state.copyWith(uiPin: ''));
      } else {
        delayMs(Consts.delayTimePin)
            .then((value) => state = state.copyWith(uiPin: ''));
      }
    }
  }

  ///
  String get uiPinState => state.uiPin;

  /// Заполнить пин код
  void setPin(int numb) {
    final pinLength = state.pinLength;

    if (repeatedPin.isEmpty && currentPin.length < pinLength) {
      currentPin += '$numb';
      state = state.copyWith(uiPin: currentPin);

      if (currentPin.length == pinLength) {
        state = state.copyWith(isLoading: true);

        delayMs(Consts.humanFriendlyDelay).then((_) {
          state = state.copyWith(uiPin: '', isLoading: false);
        });
      }
    } else if (currentPin.isNotEmpty && repeatedPin.length < pinLength) {
      repeatedPin += '$numb';
      state = state.copyWith(uiPin: repeatedPin);
    }

    /// второй этап - ввод нового и проверка повторного пин кода
    _newPin();

    /// первый этап - проверка текущего пин кода
    _checkCurrentPin();
  }

  /// проверка текущего пин кода
  void _checkCurrentPin() {
    final appBottom = ref.read(appBottomSheetCtrlProvider.notifier);
    final pinLength = state.pinLength;

    /// проверка на локальный пин не пустой ли
    if (localPin.isNotEmpty) {
      /// проверка на повторный и введным пином с сохраненым
      if (repeatedPin.isEmpty && currentPin == localPin) {
        appBottom.updateTitle('mobile.new_pin'.tr());
        localPin = '';
        currentPin = '';

        /// если введнный пин не равен локальному и не равен длине пин кода
      } else if (currentPin.length == pinLength && currentPin != localPin) {
        state = state.copyWith(isError: true);

        delayMs(Consts.delayTimePin).then((_) {
          currentPin = '';
          state = state.copyWith(isError: false, uiPin: '');
        });
      }
    }
  }

  /// новый пин
  void _newPin() {
    final pinLength = state.pinLength;
    final appBottom = ref.read(appBottomSheetCtrlProvider.notifier);

    /// проверка на локальный пин пустой ли
    if (localPin.isEmpty) {
      /// проверка на повторный и длину текущего пин кода
      if (repeatedPin.isEmpty && currentPin.length == pinLength) {
        state = state.copyWith(isLoading: true);
        appBottom
          ..updateTitle('mobile.confirm_pin'.tr())

          /// показываем стрелочку назад для возврата назад
          /// к вводу нового пин кода
          ..updateOnTapBack(() {
            currentPin = '';
            repeatedPin = '';
            state = state.copyWith(uiPin: '');

            appBottom
              ..updateTitle('mobile.new_pin'.tr())
              ..updateOnTapBack(null);
          });
        state = state.copyWith(isLoading: false);

        /// если все ок, то сохраняем новый пин
      } else if (repeatedPin == currentPin) {
        state = state.copyWith(isAllGood: true, isLoading: true);
        delayMs(Consts.delayTimePin).then((_) {
          localRepo.savePin(repeatedPin);
          appBottom.newPinSaved();
          state = state.copyWith(isLoading: false);
        });

        /// если длина повторног,текущего и они не равны, то показываем ошибку
      } else if (currentPin.length == pinLength &&
          repeatedPin.length == pinLength &&
          repeatedPin != currentPin) {
        state = state.copyWith(isError: true);
        delayMs(Consts.delayTimePin).then((_) {
          repeatedPin = '';
          state = state.copyWith(isError: false, uiPin: '');
        });
      }
    }
  }

  /// Удалить пин код
  void removeLastPin() {
    final pinLength = state.pinLength;
    if (currentPin.isEmpty || uiPinState.isEmpty) {
      return;
    }
    state = state.copyWith(
      uiPin: uiPinState.substring(0, uiPinState.length - 1),
    );

    if (repeatedPin.isEmpty && currentPin.length < pinLength) {
      currentPin = currentPin.substring(0, currentPin.length - 1);
    } else {
      repeatedPin = repeatedPin.substring(0, repeatedPin.length - 1);
    }
  }
}
