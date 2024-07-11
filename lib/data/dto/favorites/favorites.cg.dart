import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/favorites/favorites.cg.dart';
import 'package:trenergy_wallet/logic/repo/favorites/repo/favorites_repo_base.dart';

part 'gen/favorites.cg.f.dart';
part 'gen/favorites.cg.g.dart';

/// DTO для Favorites
@freezed
class FavoritesDto with _$FavoritesDto {
  /// DTO для Favorites
  const factory FavoritesDto({
    required bool status,
    Map<String, dynamic>? errors,
    List<FavoritesDataDto>? data,
  }) = _FavoritesDto;

  const FavoritesDto._();

  ///
  factory FavoritesDto.fromJson(Map<String, dynamic> json) =>
      _$FavoritesDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrFavorites toDomain() {
    return safeToDomain(
      () => Right(data?.map((e) => e.toDomain()).toList() ?? []),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

/// DTO FavoritesDataDto
@freezed
class FavoritesDataDto with _$FavoritesDataDto {
  /// DTO FavoritesDataDto
  const factory FavoritesDataDto({
    int? id,
    String? name,
    String? address,
  }) = _FavoritesDataDto;

  const FavoritesDataDto._();

  ///
  factory FavoritesDataDto.fromJson(Map<String, dynamic> json) =>
      _$FavoritesDataDtoFromJson(json);

  /// Конвертим в домен.
  Favorites toDomain() {
    return Favorites(
      id: ifNullPrintErrAndSet(
        data: id,
        functionName: 'FavoritesDataDto.toDomain',
        variableName: 'id',
        ifNullValue: Consts.invalidIntValue,
      ),
      name: ifNullPrintErrAndSet(
        data: name,
        functionName: 'FavoritesDataDto.toDomain',
        variableName: 'name',
        ifNullValue: '',
      ),
      address: ifNullPrintErrAndSet(
        data: address,
        functionName: 'FavoritesDataDto.toDomain',
        variableName: 'address',
        ifNullValue: '',
      ),
    );
  }
}
