import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/confirm_seed_model.cg.f.dart';

/// Модель для подтверждения мнемонической фразы
@freezed
class ConfirmSeedModel with _$ConfirmSeedModel {
  /// Модель для подтверждения мнемонической фразы
  const factory ConfirmSeedModel({
    required int findNumber,
    required List<String> findSeedWord,
  }) = _ConfirmSeedModel;
}
