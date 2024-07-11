import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/boost_order.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/order.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/resource_consumptions.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/resource_cost.cg.dart';

part 'gen/consumers.cg.f.dart';

/// Domain для данных, передаваемых в ендпойнте.
@freezed
class Consumers with _$Consumers {
  /// Domain для данных, передаваемых в ендпойнте.
  const factory Consumers({
    required int id,
    required String name,
    required String address,
    required int resourceAmount,
    required int creationType,
    required int consumptionType,
    required int paymentPeriod,
    required bool autoRenewal,
    required ResourceConsumptions resourceConsumptions,
    required ResourceCost resourceCost,
    required bool isActive,
    required Order order,
    required BoostOrder boostOrder,
    required String createdAt,
    required String updatedAt,
  }) = _Consumers;

  /// заглушка
  static const Consumers empty = Consumers(
    id: 0,
    name: '',
    address: '',
    resourceAmount: 0,
    creationType: 0,
    consumptionType: 0,
    paymentPeriod: 0,
    autoRenewal: false,
    resourceConsumptions: ResourceConsumptions.empty,
    resourceCost: ResourceCost.empty,
    isActive: false,
    order: Order.empty,
    boostOrder: BoostOrder.empty,
    createdAt: '',
    updatedAt: '',
  );
}

/// Сокращатель.
typedef ErrOrConsumers = Either<ExtendedErrors, List<Consumers>>;

/// Сокращатель.
typedef ErrOrConsumersStore = Either<ExtendedErrors, Consumers>;

///
typedef ErrOrUniqueAddresses = Either<ExtendedErrors, List<String>>;
