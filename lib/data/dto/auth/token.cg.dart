import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/auth/token.cg.dart';
import 'package:trenergy_wallet/logic/repo/auth/repo/auth_repo_base.dart';

part 'gen/token.cg.f.dart';
part 'gen/token.cg.g.dart';

/// DTO для ендпойнта 1.2 Post Auth Message
@freezed
class TokenDto with _$TokenDto {
  /// DTO для ендпойнта 1.2 Post Auth Message
  const factory TokenDto({
    required bool status,
    Map<String, dynamic>? errors,
    TokenDataDto? data,
  }) = _TokenDto;

  const TokenDto._();

  ///
  factory TokenDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrToken toDomain() {
    return safeToDomain(
      () => Right(data?.toDomain() ?? Token.empty),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

/// DTO для ендпойнта 1.2 Post Auth Message
@freezed
class TokenDataDto with _$TokenDataDto {
  /// DTO для ендпойнта 9.1
  const factory TokenDataDto({
    String? token,
  }) = _TokenDataDto;

  const TokenDataDto._();

  ///
  factory TokenDataDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDataDtoFromJson(json);

  /// Конвертим в домен.
  Token toDomain() {
    return Token(
      token: ifNullPrintErrAndSet(
        data: token,
        functionName: 'TokenDataDto.toDomain',
        variableName: 'token',
        ifNullValue: '',
      ),
    );
  }
}
