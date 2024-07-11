part of 'change_pincode_ctrl.cg.dart';

///
class SafetyScreen extends ConsumerWidget {
  ///
  const SafetyScreen({super.key});

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
                  isFirst: true,
                  isLast: true,
                  title: 'mobile.pin'.tr(),
                  rightWidget: AppIcons.chevronRight(),
                  onTap: () => appRouter.push(ScreenPaths.changePin),
                  paddingDivider: Consts.gapHoriz12,
                  hasDivider: false,
                ),
                // ItemContainer(
                //   isLast: true,
                //   title: 'Face ID'.tr(),
                //   rightWidget: RiveSwitch(
                //     onTap: (v) {},
                //   ),
                //   hasDivider: false,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
