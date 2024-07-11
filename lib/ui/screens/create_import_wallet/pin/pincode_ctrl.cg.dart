import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/screens/safety/model/pincode_model.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_pin_ui.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/auth/app_scaffold_auth.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/appbar_simple.dart';

part 'gen/pincode_ctrl.cg.g.dart';

part 'pincode_screen.dart';

/// Pin Code Ctrl
@riverpod
class PinCodeCtrl extends _$PinCodeCtrl {
  /// Repo local
  LocalRepo get localRepo => ref.read(repoProvider).local;

  /// локальный пин
  String localPin = '';

  /// текущий пин
  String currentPin = '';

  /// повторный пин
  String repeatedPin = '';

  /// Дебаунсер
  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Consts.humanFriendlyDelay * 2),
  );

  @override
  ChangePinCodeModel build() {
    localRepo.savePin('');

    return const ChangePinCodeModel();
  }

  /// Очистить пин код который для ui
  void clearUIPin() {
    if (!state.isAllGood) {
      if (state.isError) {
        delayMs(Consts.delayTimePin).then(
          (value) => state = state.copyWith(uiPin: ''),
        );
      } else {
        delayMs(Consts.humanFriendlyDelay).then(
          (value) => state = state.copyWith(uiPin: ''),
        );
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
      state = state.copyWith(uiPin: '$uiPinState$numb');

      if (currentPin.length == pinLength) {
        state = state.copyWith(isLoading: true);
        delayMs(Consts.humanFriendlyDelay).then((_) {
          state = state.copyWith(uiPin: '', isLoading: false);
        });
      }
    } else if (repeatedPin.length < pinLength) {
      repeatedPin += '$numb';
      state = state.copyWith(uiPin: '$uiPinState$numb');
    }

    /// важна последовательность сначала _newPin потом _checkCurrentPin

    /// второй этап - ввод нового и проверка повторного пин кода
    _newPin();

    /// первый этап - проверка текущего пин кода
    _checkCurrentPin();
  }

  /// проверка текущего пин кода
  void _checkCurrentPin() {
    final pinLength = state.pinLength;

    /// проверка на локальный пин не пустой ли
    if (localPin.isNotEmpty) {
      /// проверка на повторный и введным пином с сохраненым
      if (repeatedPin.isEmpty && currentPin == localPin) {
        localPin = '';
        currentPin = '';

        /// если введнный пин не равен локальному и не равен длине пин кода
      } else if (currentPin.length == pinLength && currentPin != localPin) {
        state = state.copyWith(isError: true);

        delayMs(Consts.delayTimePin).then((_) {
          currentPin = '';
          state = state.copyWith(isError: false);
        });
      }
    }
  }

  /// новый пин
  void _newPin() {
    final pinLength = state.pinLength;

    /// проверка на локальный пин пустой ли
    if (localPin.isEmpty) {
      if (repeatedPin == currentPin) {
        state = state.copyWith(isAllGood: true);

        _debouncer.call(() {
          final secretKey = generateKey(26, seedString: repeatedPin);
          localRepo
            ..savePin(repeatedPin)
            ..saveSecretKey(secretKey);
          appRouter.push(ScreenPaths.terms);
          delayMs(Consts.humanFriendlyDelay).then((_) {
            clearPin();
          });
        });

        /// если длина повторног,текущего и они не равны, то показываем ошибку
      } else if (currentPin.length == pinLength &&
          repeatedPin.length == pinLength &&
          repeatedPin != currentPin) {
        state = state.copyWith(isError: true);
        delayMs(Consts.delayTimePin).then((_) {
          clearPin();
          state = state.copyWith(isError: false);
        });
      }
    }
  }

  /// Удалить пин код
  void removeLastPin() {
    final pinLength = state.pinLength;
    final uiPinState = state.uiPin;
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

  /// Очистить пин код
  void clearPin() {
    currentPin = '';
    repeatedPin = '';

    state = state.copyWith(uiPin: '', isAllGood: false, isError: false);
  }
}
