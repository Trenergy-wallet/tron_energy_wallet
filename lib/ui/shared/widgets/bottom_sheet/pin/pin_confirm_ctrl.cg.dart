import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/screens/safety/model/pincode_model.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_pin_ui.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/send_ctrl.cg.dart';

part 'gen/pin_confirm_ctrl.cg.g.dart';

part 'pin_to_confirm.dart';

/// pin confirm Ctrl
@riverpod
class PinConfirmCtrl extends _$PinConfirmCtrl {
  /// Repo local
  LocalRepo get localRepo => ref.read(repoProvider).local;

  ///
  String localPin = '';

  @override
  ChangePinCodeModel build() {
    localPin = localRepo.getPin();
    return const ChangePinCodeModel();
  }

  ///
  void setPin(int numb, void Function() onTap) {
    state = state.copyWith(uiPin: state.uiPin + numb.toString());

    if (state.uiPin.length != state.pinLength) {
      return;
    }

    if (state.uiPin == localPin) {
      state = state.copyWith(isAllGood: true);

      delayMs(Consts.delayTimePin).then((_) {
        onTap.call();
      });
    } else {
      state = state.copyWith(isError: true);

      delayMs(Consts.delayTimePin).then((_) {
        state = state.copyWith(uiPin: '');
        state = state.copyWith(isError: false);
      });
    }
  }

  /// Удалить пин код
  void removeLastPin() {
    final uiPinState = state.uiPin;
    if (uiPinState.isEmpty) {
      return;
    }
    state = state.copyWith(
      uiPin: uiPinState.substring(0, uiPinState.length - 1),
    );
  }
}
