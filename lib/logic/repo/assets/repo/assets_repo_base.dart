import 'package:trenergy_wallet/domain/empty_data.cg.dart';

/// Интерфейс Assets репозитория
abstract interface class AssetsRepo {
  ///  Refresh Asset Balance
  Future<ErrOrEmptyData> refreshAsset({
    required int walletId,
    required int assetId,
  });

  ///  Assets
  Future<ErrOrEmptyData> addAssets({
    required int walletId,
    required List<int> tokensId,
  });

  ///  Assets
  Future<ErrOrEmptyData> removeAssets({
    required int walletId,
    required List<int> tokensId,
  });
}
