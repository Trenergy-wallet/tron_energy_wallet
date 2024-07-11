import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/data/dto/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/repo/info_repo_base.dart';

part 'gen/currencies.cg.f.dart';
part 'gen/currencies.cg.g.dart';

/// DTO Currencies
@freezed
class CurrenciesDto with _$CurrenciesDto {
  /// DTO Currencies
  const factory CurrenciesDto({
    required bool status,
    Map<String, dynamic>? errors,
    List<CurrencyDto>? data,
  }) = _CurrenciesDto;

  const CurrenciesDto._();

  ///
  factory CurrenciesDto.fromJson(Map<String, dynamic> json) =>
      _$CurrenciesDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrListAppCurrency toDomain() {
    return safeToDomain(
      () => Right(data?.map((e) => e.toDomain()).toList() ?? []),
      status: status,
      errors: errors,
      response: data,
    );
  }
}
