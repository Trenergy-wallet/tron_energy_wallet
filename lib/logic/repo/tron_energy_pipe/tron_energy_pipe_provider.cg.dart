import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/tron_energy/tron_energy.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/tron_energy_pipe_provider.cg.g.dart';

/// Контроллер Transactions  для полуучения списка валют
@Riverpod(keepAlive: true)
class TronEnergyPipeService extends _$TronEnergyPipeService {
  @override
  Future<TronEnergyPipe> build() async {
    final res = await ref.read(repoProvider).tronEnergyPipe.getTronEnergyPipe();
    return await res.fold(
      (l) {
        showError(l);
        return TronEnergyPipe.empty;
      },
      (r) {
        return r;
      },
    );
  }
}
