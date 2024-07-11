import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/terms_model.cg.f.dart';

/// модель условий
@freezed
class TermsModel with _$TermsModel {
  /// модель условий
  const factory TermsModel({
    @Default(false) bool accepted,
    @Default('') String text,
  }) = _TermsModel;
}
