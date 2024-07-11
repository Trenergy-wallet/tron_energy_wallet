import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/bottom_sheet_model.cg.f.dart';

/// Модель настроек BottomSheet
@freezed
class BottomSheetModel with _$BottomSheetModel {
  /// Модель настроек BottomSheet
  const factory BottomSheetModel({
    //== Настройки header ==/
    /// Заголовок
    required String title,

    /// Кнопка закрытия
    required void Function() onTapClose,

    /// Кнопка назад
    required void Function()? onTapBack,

    //== Настройки по UI ==/
    ///
    required Widget child,

    /// Цвет фона
    Color? colorBg,

    /// высота BottomSheet
    @Default(300.0) double height,

    /// Задать высоту по умолчанию
    @Default(300.0) double defHeight,

    /// открыт ли bottom sheet
    required bool isActiveSheet,

    /// Есть ли внутренний скролл
    required bool hasInsideScroll,

    /// Функция нажатия на фон
    void Function()? onTapBackground,
  }) = _BottomSheetModel;

  /// Кнопка назад
  /// заглушка
  static BottomSheetModel empty = BottomSheetModel(
    child: const SizedBox.shrink(),
    title: '',
    isActiveSheet: false,
    hasInsideScroll: true,
    onTapBack: null,
    onTapClose: () {},
  );
}
