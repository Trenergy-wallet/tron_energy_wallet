import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/currencies_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_input.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/currency/widgets/row_radio.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Валюта
class CurrencySheet extends ConsumerStatefulWidget {
  /// Валюта
  const CurrencySheet({super.key});

  @override
  ConsumerState<CurrencySheet> createState() => _CurrencySheetState();
}

class _CurrencySheetState extends ConsumerState<CurrencySheet> {
  final ctrl = TextEditingController();

  ///
  List<AppCurrency> filteredItems = [];

  int currentId = 0;

  /// Дебаунсер
  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Consts.humanFriendlyDelay * 2),
  );

  ///
  void filterItems() {
    final list = ref.read(currenciesServiceProvider);
    final searchText = ctrl.text;
    setState(() {
      filteredItems = list.where(
        (item) {
          final allText = '${item.name} ${item.code}';
          return allText.toLowerCase().contains(
                searchText.toLowerCase(),
              );
        },
      ).toList();
    });
  }

  ///
  void setCurrentId(int id) {
    _debouncer.call(() {
      setState(() {
        currentId = id;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    addPostFrameCallback(() {
      final list = ref.read(currenciesServiceProvider);
      final account =
          ref.read(accountServiceProvider).valueOrNull ?? Account.empty;

      final currencyId = account.currency.id;
      setCurrentId(currencyId);
      setState(() {
        filteredItems = list;
      });
    });

    ctrl.addListener(filterItems);
  }

  @override
  void dispose() {
    ctrl
      ..dispose()
      ..removeListener(filterItems);
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: Consts.gapHoriz12,
            child: Column(
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        AppInput(
                          controller: ctrl,
                          hintText: 'mobile.search'.tr(),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          fillColor: AppColors.primaryMid,
                          prefixIcon: AppIcons.search(),
                          suffixIcon: ctrl.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: ctrl.clear,
                                  child: AppIcons.crossCircle(),
                                )
                              : null,
                        ),
                        24.sbHeightSmall,
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(8),
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
                      itemCount: filteredItems.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, i) {
                        final isActive = currentId == filteredItems[i].id;
                        return RowRadio(
                          name: filteredItems[i].name,
                          code: filteredItems[i].code,
                          onTap: () {
                            setCurrentId(filteredItems[i].id);
                          },
                          isActive: isActive,
                        );
                      },
                      separatorBuilder: (_, __) => 8.sbHeight,
                    ),
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
              ref
                  .read(accountServiceProvider.notifier)
                  .setCurrency(currencyId: '$currentId');
              ref.read(appBottomSheetCtrlProvider.notifier).closeSheet();
            },
            nameBtn: 'mobile.save'.tr(),
          ),
        ),
      ],
    );
  }
}
