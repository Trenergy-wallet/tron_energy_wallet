import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/theme/colors/dark_color_theme.dart';
import 'package:trenergy_wallet/ui/theme/colors/light_color_theme.dart';
import 'package:trenergy_wallet/ui/theme/text/text_theme_model.dart';
import 'package:trenergy_wallet/ui/theme/theme_model.cg.dart';

var _isDark = false;

/// Контроллер, определящий текущую активную тему
class ThemeController extends StateNotifier<ThemeModel> {
  /// Конструктор контроллера, определящий текущую активную тему
  ThemeController(this._ref) : super(ThemeModel.light()) {
    _init();
  }

  final Ref _ref;

  /// Провайдер ThemeController
  static final provider =
      StateNotifierProvider<ThemeController, ThemeModel>(ThemeController.new);

  // ignore: unused_element
  RepoBase get _repo => _ref.read(repoProvider);

  /// На этих роутах используем темную тему для изменения цвета
  /// верхних иконок системного меню
  final _darkThemeRoutes = <String>[];

  /// Слушаем роуты
  void routeListener() {
    try {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) async {
          // Этот кусочек взят из исходников GoRoute.
          // В начале времен `GoRouterState.of(routeContext!)` не находит
          // этого объекта вверх по иерархии и вызывает исключение.
          // Нам тут исключение не надо, и мы просто ставим `guard`.
          final route = ModalRoute.of(routeContext!);
          if (route == null) {
            return;
          }
          // ~Этот кусочек взят из исходников GoRoute...

          final pageRoute =
              '/${GoRouterState.of(routeContext!).uri.toString().split('/')[1]}/';
          if (_darkThemeRoutes.contains(pageRoute)) {
            setTheme(ThemeMode.dark);
          } else {
            setTheme(ThemeMode.light);
          }
        },
      );
    } catch (e, _) {}
  }

  @override
  void dispose() {
    appRouter.routerDelegate.removeListener(routeListener);
    super.dispose();
  }

  /// Установить текущую тему
  void setTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        state = ThemeModel.light();
        _isDark = false;
      case ThemeMode.dark:
        state = ThemeModel.dark();
        _isDark = true;
      // TODO(ivn): Тут надо обработать, нельзя просто на систем
      // присваивать лайт тему
      case ThemeMode.system:
        state = ThemeModel.light();
        _isDark = false;
    }
  }

  /// Переключить тему на другую доступную
  void switchTheme() {
    state.mode == ThemeMode.light
        ? setTheme(ThemeMode.dark)
        : setTheme(ThemeMode.light);
  }

  Future<void> _init() async {
    // TODO(ivn): Сделать проверку сохраненной темы и выводить ее
    ///плюс можно проверять текущую тему приложения
    setTheme(ThemeMode.light);
    appRouter.routerDelegate.addListener(routeListener);
  }
}

/// Стили текста приложения
class AppStyles {
  static const Color _textColorDark = DarkColorTheme.bwBrightPrimary;
  static const Color _textColorLight = LightColorTheme.bwBrightPrimary;

  /// главный шрифт
  static const String fontMain = TextThemeModel.fontMain;

  ///
  static TextStyle get titleH1 => TextThemeModel.titleH1
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get titleH2 => TextThemeModel.titleH2
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get balanceL => TextThemeModel.balanceL
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bigInput => TextThemeModel.bigInput
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bigInput2 => TextThemeModel.bigInput2
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  //== Body ==//
  ///
  static TextStyle get bodySubTitle => TextThemeModel.bodySubTitle
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bodyRegularCond => TextThemeModel.bodyRegularCond
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bodySemiBoldCond => TextThemeModel.bodySemiBoldCond
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bodyMediumCond => TextThemeModel.bodyMediumCond
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bodyMedium => TextThemeModel.bodyMedium
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bodySmallTextCond => TextThemeModel.bodySmallTextCond
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bodySmallText => TextThemeModel.bodySmallText
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bodyCaption => TextThemeModel.bodyCaption
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bodyCaptionXS => TextThemeModel.bodyCaptionXS
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get placeholderMediumCond =>
      TextThemeModel.placeholderMediumCond
          .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  //== Black & White ==//
  ///
  static TextStyle get bwSmallTextCond => TextThemeModel.bwSmallTextCond
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get bwPrimaryBright => TextThemeModel.bwPrimaryBright
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  //== Buttons ==//
  ///
  static TextStyle get lButtonSemiB => TextThemeModel.lButtonSemiB
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get lButtonMedium => TextThemeModel.lButtonMedium
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get mButtonMedium => TextThemeModel.mButtonMedium
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get mButtonRegular => TextThemeModel.mButtonRegular
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get buttonsLink => TextThemeModel.buttonsLink
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);

  ///
  static TextStyle get buttonsNumpad => TextThemeModel.buttonsNumpad
      .copyWith(color: _isDark ? _textColorDark : _textColorLight);
}

