import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/resource_cost.cg.dart';

part 'gen/resource_cost.cg.f.dart';
part 'gen/resource_cost.cg.g.dart';

/// ДТО для данных, передаваемых в ендпойнте.
@freezed
class ResourceCostDto with _$ResourceCostDto {
  /// ДТО для данных, передаваемых в ендпойнте.
  const factory ResourceCostDto({
    double? normalTrx,
    int? trenergyTrx,
  }) = _ResourceCostDto;

  const ResourceCostDto._();

  ///
  factory ResourceCostDto.fromJson(Map<String, dynamic> json) =>
      _$ResourceCostDtoFromJson(json);

  /// toDomain
  ResourceCost toDomain() {
    return ResourceCost(
      normalTrx: ifNullPrintErrAndSet(
        data: normalTrx,
        functionName: 'ResourceCostDto.toDomain',
        variableName: 'normalTrx',
        ifNullValue: 0,
      ),
      trenergyTrx: ifNullPrintErrAndSet(
        data: trenergyTrx,
        functionName: 'ResourceCostDto.toDomain',
        variableName: 'trenergyTrx',
        ifNullValue: 0,
      ),
    );
  }
}
