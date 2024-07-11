import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/logic/providers/locale_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/currency/widgets/row_radio.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Sheet изменить язык
class LanguageSheet extends ConsumerWidget {
  /// Sheet изменить язык
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider);
    final localeCtrl = ref.read(localeControllerProvider.notifier);
    const padding = EdgeInsets.all(8);
    return Padding(
      padding: Consts.gapHoriz12,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: AppColors.primaryMid,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                border: Border.all(color: AppColors.bwBrightPrimary),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: localeCtrl.supportedLocales.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, i) {
                  final l = localeCtrl.supportedLocales[i];
                  final value = localeCtrl.localesValues[i];
                  final isActive = locale.languageCode == l.languageCode;
                  return RowRadio(
                    name: value,
                    code: '',
                    onTap: () {
                      localeCtrl.setLocale(localeCtrl.supportedLocales[i]);
                    },
                    isActive: isActive,
                  );
                },
                separatorBuilder: (_, __) => 8.sbHeight,
              ),
            ),
          ),
          ButtonBottomSheet(
            onTapBtn: () {
              ref.read(appBottomSheetCtrlProvider.notifier).closeSheet();
            },
            nameBtn: 'mobile.done'.tr(),
          ),
          44.sbHeight,
        ],
      ),
    );
  }
}
