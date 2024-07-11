import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// UI для пин кода
class AppPinUI extends StatelessWidget {
  /// UI для пин кода
  const AppPinUI({
    super.key,
    required this.pinLength,
    required this.uiPin,
    required this.isError,
    required this.isAllGood,
    this.isNotBottomSheet = true,
    required this.onTap,
    required this.onTapRemove,
  });

  /// длина пин кода
  final int pinLength;

  /// Ввод пин кода
  final String uiPin;

  /// ошибка
  final bool isError;

  /// все хорошо
  final bool isAllGood;

  /// если это боттом сейчас
  final bool isNotBottomSheet;

  /// нажатие на кнопку
  final void Function(int) onTap;

  /// нажатие на кнопку удаления
  final void Function() onTapRemove;

  @override
  Widget build(BuildContext context) {
    // final screenW = screenWidth > 400 ? 375 : screenWidth;
    // final isSmallScreen = screenHeight < Consts.smallScreenHeight;
    // final isSmallScreenW = screenWidth <= 320;
    final isIpad = screenWidth >= 768;
    final widthBtn = isIpad ? 311 / 3 : (screenWidth - 64) / 3;

    // final widthBtn =
    // isSmallScreen || isSmallScreenW ? 80.0 : (screenWidth - 64) / 3;
    const heightBtn = 60.0;
    // final heightBtn = isSmallScreen || isSmallScreenW ? 58.0 : 72.0;
    const duration = Consts.humanFriendlyDelay * 2;

    final numbList = List.generate(10, (index) => index + 1);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 160,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isAllGood) ...[
                  Positioned(
                    child: ElasticIn(
                      duration: const Duration(milliseconds: duration),
                      child: AppIcons.blastGood(),
                    ),
                  ),
                  Positioned(
                    child: ElasticIn(
                      duration: const Duration(milliseconds: duration),
                      child: AppIcons.lockGood(),
                    ),
                  ),
                ] else ...[
                  if (isError) ...[
                    Positioned(
                      child: ElasticIn(
                        duration: const Duration(milliseconds: duration),
                        child: AppIcons.blastError(),
                      ),
                    ),
                    Positioned(
                      child: ElasticIn(
                        duration: const Duration(milliseconds: duration),
                        child: AppIcons.lockError(),
                      ),
                    ),
                  ] else ...[
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: duration),
                      curve: Curves.elasticOut,
                      top: 14 + (uiPin.length * 3),
                      child: AppIcons.lock2(),
                    ),
                    Positioned(
                      bottom: 33,
                      child: AppIcons.lock1(),
                    ),
                  ],
                ],
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < pinLength; i++) ...[
                if (i < uiPin.length)
                  AppIcons.pinStarFull(
                    color: isError
                        ? AppColors.negativeBright
                        : AppColors.bwBrightPrimary,
                  )
                else
                  AppIcons.pinStar(
                    color: isError
                        ? AppColors.negativeBright
                        : AppColors.bwBrightPrimary,
                  ),
                if (i < pinLength - 1) 8.sbWidth else 0.sbWidth,
              ],
            ],
          ),
          20.sbHeight,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: isIpad ? 375 : screenWidth,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 5,
                physics: const ClampingScrollPhysics(),
                children: [
                  for (int i = 0; i < 3; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: numbList
                          .sublist(i * 3, (i + 1) * 3)
                          .map(
                            (number) => AppButton.numpad(
                              text: number.toString(),
                              onTap: () {
                                if (!isError) {
                                  onTap.call(number);
                                }
                              },
                              width: widthBtn,
                              height: heightBtn,
                            ),
                          )
                          .toList(),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: widthBtn),
                      AppButton.numpad(
                        text: 0.toString(),
                        onTap: () {
                          if (!isError) {
                            onTap.call(0);
                          }
                        },
                        width: widthBtn,
                        height: heightBtn,
                      ),
                      AppButton.numpad(
                        iconPath: AppIcons.numpadDel,
                        onTap: () {
                          if (!isError) {
                            onTapRemove.call();
                          }
                        },
                        width: widthBtn,
                        height: heightBtn,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isNotBottomSheet) 140.sbHeightSmall,
        ],
      ),
    );
  }
}
