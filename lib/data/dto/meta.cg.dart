import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/domain/meta.cg.dart';

part 'gen/meta.cg.f.dart';
part 'gen/meta.cg.g.dart';

/// Meta данные
@freezed
class MetaDto with _$MetaDto {
  /// Meta данные
  const factory MetaDto({
    int? currentPage,
    int? from,
    int? lastPage,
    List<LinkDto>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) = _MetaDto;

  /// конструктор
  const MetaDto._();

  /// используем фабричный конструктор
  factory MetaDto.fromJson(Map<String, dynamic> json) =>
      _$MetaDtoFromJson(json);

  /// toDomain
  Meta toDomain() {
    return Meta(
      currentPage: ifNullPrintErrAndSet(
        data: currentPage,
        functionName: 'MetaDto.toDomain',
        variableName: 'currentPage',
        ifNullValue: 0,
      ),
      from: ifNullPrintErrAndSet(
        data: from,
        functionName: 'MetaDto.toDomain',
        variableName: 'from',
        ifNullValue: 0,
      ),
      lastPage: ifNullPrintErrAndSet(
        data: lastPage,
        functionName: 'MetaDto.toDomain',
        variableName: 'lastPage',
        ifNullValue: 0,
      ),
      path: ifNullPrintErrAndSet(
        data: path,
        functionName: 'MetaDto.toDomain',
        variableName: 'path',
        ifNullValue: '',
      ),
      perPage: ifNullPrintErrAndSet(
        data: perPage,
        functionName: 'MetaDto.toDomain',
        variableName: 'perPage',
        ifNullValue: 0,
      ),
      to: ifNullPrintErrAndSet(
        data: to,
        functionName: 'MetaDto.toDomain',
        variableName: 'to',
        ifNullValue: 0,
      ),
      total: ifNullPrintErrAndSet(
        data: total,
        functionName: 'MetaDto.toDomain',
        variableName: 'total',
        ifNullValue: 0,
      ),
      links: links?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

/// ссылки на страницы
@freezed
class LinkDto with _$LinkDto {
  /// ссылки на страницы
  const factory LinkDto({
    String? url,
    String? label,
    bool? active,
  }) = _LinkDto;

  /// конструктор
  const LinkDto._();

  /// используем фабричный конструктор
  factory LinkDto.fromJson(Map<String, dynamic> json) =>
      _$LinkDtoFromJson(json);

  /// toDomain
  Link toDomain() {
    return Link(
      url: url ?? '',
      label: label ?? '',
      active: active ?? false,
    );
  }
}
