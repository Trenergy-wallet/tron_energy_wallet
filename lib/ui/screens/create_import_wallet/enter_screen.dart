part of 'enter_ctrl.cg.dart';

/// Вход в приложение
class EnterScreen extends ConsumerWidget {
  /// Вход в приложение
  const EnterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(enterCtrlProvider.notifier);
    return AppScaffoldAuth(
      navBarEnable: false,
      body: Column(
        children: [
          const RiveStartScreen(),
          40.sbHeightSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppButton.limeL(
              text: 'mobile.create_wallet'.tr(),
              onTap: () {
                c.goToPin(type: EnterType.create);
              },
            ),
          ),
          28.sbHeightSmall,
          AppButtonText(
            text: 'mobile.already_have_wallet'.tr(),
            type: AppTextType.lButtonMedium,
            onTap: () {
              c.goToPin(type: EnterType.import);
            },
          ),
          const Spacer(),
          AppText.bodySmallTextCond(
            'mobile.continuing_accept'.tr(),
            color: AppColors.bwGrayBright,
          ),
          8.sbHeightSmall,
          AppButtonText(
            text: 'mobile.conditions_use'.tr(),
            onTap: () {},
          ),
          64.sbHeightSmall,
        ],
      ),
    );
  }
}
