import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/chart/chart_historical.cg.dart';

/// Интерфейс chart репозитория
abstract interface class ChartRepo {
  ///
  Future<ErrOrChartIntraday> getChart({
    required String currency,
  });

  ///
  Future<ErrOrChartIntraday> getIntraDay({
    required String currency,
    required String from,
    required String to,
    required String timeIntraday,
  });
}

///
typedef ErrOrChartIntraday = Either<ExtendedErrors, List<Historical>>;

///
typedef ErrOrChartHistorical = Either<ExtendedErrors, ChartHistorical>;
