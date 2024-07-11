import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/data/dto/project_tr_energy/boost_order.cg.dart';
import 'package:trenergy_wallet/data/dto/project_tr_energy/order.cg.dart';
import 'package:trenergy_wallet/data/dto/project_tr_energy/resource_consumptions.cg.dart';
import 'package:trenergy_wallet/data/dto/project_tr_energy/resource_cost.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/boost_order.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/consumers.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/order.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/resource_consumptions.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/resource_cost.cg.dart';

part 'gen/consumers.cg.f.dart';
part 'gen/consumers.cg.g.dart';

/// 5.10. Store
@JsonSerializable()
class ConsumersBody {
  /// 5.10. Store
  ConsumersBody({
    required this.paymentPeriod,
    required this.address,
    required this.resourceAmount,
    required this.autoRenewal,
    required this.consumptionType,
    required this.name,
  });

  ///
  factory ConsumersBody.fromJson(Map<String, dynamic> json) =>
      _$ConsumersBodyFromJson(json);

  /// Обязательно. Период оплаты (1/7/30)
  final String paymentPeriod;

  /// Обязательно. Адрес кошелька
  final String address;

  /// Обязательно. Кол-во ресурса
  final int resourceAmount;

  /// Обязательно. Автопродление (1/0)
  final int autoRenewal;

  /// Обязательно. Тип потребления (1 - стат, 2 - динам)
  final int consumptionType;

  /// Обязательно. Имя. Может быть пустым
  final String name;

  ///
  Map<String, dynamic> toJson() => _$ConsumersBodyToJson(this);
}

/// DTO для типа GET 5.1 и POST 5.10 5.10
@freezed
class ConsumersDto with _$ConsumersDto {
  /// DTO для типа GET 5.1 и POST 5.10 5.10
  const factory ConsumersDto({
    required bool status,
    Map<String, dynamic>? errors,
    List<ConsumersDataDto>? data,
  }) = _ConsumersDto;

  const ConsumersDto._();

  ///
  factory ConsumersDto.fromJson(Map<String, dynamic> json) =>
      _$ConsumersDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrConsumers toDomain() {
    return safeToDomain(
      () => Right(data?.map((e) => e.toDomain()).toList() ?? []),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

/// DTO для типа GET 5.1 и POST 5.10 5.10
@freezed
class ConsumersStoreDto with _$ConsumersStoreDto {
  /// DTO для типа GET 5.1 и POST 5.10 5.10
  const factory ConsumersStoreDto({
    required bool status,
    Map<String, dynamic>? errors,
    ConsumersDataDto? data,
  }) = _ConsumersStoreDto;

  const ConsumersStoreDto._();

  ///
  factory ConsumersStoreDto.fromJson(Map<String, dynamic> json) =>
      _$ConsumersStoreDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrConsumersStore toDomain() {
    return safeToDomain(
      () => Right(data?.toDomain() ?? Consumers.empty),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

/// ДТО для данных, передаваемых в ендпойнте.
@freezed
class ConsumersDataDto with _$ConsumersDataDto {
  /// ДТО для данных, передаваемых в ендпойнте.
  const factory ConsumersDataDto({
    int? id,
    String? name,
    String? address,
    int? resourceAmount,
    int? creationType,
    int? consumptionType,
    int? paymentPeriod,
    bool? autoRenewal,
    ResourceConsumptionsDto? resourceConsumptions,
    ResourceCostDto? resourceCost,
    bool? isActive,
    OrderDto? order,
    BoostOrderDto? boostOrder,
    String? createdAt,
    String? updatedAt,
  }) = _ConsumersDataDto;

  const ConsumersDataDto._();

  ///
  factory ConsumersDataDto.fromJson(Map<String, dynamic> json) =>
      _$ConsumersDataDtoFromJson(json);

  /// toDomain
  Consumers toDomain() {
    return Consumers(
      id: ifNullPrintErrAndSet(
        data: id,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'id',
        ifNullValue: 0,
      ),
      name: ifNullPrintErrAndSet(
        data: name,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'name',
        ifNullValue: '',
      ),
      address: ifNullPrintErrAndSet(
        data: address,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'address',
        ifNullValue: '',
      ),
      resourceAmount: ifNullPrintErrAndSet(
        data: resourceAmount,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'resourceAmount',
        ifNullValue: 0,
      ),
      creationType: ifNullPrintErrAndSet(
        data: creationType,
        functionName: 'ConsumersDataDto.toDomacreationType',
        variableName: 'id',
        ifNullValue: 0,
      ),
      consumptionType: ifNullPrintErrAndSet(
        data: consumptionType,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'consumptionType',
        ifNullValue: 0,
      ),
      paymentPeriod: ifNullPrintErrAndSet(
        data: paymentPeriod,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'paymentPeriod',
        ifNullValue: 0,
      ),
      autoRenewal: ifNullPrintErrAndSet(
        data: autoRenewal,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'autoRenewal',
        ifNullValue: false,
      ),
      isActive: ifNullPrintErrAndSet(
        data: isActive,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'isActive',
        ifNullValue: false,
      ),
      resourceConsumptions:
          resourceConsumptions?.toDomain() ?? ResourceConsumptions.empty,
      resourceCost: resourceCost?.toDomain() ?? ResourceCost.empty,
      order: order?.toDomain() ?? Order.empty,
      boostOrder: boostOrder?.toDomain() ?? BoostOrder.empty,
      createdAt: ifNullPrintErrAndSet(
        data: createdAt,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'createdAt',
        ifNullValue: '',
      ),
      updatedAt: ifNullPrintErrAndSet(
        data: updatedAt,
        functionName: 'ConsumersDataDto.toDomain',
        variableName: 'updatedAt',
        ifNullValue: '',
      ),
    );
  }
}
