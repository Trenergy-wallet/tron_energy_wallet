import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/tron_scan/tron_scan.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/domain/tron_scan/tron_scan.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_scan/repo/tron_scan_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория кошельков
@riverpod
TronScanRepo tronScan(TronScanRef ref) => RemoteTronScanImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteTronScanImpl implements TronScanRepo {
  /// Имплементация удаленного репозитария.
  RemoteTronScanImpl(this.ref)
      : _client = _TronScanClient(
          ref.read(dioProvider(AppConfig.apiTronscan)),
        );

  ///
  final Ref ref;

  final _TronScanClient _client;

  @override
  Future<ErrOrTronScan> getTronScan({required String hash}) {
    return safeFunc(() async {
      final dto = await _client.getTronScan(hash: hash);
      final domain = dto.toDomain();
      return domain;
    });
  }
}
