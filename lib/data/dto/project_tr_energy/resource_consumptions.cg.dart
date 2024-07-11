import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/resource_consumptions.cg.dart';

part 'gen/resource_consumptions.cg.f.dart';
part 'gen/resource_consumptions.cg.g.dart';

/// ДТО для данных, передаваемых в ендпойнте.
@freezed
class ResourceConsumptionsDto with _$ResourceConsumptionsDto {
  /// ДТО для данных, передаваемых в ендпойнте.
  const factory ResourceConsumptionsDto({
    DateTime? day,
    int? txCount,
    int? energyAmount,
    double? normalCostTrx,
    double? trenergyCostTrx,
  }) = _ResourceConsumptionsDto;

  const ResourceConsumptionsDto._();

  ///
  factory ResourceConsumptionsDto.fromJson(Map<String, dynamic> json) =>
      _$ResourceConsumptionsDtoFromJson(json);

  /// toDomain
  ResourceConsumptions toDomain() {
    return ResourceConsumptions(
      txCount: ifNullPrintErrAndSet(
        data: txCount,
        functionName: 'ResourceConsumptionsDto.toDomain',
        variableName: 'txCount',
        ifNullValue: 0,
      ),
      energyAmount: ifNullPrintErrAndSet(
        data: energyAmount,
        functionName: 'ResourceConsumptionsDto.toDomain',
        variableName: 'energyAmount',
        ifNullValue: 0,
      ),
      normalCostTrx: ifNullPrintErrAndSet(
        data: normalCostTrx,
        functionName: 'ResourceConsumptionsDto.toDomain',
        variableName: 'normalCostTrx',
        ifNullValue: 0,
      ),
      trenergyCostTrx: ifNullPrintErrAndSet(
        data: trenergyCostTrx,
        functionName: 'ResourceConsumptionsDto.toDomain',
        variableName: 'trenergyCostTrx',
        ifNullValue: 0,
      ),
    );
  }
}
