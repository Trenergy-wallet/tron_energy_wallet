part of '../change_pincode_ctrl.cg.dart';

/// Изменить пин кода
class ChangePinSheet extends HookConsumerWidget {
  /// Изменить пин кода
  const ChangePinSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(changePinCodeCtrlProvider);
    final c = ref.watch(changePinCodeCtrlProvider.notifier);

    final isIpad = screenWidth >= 768;
    return SingleChildScrollView(
      child: Column(
        children: [
          if (isIpad) (screenHeight * 0.2).sbHeight,
          AppPinUI(
            pinLength: m.pinLength,
            uiPin: m.uiPin,
            isError: m.isError,
            isAllGood: m.isAllGood,
            onTap: m.isLoading ? (_) {} : c.setPin,
            onTapRemove: c.removeLastPin,
          ),
        ],
      ),
    );
  }
}
