import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/tron_energy/tron_energy.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/domain/tron_energy/tron_energy.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_energy_pipe/repo/tron_energy_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория кошельков
@riverpod
TronEnergyPipeRepo tronEnergyPipe(TronEnergyPipeRef ref) =>
    RemoteTronEnergyPipeImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteTronEnergyPipeImpl implements TronEnergyPipeRepo {
  /// Имплементация удаленного репозитария.
  RemoteTronEnergyPipeImpl(this.ref)
      : _client = _TronEnergyPipeClient(
          ref.read(dioProvider(AppConfig.apiEndpoint)),
        );

  ///
  final Ref ref;

  final _TronEnergyPipeClient _client;

  @override
  Future<ErrOrTronEnergyPipe> getTronEnergyPipe() {
    return safeFunc(() async {
      final dto = await _client.getTronEnergyPipe();
      final domain = dto.toDomain();
      return domain;
    });
  }
}
