import 'package:flutter/material.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// показать нижний боттомшит
Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required List<Widget> children,
  double? maxHeight,
}) async {
  final auxPadding = MediaQuery.of(context).viewPadding.top;
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    // благодаря этому парметру мы не ограничены размером ботомшита в полэкрана
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight:
          maxHeight ?? MediaQuery.of(context).size.height - 15 - auxPadding,
    ),
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(top: 32.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          width: screenWidth,
          decoration: BoxDecoration(
            color: AppColors.primaryDull,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          // добавляет нам возможность скролить виджеты при максимальном
          // открытии ботомшита
          child: SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                20.sbHeight,
                ...children,
              ],
            ),
          ),
        ),
      );
    },
  );
}
