import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide SizeExtension;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';

part 'gen/adaptive_ext.cg.f.dart';

/// Размеры дизайна по фигме в пикселях Size(393, 852)
const figmaSize = Size(393, 852);

/// Решено было попробовать 2 варианта адаптировать шрифты -
/// либо по стандарту .sp либо по общему коэффициенту
/// [nope] - адаптивность отключена
/// [total] - адаптивность включает изменение текста по общим правилам (radius)
/// [noText] - текст по своим правилам
/// UPDATE 05.02.23: сейчас мы испльзуем только адаптиность по минимальному
/// коээфициенту r для ширины, для высот НЕ испльзуем адаптивность (за
/// ислючением элементов с фиксированными пропорциями (например, если надо
/// вывести квадрат)
enum AdaptiveType {
  /// Не используем адаптивность
  nope,

  /// Все адаптивно
  total,

  /// Все кроме текста адаптивно
  noText
}

/// Текущий вариант адаптивности для посторения интерфейса
AdaptiveType adaptiveType = AdaptiveType.total;

bool get _nope => adaptiveType == AdaptiveType.nope;

// bool get _noText => adaptiveType.value == AdaptiveType.noText;

// ignore: unused_element
// bool get _total => adaptiveType == AdaptiveType.total;

final _su = ScreenUtil();

// ignore: public_member_api_docs
double? get pixelRatio => _su.pixelRatio;

// ignore: public_member_api_docs
double get screenWidth => _su.screenWidth;

// ignore: public_member_api_docs
double get scaleWidth => _su.scaleWidth;

// ignore: public_member_api_docs
double get screenHeight => _su.screenHeight;

// ignore: public_member_api_docs
double get scaleHeight => _su.scaleHeight;

/// История тянется от Fold экранов.
///
/// Для них есть доп.опции в [MediaQuery], и их тоже немало.
/// И разбираться с ними можно долго, для этого необходимо
/// иметь соответствующие эмуляторы, железки и Фигму под них.
///
/// Хорошо рассказано и показано тут https://www.youtube.com/watch?v=8DyVSUKoh0M.
///
/// Вкратце, сохраняем дополнительные коэффициенты отличия
/// размеров реального экрана от [figmaSize],
/// а так же разбираем [MediaQuery]` displayFeatures.
///
/// Их взаимосвязь поможет нам правильно рассчитать адаптивные коэффициенты
/// для [ScreenUtilInit], понять, какие фичи есть у экрана устройства
/// и как располагать диалоговые окна.
AppDisplayFeature initAppDisplayFeature(MediaQueryData value) {
  appDisplayFeature = AppDisplayFeature(
    wRatio: value.size.width / figmaSize.width,
    hRatio: value.size.height / figmaSize.height,
  );

  final features = value.displayFeatures;
  if (features.isEmpty) {
    return appDisplayFeature;
  }

  if (features.any(
    (e) =>
        e.type == DisplayFeatureType.hinge || e.type == DisplayFeatureType.fold,
  )) {
    final df = features.firstWhere(
      (e) =>
          e.type == DisplayFeatureType.hinge ||
          e.type == DisplayFeatureType.fold,
      orElse: () => value.displayFeatures[0],
    );

    appDisplayFeature = appDisplayFeature.copyWith(
      state: df.bounds.left == 0
          ? AppDisplayFeatureState.horizontal
          : AppDisplayFeatureState.vertical,
      anchorPoint: df.bounds.left == 0 ? offsetToRightOrBottom : null,
    );
  }

  return appDisplayFeature;
}

/// Адаптированные под нас особенности экрана:
enum AppDisplayFeatureState {
  /// стандартный смартфон.
  standard,

  /// С горизонтальным сгибом.
  horizontal,

  /// С вертикальным сгибом.
  vertical,
}

/// Эмпирическое значение офсета для отображения диалога в правой
/// (для вертикалок) или нижней (для горизонталок) части экрана.
const offsetToRightOrBottom = Offset(1000, 1000);

