import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';

part 'gen/meta.cg.f.dart';

/// Meta данные
@freezed
class Meta with _$Meta {
  /// Meta данные
  const factory Meta({
    required int currentPage,
    required int from,
    required int lastPage,
    required List<Link> links,
    required String path,
    required int perPage,
    required int to,
    required int total,
  }) = _Meta;

  /// Заглушка
  static const empty = Meta(
    currentPage: 0,
    from: 0,
    lastPage: 0,
    links: [],
    path: '',
    perPage: 0,
    to: 0,
    total: 0,
  );
}

/// ссылки на страницы
@freezed
class Link with _$Link {
  /// ссылки на страницы
  const factory Link({
    required String url,
    required String label,
    required bool active,
  }) = _Link;

  /// Заглушка
  static const empty = Link(
    url: '',
    label: '',
    active: false,
  );
}

/// сокращатель
typedef ErrOrMeta = Either<ExtendedErrors, Meta>;
