import 'package:flutter/material.dart';

/// Набор текстовых стелей приложения.
///
abstract final class TextThemeModel {
  /// Тип основного шрифта
  static const String fontMain = 'Martian Mono';

  /// Тип основного шрифта condensed
  static const String fontMainCond = 'Martian Mono Condensed';

  /// title H1
  static const titleH1 = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 20,
    height: 24 / 20,
  );

  /// title H1
  static const titleH2 = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 16,
    height: 20 / 16,
  );

  /// Balance L
  static const balanceL = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 28,
    height: 32 / 28,
  );

  /// Big input
  static const bigInput = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 44,
    height: 44 / 44,
  );

  /// Big input 2
  static const bigInput2 = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 24,
    height: 44 / 24,
  );

  //== Body ==//

  /// body/Sub-Title
  static const bodySubTitle = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 14,
    height: 18 / 14,
  );

  /// body/Regular Condensed
  static const bodyRegularCond = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 14,
    height: 18 / 14,
  );

  /// body/SemiBold Condensed
  static const bodySemiBoldCond = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 14,
    height: 18 / 14,
  );

  /// body/Medium Condensed
  static const bodyMediumCond = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 14,
    height: 18 / 14,
  );

  /// body/Medium
  static const bodyMedium = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 14,
    height: 18 / 14,
  );

  /// body/Small Text Cond
  static const bodySmallTextCond = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 12,
    height: 16 / 12,
  );

  /// body/Small Text
  static const bodySmallText = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 12,
    height: 16 / 12,
  );

  /// body/Small Text
  static const bodyCaption = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 10,
    height: 12 / 10,
  );

  ///
  static const bodyCaptionXS = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 6,
    height: 8 / 6,
  );

  //== Placeholder ==//
  /// placeholder/ Medium Condensed
  static const placeholderMediumCond = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 14,
    height: 18 / 14,
  );

  //== Black & White ==//

  /// Black & White bwSmallTextCond
  static const bwSmallTextCond = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 12,
    height: 16 / 12,
  );

  /// Black & White  bwPrimaryBright
  static const bwPrimaryBright = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 28,
    height: 32 / 28,
  );

  //== Buttons ==//

  /// buttons/L Button SemiB
  static const lButtonSemiB = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 14,
    height: 18 / 14,
  );

  /// buttons/L Button Medium
  static const lButtonMedium = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 14,
    height: 18 / 14,
  );

  /// buttons/M Button Medium
  static const mButtonMedium = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 12,
    height: 16 / 12,
  );

  /// buttons/M Button Regular
  static const mButtonRegular = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 12,
    height: 16 / 12,
  );

  /// buttons/Link
  static const buttonsLink = TextStyle(
    fontFamily: fontMainCond,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 12,
    height: 16 / 12,
  );

  /// buttons/Link
  static const buttonsNumpad = TextStyle(
    fontFamily: fontMain,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    leadingDistribution: TextLeadingDistribution.even,
    fontSize: 28,
    height: 32 / 28,
  );
}
