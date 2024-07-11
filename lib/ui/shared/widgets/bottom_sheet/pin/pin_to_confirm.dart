part of 'pin_confirm_ctrl.cg.dart';

/// Изменить пин кода
class PinConfirmSheet extends ConsumerWidget {
  /// Изменить пин кода
  const PinConfirmSheet({
    required this.ifEqualsStartFunc,
    super.key,
  });

  ///
  final void Function() ifEqualsStartFunc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(sendCtrlProvider);
    final m = ref.watch(pinConfirmCtrlProvider);
    final c = ref.watch(pinConfirmCtrlProvider.notifier);

    return SingleChildScrollView(
      child: AppPinUI(
        pinLength: m.pinLength,
        uiPin: m.uiPin,
        isError: m.isError,
        isAllGood: m.isAllGood,
        onTap: (i) {
          c.setPin(i, ifEqualsStartFunc);
        },
        onTapRemove: c.removeLastPin,
        isNotBottomSheet: false,
      ),
    );
  }
}
