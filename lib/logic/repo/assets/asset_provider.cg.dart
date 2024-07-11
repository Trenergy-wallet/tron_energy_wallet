import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/asset_provider.cg.g.dart';

/// Контроллер Asset
@riverpod
class AssetService extends _$AssetService {
  @override
  bool build() {
    return false;
  }

  /// Обновить активный токен

  Future<void> refreshAsset({
    required int assetId,
    required int walletId,
  }) async {
    final res = await ref.read(repoProvider).assets.refreshAsset(
          walletId: walletId,
          assetId: assetId,
        );

    await res.fold(
      showError,
      (r) {},
    );
  }
}