/// Модель нужных свойств для правильного рендеринга на разных фичах.
///
/// wRatio: дополнительный коэффициент для ширины.
///
/// hRatio: дополнительный коэффициент для высоты.
///
/// anchorPoint: оффсет, необходимый для отображения диалогов.
///   его значение эмпирическое, как максимально(?) удаленная точка.
///
/// state: вычисленное значение для понимания типа экрана.
@freezed
class AppDisplayFeature with _$AppDisplayFeature {
  /// Модель нужных свойств для правильного рендеринга на разных фичах.
  const factory AppDisplayFeature({
    @Default(1.0) double wRatio,
    @Default(1.0) double hRatio,
    Offset? anchorPoint,
    @Default(AppDisplayFeatureState.standard) AppDisplayFeatureState state,
  }) = _AppDisplayFeature;

  const AppDisplayFeature._();

  /// Проперть-хелпер для state == AppDisplayFeatureState.standard
  bool get isStandard => state == AppDisplayFeatureState.standard;

  /// Проперть-хелпер для state == AppDisplayFeatureState.horizontal
  bool get isHorizontal => state == AppDisplayFeatureState.horizontal;

  /// Проперть-хелпер для state == AppDisplayFeatureState.vertical
  bool get isVertical => state == AppDisplayFeatureState.vertical;
}

/// Синглтон для модели фичей экрана.
AppDisplayFeature appDisplayFeature = const AppDisplayFeature();

/// Адаптивные расширения на num
extension NumX on num {
  /// Адаптивность "всегда по меньшему коэффициенту"
  ///
  /// 25/10/22 считаем пока по w, тк у нас только дизайн для вертикальных
  /// экранов
  double get r => _nope ? toDouble() : w;

  /// Адаптивность для текста вариативная
  ///
  /// 25/10/22 считаем пока по w, тк у нас только дизайн для вертикальных
  /// экранов
  // double get sp => _nope
  //     ? toDouble()
  //     : _noText
  //         ? _su.setSp(this)
  //         : _su.radius(this);

  double get sp => _nope ? toDouble() : w;

  /// Пока отключено.
  /// Адаптивность для высоты линии текста
  double get spLine => _nope ? toDouble() : toDouble();

  /// Адаптивность "по кэффициенту ширины" + дополнительный коэффициент
  /// из-за внесения корректив после `Fold`
  double get w =>
      _nope ? toDouble() : _su.setWidth(this) / appDisplayFeature.wRatio;

  /// Адаптивность "по кэффициенту высоты" + дополнительный коэффициент
  /// из-за внесения корректив после `Fold`
  double get h =>
      _nope ? toDouble() : _su.setHeight(this) / appDisplayFeature.hRatio;

  /// Адаптивность по высоте, без фолдабли.
  ///
  /// Для экранов, например, где надо эмулировать заполнение без прокрутки.
  double get hRatio => _nope ? toDouble() : _su.setHeight(this);
}

/// Создаем SizedBox из числа
extension SizedBoxX on num {
  /// Адаптивность высоты < 700 делется на 2
  SizedBox get sbHeightSmall {
    final isSmallScreen = screenHeight < Consts.smallScreenHeight;
    return SizedBox(height: isSmallScreen ? toDouble() / 2 : toDouble());
  }

  /// Адаптивность высоты "всегда по меньшему коэффициенту"
  SizedBox get sbHeightA => SizedBox(height: r);

  /// Без адаптивности
  SizedBox get sbHeight => SizedBox(height: toDouble());

  /// Адаптивность ширины "всегда по меньшему коэффициенту"
  SizedBox get sbWidthA => SizedBox(width: r);

  /// Без адаптивности
  SizedBox get sbWidth => SizedBox(width: toDouble());

  /// Адаптивность по высоте, без фолдабли.
  ///
  /// Для экранов, например, где надо эмулировать заполнение без прокрутки.
  SizedBox get sbHeightRatio => SizedBox(height: _su.setHeight(this));
}

/// Адаптивность по ширине, без фолдабли.
bool get isIpad => screenWidth >= 768;