/// Библиотека цветов приложения
abstract class AppColors {
  /// transparent
  static Color get transparent => Colors.transparent;

  /// transparent
  static Color get error => const Color(0xFFFD575A);

  //== Black&WhitePrimary==//
  ///
  static Color get bwBrightPrimary => _isDark
      ? DarkColorTheme.bwBrightPrimary
      : LightColorTheme.bwBrightPrimary;

  //== Black&White Gray ==//
  ///
  static Color get bwGrayBright =>
      _isDark ? DarkColorTheme.bwGrayBright : LightColorTheme.bwGrayBright;

  ///
  static Color get bwGrayMid =>
      _isDark ? DarkColorTheme.bwGrayMid : LightColorTheme.bwGrayMid;

  ///
  static Color get bwGrayDull =>
      _isDark ? DarkColorTheme.bwGrayDull : LightColorTheme.bwGrayDull;

  //== Primary ==//
  ///
  static Color get primaryBright =>
      _isDark ? DarkColorTheme.primaryBright : LightColorTheme.primaryBright;

  ///
  static Color get primaryMid =>
      _isDark ? DarkColorTheme.primaryMid : LightColorTheme.primaryMid;

  ///
  static Color get primaryDull =>
      _isDark ? DarkColorTheme.primaryDull : LightColorTheme.primaryDull;

  //== Positive ==//
  ///
  static Color get positiveBright =>
      _isDark ? DarkColorTheme.positiveBright : LightColorTheme.positiveBright;

  ///
  static Color get positiveMid =>
      _isDark ? DarkColorTheme.positiveMid : LightColorTheme.positiveMid;

  ///
  static Color get positiveDull =>
      _isDark ? DarkColorTheme.positiveDull : LightColorTheme.positiveDull;

//== Positive / contrast ==//
  ///
  static Color get positiveContrastBright => _isDark
      ? DarkColorTheme.positiveContrastBright
      : LightColorTheme.positiveContrastBright;

  ///
  static Color get positiveContrastMid => _isDark
      ? DarkColorTheme.positiveContrastMid
      : LightColorTheme.positiveContrastMid;

  ///
  static Color get positiveContrastDull => _isDark
      ? DarkColorTheme.positiveContrastDull
      : LightColorTheme.positiveContrastDull;

  //== Positive / light ==//
  ///
  static Color get positiveLightBright => _isDark
      ? DarkColorTheme.positiveLightBright
      : LightColorTheme.positiveLightBright;

  ///
  static Color get positiveLightMid => _isDark
      ? DarkColorTheme.positiveLightMid
      : LightColorTheme.positiveLightMid;

  ///
  static Color get positiveLightDull => _isDark
      ? DarkColorTheme.positiveLightDull
      : LightColorTheme.positiveLightDull;

  //== Negative ==//
  ///
  static Color get negativeBright =>
      _isDark ? DarkColorTheme.negativeBright : LightColorTheme.negativeBright;

  ///
  static Color get negativeMid =>
      _isDark ? DarkColorTheme.negativeMid : LightColorTheme.negativeMid;

  ///
  static Color get negativeDull =>
      _isDark ? DarkColorTheme.negativeDull : LightColorTheme.negativeDull;

  //== Negative / contrast ==//
  ///
  static Color get negativeContrastBright => _isDark
      ? DarkColorTheme.negativeContrastBright
      : LightColorTheme.negativeContrastBright;

  ///
  static Color get negativeContrastMid => _isDark
      ? DarkColorTheme.negativeContrastMid
      : LightColorTheme.negativeContrastMid;

  ///
  static Color get negativeContrastDull => _isDark
      ? DarkColorTheme.negativeContrastDull
      : LightColorTheme.negativeContrastDull;

  //== Negative / light ==//
  ///
  static Color get negativeLightBright => _isDark
      ? DarkColorTheme.negativeLightBright
      : LightColorTheme.negativeLightBright;

  ///
  static Color get negativeLightMid => _isDark
      ? DarkColorTheme.negativeLightMid
      : LightColorTheme.negativeLightMid;

  ///
  static Color get negativeLightDull => _isDark
      ? DarkColorTheme.negativeLightDull
      : LightColorTheme.negativeLightDull;

  //== Blue violet ==//
  ///
  static Color get blueVioletBright => _isDark
      ? DarkColorTheme.blueVioletBright
      : LightColorTheme.blueVioletBright;

