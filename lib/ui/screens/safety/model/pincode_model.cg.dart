import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/pincode_model.cg.f.dart';

/// Модель для изменения пин кода
@freezed
class ChangePinCodeModel with _$ChangePinCodeModel {
  /// Модель для изменения пин кода
  const factory ChangePinCodeModel({
    @Default(false) bool isAllGood,
    @Default(false) bool isError,
    @Default(false) bool isLoading,
    @Default('') String uiPin,
    @Default(6) int pinLength,
  }) = _ChangePinCodeModel;
}
