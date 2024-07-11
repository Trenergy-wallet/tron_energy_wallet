import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/chart/chart_historical.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/chart/repo/chart_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория кошельков
@riverpod
ChartRepo chart(ChartRef ref) => RemoteChartImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteChartImpl implements ChartRepo {
  /// Имплементация удаленного репозитария.
  RemoteChartImpl(this.ref)
      : _client =
            _ChartClient(ref.read(dioProvider(AppConfig.apiEndpointChart)));

  ///
  final Ref ref;

  final _ChartClient _client;

  @override
  Future<ErrOrChartIntraday> getChart({
    required String currency,
  }) {
    return safeFunc(() async {
      final dto = await _client.getChart(
        currency: currency,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrChartIntraday> getIntraDay({
    required String currency,
    required String from,
    required String to,
    required String timeIntraday,
  }) {
    return safeFunc(() async {
      final dto = await _client.getIntraDay(
        currency: currency,
        from: from,
        to: to,
        timeIntraday: timeIntraday,
      );
      final domain = safeToDomain(
        () => Right(dto.map((e) => e.toDomain()).toList()),
        status: true,
        response: dto.map((e) => e.toDomain()).toList(),
      );

      return domain;
    });
  }
}