  ///
  static Color get blueVioletMid =>
      _isDark ? DarkColorTheme.blueVioletMid : LightColorTheme.blueVioletMid;

  ///
  static Color get blueVioletDull =>
      _isDark ? DarkColorTheme.blueVioletDull : LightColorTheme.blueVioletDull;

  //== Buttons / lime ==//
  ///
  static Color get buttonsLimeBright => _isDark
      ? DarkColorTheme.buttonsLimeBright
      : LightColorTheme.buttonsLimeBright;

  ///
  static Color get buttonsLimeMid =>
      _isDark ? DarkColorTheme.buttonsLimeMid : LightColorTheme.buttonsLimeMid;

  ///
  static Color get buttonsLimeDull => _isDark
      ? DarkColorTheme.buttonsLimeDull
      : LightColorTheme.buttonsLimeDull;

  //== Buttons / bw ==//
  ///
  static Color get buttonsBWBright => _isDark
      ? DarkColorTheme.buttonsBWBright
      : LightColorTheme.buttonsBWBright;

  ///
  static Color get buttonsBWMid =>
      _isDark ? DarkColorTheme.buttonsBWMid : LightColorTheme.buttonsBWMid;

  ///
  static Color get buttonsBWDull =>
      _isDark ? DarkColorTheme.buttonsBWDull : LightColorTheme.buttonsBWDull;

  //== Buttons / lavender ==//
  ///
  static Color get buttonsLavenderBright => _isDark
      ? DarkColorTheme.buttonsLavenderBright
      : LightColorTheme.buttonsLavenderBright;

  ///
  static Color get buttonsLavenderMid => _isDark
      ? DarkColorTheme.buttonsLavenderMid
      : LightColorTheme.buttonsLavenderMid;

  ///
  static Color get buttonsLavenderDull => _isDark
      ? DarkColorTheme.buttonsLavenderDull
      : LightColorTheme.buttonsLavenderDull;

  //== Buttons / blue ==//
  ///
  static Color get buttonsBlueBright => _isDark
      ? DarkColorTheme.buttonsBlueBright
      : LightColorTheme.buttonsBlueBright;

  ///
  static Color get buttonsBlueMid =>
      _isDark ? DarkColorTheme.buttonsBlueMid : LightColorTheme.buttonsBlueMid;

  ///
  static Color get buttonsBlueDull => _isDark
      ? DarkColorTheme.buttonsBlueDull
      : LightColorTheme.buttonsBlueDull;

  //== Buttons / violet ==//
  ///
  static Color get buttonsVioletBright => _isDark
      ? DarkColorTheme.buttonsVioletBright
      : LightColorTheme.buttonsVioletBright;

  ///
  static Color get buttonsVioletMid => _isDark
      ? DarkColorTheme.buttonsVioletMid
      : LightColorTheme.buttonsVioletMid;

  ///
  static Color get buttonsVioletDull => _isDark
      ? DarkColorTheme.buttonsVioletDull
      : LightColorTheme.buttonsVioletDull;

  //== Gray ==//
  ///
  static Color get grayBright =>
      _isDark ? DarkColorTheme.grayBright : LightColorTheme.grayBright;

  ///
  static Color get grayMid =>
      _isDark ? DarkColorTheme.grayMid : LightColorTheme.grayMid;

  ///
  static Color get grayDull =>
      _isDark ? DarkColorTheme.grayDull : LightColorTheme.grayDull;

  //== Dim ==//
  ///
  static Color get dimDark =>
      _isDark ? DarkColorTheme.dimDark : LightColorTheme.dimDark;

  //== Black ==//
  ///
  static Color get blackBright =>
      _isDark ? DarkColorTheme.blackBright : LightColorTheme.blackBright;

  //== accents ==//
  ///
  static Color get pattentsBlue =>
      _isDark ? DarkColorTheme.pattentsBlue : LightColorTheme.pattentsBlue;

  ///
  static Color get magnolia =>
      _isDark ? DarkColorTheme.magnolia : LightColorTheme.magnolia;

  ///
  static Color get peach =>
      _isDark ? DarkColorTheme.peach : LightColorTheme.peach;

  ///
  static Color get fuchsia =>
      _isDark ? DarkColorTheme.fuchsia : LightColorTheme.fuchsia;

  ///
  static Color get reed => _isDark ? DarkColorTheme.reed : LightColorTheme.reed;

  ///
  static Color get blue => _isDark ? DarkColorTheme.blue : LightColorTheme.blue;

  ///
  static Color get pattensBlue =>
      _isDark ? DarkColorTheme.pattensBlue : LightColorTheme.pattensBlue;
}
