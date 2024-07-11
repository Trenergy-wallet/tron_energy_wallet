import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/empty_data.cg.dart';

part 'gen/empty_dto.cg.f.dart';
part 'gen/empty_dto.cg.g.dart';

/// DTO для пустого ответа
@freezed
class EmptyDataDto with _$EmptyDataDto {
  /// DTO для ендпойнта 9.1
  const factory EmptyDataDto({
    required bool status,
    Map<String, dynamic>? errors,
    Map<dynamic, dynamic>? data,
  }) = _EmptyDataDto;

  const EmptyDataDto._();

  ///
  factory EmptyDataDto.fromJson(Map<String, dynamic> json) =>
      _$EmptyDataDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrEmptyData toDomain() {
    return safeToDomain(
      () => Right(data ?? {}),
      status: status,
      errors: errors,
      response: data,
    );
  }
}
