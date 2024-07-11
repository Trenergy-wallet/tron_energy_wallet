part of '../wallet_ctrl.cg.dart';

/// Правила ботом шит
class _RulesBottomSheet extends StatelessWidget {
  /// Правила ботом шит
  const _RulesBottomSheet();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AppText.bodySubTitle(
              'mobile.dont_tell_anyone_sid_phrase'.tr(),
              textAlign: TextAlign.center,
            ),
          ),
          44.sbHeight,
          Center(child: AppIcons.rulesEmoji()),
          44.sbHeight,
          AppText.bodyRegularCond('mobile.rules_1'.tr()),
          24.sbHeight,
          AppText.bodyRegularCond('mobile.rules_2'.tr()),
          24.sbHeight,
          AppText.bodyRegularCond('mobile.rules_3'.tr()),
          24.sbHeight,
          AppText.bodyRegularCond('mobile.rules_4'.tr()),
          84.sbHeight,
          AppButton.limeL(
            text: 'mobile.its_clear'.tr(),
            onTap: appRouter.pop,
          ),
          44.sbHeight,
        ],
      ),
    );
  }
}
