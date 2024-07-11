import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/blockchains_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_input.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/tokens/expansion_tile/close_part.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Токены
class TokensSheet extends ConsumerStatefulWidget {
  /// Токены
  const TokensSheet({super.key});

  @override
  ConsumerState<TokensSheet> createState() => _TokensSheetState();
}

class _TokensSheetState extends ConsumerState<TokensSheet> {
  final ctrl = TextEditingController();

  List<AppBlockchain> filteredItems = [];

  List<AppBlockchain> filterTokens(String searchText) {
    final data = ref.watch(blockchainsServiceProvider);

    return data.map((entity) {
      final filteredTokens = entity.tokens
          .where(
            (token) => token.name.toLowerCase().contains(
                  searchText.toLowerCase(),
                ),
          )
          .toList();

      return AppBlockchain(
        id: entity.id,
        name: entity.name,
        shortName: entity.shortName,
        icon: entity.icon,
        tokens: filteredTokens,
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    final list = ref.read(blockchainsServiceProvider);
    addPostFrameCallback(() {
      setState(() {
        filteredItems = list;
      });
    });
  }

  void start(String value, {bool clear = false}) {
    if (clear) {
      ctrl.text = value;
    }
    setState(() {
      filteredItems = filterTokens(value);
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  24.sbHeight,
                  AppInput(
                    controller: ctrl,
                    hintText: 'mobile.search'.tr(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    fillColor: AppColors.primaryMid,
                    prefixIcon: AppIcons.search(width: 16, height: 16),
                    suffixIcon: ctrl.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () => start('', clear: true),
                            child: AppIcons.crossCircle(width: 16, height: 16),
                          )
                        : null,
                    onChanged: start,
                  ),
                  24.sbHeight,
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: filteredItems.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, i) {
                return ClosePart(filteredItems[i]);
              },
              separatorBuilder: (_, __) => 12.sbHeight,
            ),
          ),
        ],
      ),
    );
  }
}
