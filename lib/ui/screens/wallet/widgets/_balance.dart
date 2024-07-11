part of '../current_asset.cg.dart';

class _Balance extends ConsumerWidget {
  const _Balance();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account =
        ref.watch(accountServiceProvider).valueOrNull ?? Account.empty;

    // final myFormatter = NumberFormat.currency(
    //   name: '${account.currency.code} ',
    //   decimalDigits: Consts.decimalDef,
    // );
    // myFormatter.format(account.totalUsdBalance * account.currency.usdRate);

    final formatted = numbWithoutZero(
      account.totalUsdBalance * account.currency.usdRate,
      precision: 2,
    );
    return Column(
      children: [
        GestureDetector(
          onTap: ref.read(appBottomSheetCtrlProvider.notifier).currency,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.bodyMedium(
                'mobile.general_balance'.tr(),
                color: AppColors.bwGrayMid,
              ),
              8.sbWidth,
              AppText.lButtonMedium(
                account.currency.code,
                color: AppColors.blueVioletBright,
              ),
              AppIcons.caretDown(color: AppColors.blueVioletBright),
            ],
          ),
        ),
        12.sbHeight,
        AppText.balanceL(
          formatted,
          color: AppColors.bwBrightPrimary,
        ),
      ],
    );
  }
}
