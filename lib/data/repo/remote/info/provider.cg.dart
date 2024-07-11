import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/info/blockchains.cg.dart';
import 'package:trenergy_wallet/data/dto/info/currencies.cg.dart';
import 'package:trenergy_wallet/data/dto/info/estimate_fee.cg.dart';
import 'package:trenergy_wallet/data/dto/info/wallet_type_check.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet_type.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/repo/info_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория currency
@riverpod
InfoRepo info(InfoRef ref) => RemoteInfoImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteInfoImpl implements InfoRepo {
  /// Имплементация удаленного репозитария.
  RemoteInfoImpl(this.ref)
      : _client = _InfoClient(ref.read(dioProvider(AppConfig.apiEndpoint)));

  ///
  final Ref ref;

  final _InfoClient _client;

  @override
  Future<ErrOrListAppBlockchain> getListBlockchains() {
    return safeFunc(() async {
      final dto = await _client.getListBlockchains();
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrListAppCurrency> getListCurrency() {
    return safeFunc(() async {
      final dto = await _client.getListCurrency();
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrWalletTypeCheck> walletTypeCheck({required String address}) {
    return safeFunc(() async {
      final dto = await _client.walletTypeCheck(address: address);
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEstimateFee> estimateFee() {
    return safeFunc(() async {
      final dto = await _client.estimateFee();
      final domain = dto.toDomain();
      return domain;
    });
  }
}
