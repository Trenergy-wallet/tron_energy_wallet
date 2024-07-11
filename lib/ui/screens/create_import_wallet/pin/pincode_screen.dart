part of 'pincode_ctrl.cg.dart';

/// Экран пин кода
class PinCodeScreen extends ConsumerWidget {
  /// Экран пин кода
  const PinCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(pinCodeCtrlProvider);
    final c = ref.watch(pinCodeCtrlProvider.notifier);

    final isRepeatPin = c.currentPin.length == m.pinLength &&
        c.repeatedPin.length < m.pinLength;

    // if (m.uiPin.length == m.pinLength) {
    //   c.clearUIPin();
    // }
    return AppScaffoldAuth(
      navBarEnable: false,
      appBar: SimpleAppBar(
        title:
            isRepeatPin ? 'mobile.confirm_pin'.tr() : 'mobile.create_pin'.tr(),
      ),
      body: AppPinUI(
        pinLength: m.pinLength,
        uiPin: m.uiPin,
        isError: m.isError,
        isAllGood: m.isAllGood,
        onTap: m.isLoading ? (_) {} : c.setPin,
        onTapRemove: c.removeLastPin,
      ),
    );
  }
}
