// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Класс темной темы для цветов
abstract final class DarkColorTheme {
  //== Black&WhitePrimary==//
  static const bwBrightPrimary = Color(0xFFF7F7FA);

  //== Black&White Gray ==//
  static const bwGrayBright = Color.fromRGBO(247, 247, 250, .65);
  static const bwGrayMid = Color.fromRGBO(247, 247, 250, .40);
  static const bwGrayDull = Color.fromRGBO(247, 247, 250, .20);

  //== Primary ==//
  static const primaryBright = Color(0xFF363638);
  static const primaryMid = Color(0xFF272729);
  static const primaryDull = Color(0xFF1C1C1F);

  //== Positive ==//
  static const positiveBright = Color(0xFF16B226);
  static const positiveMid = Color.fromRGBO(22, 178, 38, .65);
  static const positiveDull = Color.fromRGBO(22, 178, 38, .25);

  //== Positive / contrast ==//
  static const positiveContrastBright = Color(0xFF10CC23);
  static const positiveContrastMid = Color.fromRGBO(16, 204, 35, .5);
  static const positiveContrastDull = Color.fromRGBO(16, 204, 35, .2);

  //== Positive / light ==//
  static const positiveLightBright = Color.fromRGBO(16, 204, 35, .2);
  static const positiveLightMid = Color.fromRGBO(16, 204, 35, .1);
  static const positiveLightDull = Color.fromRGBO(16, 204, 35, .05);

  //== Negative ==//
  static const negativeBright = Color(0xFFCB2427);
  static const negativeMid = Color(0xFFCB2427);
  static const negativeDull = Color(0xFFCB2427);

  //== Negative / contrast ==//
  static const negativeContrastBright = Color(0xFFFD575A);
  static const negativeContrastMid = Color.fromRGBO(253, 87, 90, .6);
  static const negativeContrastDull = Color.fromRGBO(253, 87, 90, .3);

  //== Negative / light ==//
  static const negativeLightBright = Color.fromRGBO(253, 87, 90, .2);
  static const negativeLightMid = Color.fromRGBO(253, 87, 90, .1);
  static const negativeLightDull = Color.fromRGBO(253, 87, 90, .05);

  //== Blue violet ==//
  static const blueVioletBright = Color(0xFF3123D0);
  static const blueVioletMid = Color(0xFF3123D0);
  static const blueVioletDull = Color(0xFF3123D0);

  //== Buttons / lime ==//
  static const buttonsLimeBright = Color(0xFFBAE02D);
  static const buttonsLimeMid = Color(0xFFB3E300);
  static const buttonsLimeDull = Color(0xFF5D6737);

  //== Buttons / bw ==//
  static const buttonsBWBright = Color(0xFF0C0C0D);
  static const buttonsBWMid = Color(0xFF3B3B40);
  static const buttonsBWDull = Color(0xFFA5A5A7);

  //== Buttons / lavender ==//
  static const buttonsLavenderBright = Color(0xFF47476A);
  static const buttonsLavenderMid = Color(0xFF4C4C86);
  static const buttonsLavenderDull = Color(0xFF4C4C86);

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
  static const dimDark = Color.fromRGBO(12, 12, 13, .6);

  //== Black ==//
  static const blackBright = Color(0xFF0C0C0D);

  //== accents ==//
  static const pattentsBlue = Color(0xFFD8F1FA);
  static const magnolia = Color(0xFF2A252F);
  static const peach = Color(0xFFFFC792);
  static const fuchsia = Color(0xFF7E5CC5);
  static const reed = Color(0xFF3D7C1F);
  static const blue = Color(0xFF3123D0);
  static const pattensBlue = Color(0xFFD8F1FA);

  static final systemUiOverlayStyle = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  static final data = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bwBrightPrimary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Пока выключаем. Слишком красиво. На самом деле, потому что в сплэш
    // начали замешиваться дополнительные цвета. Для работы же с Material2
    // достаточно переназначить overlayColor для анимации кнопок при нажатии
    // useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.bwBrightPrimary,
      brightness: Brightness.dark,
    ),
  );
}
