// ignore_for_file: public_member_api_docs
import 'dart:ui' as ui show TextHeightBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

extension AppTextX on AppTextType {
  /// Выбор стиля текста на основании данных AppTextType
  TextStyle withColor({Color? color}) => switch (this) {
        AppTextType.titleH1 => AppStyles.titleH1.copyWith(color: color),
        AppTextType.titleH2 => AppStyles.titleH2.copyWith(color: color),
        AppTextType.balanceL => AppStyles.balanceL.copyWith(color: color),
        AppTextType.bigInput => AppStyles.bigInput.copyWith(color: color),
        AppTextType.bodySubTitle =>
          AppStyles.bodySubTitle.copyWith(color: color),
        AppTextType.bodyRegularCond =>
          AppStyles.bodyRegularCond.copyWith(color: color),
        AppTextType.bodySemiBoldCond =>
          AppStyles.bodySemiBoldCond.copyWith(color: color),
        AppTextType.bodyMediumCond =>
          AppStyles.bodyMediumCond.copyWith(color: color),
        AppTextType.bodyMedium => AppStyles.bodyMedium.copyWith(color: color),
        AppTextType.bodySmallTextCond =>
          AppStyles.bodySmallTextCond.copyWith(color: color),
        AppTextType.bodySmallText =>
          AppStyles.bodySmallText.copyWith(color: color),
        AppTextType.bodyCaption => AppStyles.bodyCaption.copyWith(color: color),
        AppTextType.bodyCaptionXS =>
          AppStyles.bodyCaptionXS.copyWith(color: color),
        AppTextType.placeholderMediumCond =>
          AppStyles.placeholderMediumCond.copyWith(color: color),
        AppTextType.bwSmallTextCond =>
          AppStyles.bwSmallTextCond.copyWith(color: color),
        AppTextType.bwPrimaryBright =>
          AppStyles.bwPrimaryBright.copyWith(color: color),
        AppTextType.lButtonSemiB =>
          AppStyles.lButtonSemiB.copyWith(color: color),
        AppTextType.lButtonMedium =>
          AppStyles.lButtonMedium.copyWith(color: color),
        AppTextType.mButtonMedium =>
          AppStyles.mButtonMedium.copyWith(color: color),
        AppTextType.mButtonRegular =>
          AppStyles.mButtonRegular.copyWith(color: color),
        AppTextType.buttonsLink => AppStyles.buttonsLink.copyWith(color: color),
        AppTextType.buttonsNumpad =>
          AppStyles.buttonsNumpad.copyWith(color: color),
      };
}

/// Все типы текста
enum AppTextType {
  titleH1,
  titleH2,
  balanceL,
  bigInput,
  bodySubTitle,
  bodyRegularCond,
  bodySemiBoldCond,
  bodyMediumCond,
  bodyMedium,
  bodySmallTextCond,
  bodySmallText,
  bodyCaption,
  bodyCaptionXS,
  placeholderMediumCond,
  bwSmallTextCond,
  bwPrimaryBright,
  lButtonSemiB,
  lButtonMedium,
  mButtonMedium,
  mButtonRegular,
  buttonsLink,
  buttonsNumpad,
}

/// Основной виджет для текста
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    this.style,
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  });

  /// [AppTextType.titleH1]
  AppText.titleH1(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.titleH1.withColor(color: color);

  /// [AppTextType.titleH2]
  AppText.titleH2(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.titleH2.withColor(color: color);

  /// [AppTextType.balanceL]
  AppText.balanceL(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.balanceL.withColor(color: color);

  /// [AppTextType.bigInput]
  AppText.bigInput(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bigInput.withColor(color: color);

  /// [AppTextType.bodySubTitle]
  AppText.bodySubTitle(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bodySubTitle.withColor(color: color);

  /// [AppTextType.bodyRegularCond]
  AppText.bodyRegularCond(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bodyRegularCond.withColor(color: color);

  /// [AppTextType.bodySemiBoldCond]
  AppText.bodySemiBoldCond(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bodySemiBoldCond.withColor(color: color);

  /// [AppTextType.bodyMediumCond]
  AppText.bodyMediumCond(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bodyMediumCond.withColor(color: color);

  /// [AppTextType.bodyMedium]
  AppText.bodyMedium(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bodyMedium.withColor(color: color);

  /// [AppTextType.bodySmallTextCond]
  AppText.bodySmallTextCond(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bodySmallTextCond.withColor(color: color);

  /// [AppTextType.bodySmallText]
  AppText.bodySmallText(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bodySmallText.withColor(color: color);

  /// [AppTextType.bwSmallTextCond]
  AppText.bwSmallTextCond(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bwSmallTextCond.withColor(color: color);

  /// [AppTextType.bwPrimaryBright]
  AppText.bwPrimaryBright(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bwPrimaryBright.withColor(color: color);

  /// [AppTextType.lButtonSemiB]
  AppText.lButtonSemiB(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.lButtonSemiB.withColor(color: color);

  /// [AppTextType.lButtonMedium]
  AppText.lButtonMedium(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.lButtonMedium.withColor(color: color);

  /// [AppTextType.mButtonMedium]
  AppText.mButtonMedium(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.mButtonMedium.withColor(color: color);

  /// [AppTextType.mButtonRegular]
  AppText.mButtonRegular(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.mButtonRegular.withColor(color: color);

  /// [AppTextType.buttonsLink]
  AppText.buttonsLink(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.buttonsLink.withColor(color: color);

  /// [AppTextType.bodyCaption]
  AppText.bodyCaption(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bodyCaption.withColor(color: color);

  /// [AppTextType.bodyCaptionXS]
  AppText.bodyCaptionXS(
    this.text, {
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.key,
  }) : style = AppTextType.bodyCaptionXS.withColor(color: color);

  final String? text;
  final TextStyle? style;
  final Color? color;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;

  @override
  Widget build(BuildContext context) {
    // при изменении масштаба текста на iOS вылезал overflow.
    // по согласованию с ПМ зафризили.
    final tsf = (textScaleFactor ?? 1.0) > 1.0 ? 1.0 : 1.0;

    return Text(
      text ?? '',
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: TextScaler.linear(tsf),
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
