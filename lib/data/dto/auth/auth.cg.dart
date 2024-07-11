import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/auth/auth.cg.dart';
import 'package:trenergy_wallet/logic/repo/auth/repo/auth_repo_base.dart';

part 'gen/auth.cg.f.dart';
part 'gen/auth.cg.g.dart';

/// DTO для 1.1 Get Auth Message
@freezed
class AuthDto with _$AuthDto {
  /// DTO для ендпойнта 9.1
  const factory AuthDto({
    required bool status,
    Map<String, dynamic>? errors,
    AuthDataDto? data,
  }) = _AuthDto;

  const AuthDto._();

  ///
  factory AuthDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrAuth toDomain() {
    return safeToDomain(
      () => Right(data?.toDomain() ?? Auth.empty),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

/// DTO для ендпойнта 1.1
@freezed
class AuthDataDto with _$AuthDataDto {
  /// DTO для ендпойнта 1.1
  const factory AuthDataDto({
    String? message,
  }) = _AuthDataDto;

  const AuthDataDto._();

  ///
  factory AuthDataDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDataDtoFromJson(json);

  /// Конвертим в домен.
  Auth toDomain() {
    return Auth(
      message: ifNullPrintErrAndSet(
        data: message,
        functionName: 'AuthDataDto.toDomain',
        variableName: 'message',
        ifNullValue: '',
      ),
    );
  }
}
