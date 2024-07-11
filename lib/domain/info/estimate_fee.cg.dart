import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';

part 'gen/estimate_fee.cg.f.dart';

///
@freezed
class EstimateFee with _$EstimateFee {
  ///
  const factory EstimateFee({
    required double trx,
    required double energy,
  }) = _EstimateFee;

  const EstimateFee._();

  /// константный синглтон для семантики "Отсутствие данных"
  static const empty = EstimateFee(
    trx: Consts.invalidDoubleValue,
    energy: Consts.invalidDoubleValue,
  );
}
