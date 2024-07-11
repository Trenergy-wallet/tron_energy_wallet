import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';

part 'gen/empty_data.cg.f.dart';

/// EmptyData
@freezed
class EmptyData with _$EmptyData {
  /// EmptyData
  const factory EmptyData({
    required Map<dynamic, dynamic> data,
  }) = _EmptyData;
}

///
typedef ErrOrEmptyData = Either<ExtendedErrors, Map<dynamic, dynamic>>;
