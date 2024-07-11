part of 'change_pincode_ctrl.cg.dart';

///
class ChangePinScreen extends ConsumerWidget {
  ///
  const ChangePinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      navBarEnable: false,
      appBar: SimpleAppBar(
        title: 'mobile.safety'.tr(),
        hasLeading: false,
      ),
      body: Column(
        children: [
          Container(
            width: screenWidth,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primaryDull,
              border: Border.all(color: AppColors.bwBrightPrimary),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                ItemContainer(
                  title: 'mobile.change'.tr(),
                  rightWidget: AppIcons.chevronRight(),
                  onTap:
                      ref.read(appBottomSheetCtrlProvider.notifier).changePin,
                  paddingDivider: Consts.gapHoriz12,
                  hasDivider: false,
                  isFirst: true,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
