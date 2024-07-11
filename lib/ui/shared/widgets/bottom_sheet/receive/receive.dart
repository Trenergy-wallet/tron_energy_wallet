import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/ui/screens/wallet/current_asset.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/img_network.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Sheet получить деньги
class ReceiveSheet extends ConsumerWidget {
  /// Sheet получить деньги
  const ReceiveSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asset = ref.watch(currentAssetProvider);
    const padding = EdgeInsets.all(8);
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                12.sbHeight,
                Container(
                  width: 256,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    border: Border.all(
                      color: AppColors.bwBrightPrimary,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: padding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImgNetwork(
                              pathImg: asset.token.icon,
                              width: 32,
                              height: 32,
                            ),
                            6.sbWidth,
                            AppText.bodySmallText(asset.token.name),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: AppColors.bwBrightPrimary,
                      ),
                      Padding(
                        padding: padding,
                        child: PrettyQrView.data(
                          data: asset.address,
                          decoration: PrettyQrDecoration(
                            // image: const PrettyQrDecorationImage(
                            //   image: AssetImage(AppIcons.logoMan),
                            // ),
                            shape: PrettyQrSmoothSymbol(
                              color: AppColors.bwBrightPrimary,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: AppColors.bwBrightPrimary,
                      ),
                      Padding(
                        padding: padding,
                        child: AppText.bodyRegularCond(
                          asset.address,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                24.sbHeight,
                Padding(
                  padding: Consts.gapHoriz12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppButton.strokeM(
                          text: 'mobile.copy'.tr(),
                          leftPathIcon: AppIcons.copyIcon,
                          onTap: () {
                            clipBoardCopy(
                              asset.address,
                              tooltip: 'mobile.tooltip_copy'.tr(
                                  // namedArgs: {
                                  //   'address': asset.address,
                                  // },
                                  ),
                            );
                          },
                        ),
                      ),
                      12.sbWidth,
                      Expanded(
                        child: AppButton.strokeM(
                          text: 'mobile.share'.tr(),
                          leftPathIcon: AppIcons.shareIcon,
                          onTap: () async {
                            final box =
                                context.findRenderObject() as RenderBox?;
                            await Share.share(
                              asset.address,
                              subject: asset.token.name,
                              sharePositionOrigin:
                                  box!.localToGlobal(Offset.zero) & box.size,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: ButtonBottomSheet(
            padHoriz: 12,
            onTapBtn: () {
              ref.read(appBottomSheetCtrlProvider.notifier).closeSheet();
            },
            nameBtn: 'mobile.done'.tr(),
          ),
        ),
      ],
    );
  }
}
