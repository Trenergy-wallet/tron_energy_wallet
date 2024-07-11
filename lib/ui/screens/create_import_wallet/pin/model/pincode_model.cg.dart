import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/pincode_model.cg.f.dart';

/// Модель пин кода
@freezed
class PinCodeModel with _$PinCodeModel {
  /// Модель пин кода
  const factory PinCodeModel({
    @Default(false) bool isAllGood,
    @Default(false) bool isError,
    @Default([]) List<int> pin,
    @Default([]) List<int> repeatedPin,
    @Default([]) List<int> uiPin,
    @Default(6) int pinLength,
  }) = _PinCodeModel;
}
