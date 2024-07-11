import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/empty_dto.cg.dart';
import 'package:trenergy_wallet/data/dto/project_tr_energy/acc_tron_energy.cg.dart';
import 'package:trenergy_wallet/data/dto/project_tr_energy/consumers.cg.dart';
import 'package:trenergy_wallet/data/dto/project_tr_energy/wallet_top_up.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/domain/empty_data.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/consumers.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/wallet_top_up.cg.dart';
import 'package:trenergy_wallet/logic/repo/project_tr_energy/repo/project_tr_energy_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория кошельков
@riverpod
TronEnergyProjectRepo tronEnergyProject(TronEnergyProjectRef ref) =>
    RemoteTronEnergyProjectImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteTronEnergyProjectImpl implements TronEnergyProjectRepo {
  /// Имплементация удаленного репозитария.
  RemoteTronEnergyProjectImpl(this.ref)
      : _client = _TronEnergyProjectClient(
          ref.read(dioProvider(AppConfig.apiTrEnergy)),
        );

  ///
  final Ref ref;

  final _TronEnergyProjectClient _client;

  @override
  Future<ErrOrAccountTrEnergy> fetchAccount() {
    return safeFunc(() async {
      final dto = await _client.fetchAccount();
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrWalletTopUp> fetchWalletTopUp() {
    return safeFunc(() async {
      final dto = await _client.fetchWalletTopUp();
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrConsumersStore> postConsumers(ConsumersBody body) {
    return safeFunc(() async {
      final dto = await _client.postConsumers(body);
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> activate({required int consumerId}) {
    return safeFunc(() async {
      final dto = await _client.activate(consumerId: consumerId);
      final domain = dto.toDomain();
      return domain;
    });
  }
}
