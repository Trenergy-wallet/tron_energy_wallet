// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Класс светлой темы для цветов
abstract final class LightColorTheme {
  //== Black&White Primary ==//
  static const bwBrightPrimary = Color(0xFF0C0C0D);

  //== Black&White Gray ==//
  static const bwGrayBright = Color.fromRGBO(12, 12, 13, .45);
  static const bwGrayMid = Color.fromRGBO(12, 12, 13, .25);
  static const bwGrayDull = Color.fromRGBO(12, 12, 13, .18);

  //== Primary ==//
  static const primaryBright = Color(0xFFEDEDF2);
  static const primaryMid = Color(0xFFF5F5FA);
  static const primaryDull = Color(0xFFFCFCFF);

  //== Positive ==//
  static const positiveBright = Color(0xFF16B226);
  static const positiveMid = Color.fromRGBO(22, 178, 38, .5);
  static const positiveDull = Color.fromRGBO(22, 178, 38, .25);

  //== Positive / contrast ==//
  static const positiveContrastBright = Color(0xFF10CC23);
  static const positiveContrastMid = Color.fromRGBO(16, 204, 35, .5);
  static const positiveContrastDull = Color.fromRGBO(16, 204, 35, .20);

  //== Positive / light ==//
  static const positiveLightBright = Color.fromRGBO(16, 204, 35, .20);
  static const positiveLightMid = Color.fromRGBO(16, 204, 35, .1);
  static const positiveLightDull = Color.fromRGBO(16, 204, 35, .05);

  //== Negative ==//
  static const negativeBright = Color(0xFFCB2427);
  static const negativeMid = Color.fromRGBO(203, 36, 39, .5);
  static const negativeDull = Color.fromRGBO(203, 36, 39, .25);

  //== Negative / contrast ==//
  static const negativeContrastBright = Color(0xFFFD575A);
  static const negativeContrastMid = Color.fromRGBO(253, 87, 90, .55);
  static const negativeContrastDull = Color.fromRGBO(253, 87, 90, .3);

  //== Negative / light ==//
  static const negativeLightBright = Color.fromRGBO(253, 87, 90, .2);
  static const negativeLightMid = Color.fromRGBO(253, 87, 90, .1);
  static const negativeLightDull = Color.fromRGBO(253, 87, 90, .05);

  //== Blue violet ==//
  static const blueVioletBright = Color(0xFF3123D0);
  static const blueVioletMid = Color.fromRGBO(49, 35, 208, .5);
  static const blueVioletDull = Color.fromRGBO(49, 35, 208, .25);

  //== Buttons / lime ==//
  static const buttonsLimeBright = Color(0xFFDAFD57);
  static const buttonsLimeMid = Color(0xFFB3E300);
  static const buttonsLimeDull = Color(0xFFF4FFC7);

  //== Buttons / bw ==//
  static const buttonsBWBright = Color(0xFF0C0C0D);
  static const buttonsBWMid = Color(0xFF3B3B40);
  static const buttonsBWDull = Color(0xFFA5A5A7);

  //== Buttons / lavender ==//
  static const buttonsLavenderBright = Color(0xFFC9C6FF);
  static const buttonsLavenderMid = Color(0xFFEBEBFF);
  static const buttonsLavenderDull = Color(0xFFE6E6FF);

  //== Buttons / blue ==//
  static const buttonsBlueBright = Color(0xFF74EBFF);
  static const buttonsBlueMid = Color(0xFF37CEE6);
  static const buttonsBlueDull = Color(0xFFC4F7FF);

  //== Buttons / violet ==//
  static const buttonsVioletBright = Color(0xFFE3A3FF);
  static const buttonsVioletMid = Color(0xFFC455F4);
  static const buttonsVioletDull = Color(0xFFEDC4FF);

  //== Gray ==//
  static const grayBright = Color.fromRGBO(12, 12, 13, .45);
  static const grayMid = Color.fromRGBO(12, 12, 13, .25);
  static const grayDull = Color.fromRGBO(12, 12, 13, .18);

  //== Dim ==//
  static const dimDark = Color.fromRGBO(12, 12, 13, .13);

  //== Black ==//
  static const blackBright = Color(0xFF0C0C0D);

  //== accents ==//
  static const pattentsBlue = Color(0xFFD8F1FA);
  static const magnolia = Color(0xFFFBF7FF);
  static const peach = Color(0xFFFFE1C5);
  static const fuchsia = Color(0xFF906CDD);
  static const reed = Color(0xFFCFFFB8);
  static const blue = Color(0xFF3123D0);
  static const pattensBlue = Color(0xFFD8F1FA);

  static final systemUiOverlayStyle = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.red,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  static final data = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: bwBrightPrimary,
    visualDensity: VisualDensity.adaptivePlatformDensity,

// Пока выключаем. Слишком красиво. На самом деле, потому что в сплэш
// начали замешиваться дополнительные цвета. Для работы же с Material2
// достаточно переназначить overlayColor для анимации кнопок при нажатии
// useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.bwBrightPrimary,
    ),
  );
}
