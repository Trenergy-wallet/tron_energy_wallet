part of '../settings_screen.cg.dart';

/// Удаление аккаунта
class DeleteAccountSheet extends HookConsumerWidget {
  /// Удаление аккаунта
  const DeleteAccountSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBottomSheetC = ref.read(appBottomSheetCtrlProvider.notifier);
    final c = ref.read(_settingsCtrlProvider.notifier);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: Consts.gapHoriz12,
              child: Column(
                children: [
                  12.sbHeight,
                  AppText.bodyRegularCond(
                    'mobile.really_want_delete_account'.tr(),
                  ),
                  44.sbHeight,
                  Row(
                    children: [
                      Expanded(
                        child: AppButton.strokeL(
                          text: 'mobile.delete'.tr(),
                          isNegative: true,
                          onTap: () {
                            c.deleteAccount();
                            appBottomSheetC.closeSheet();
                          },
                        ),
                      ),
                      12.sbWidth,
                      Expanded(
                        child: AppButton.primaryL(
                          text: 'mobile.cancellation'.tr(),
                          onTap: appBottomSheetC.closeSheet,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
