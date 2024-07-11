import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';

part 'gen/chart_historical.cg.f.dart';

///
@freezed
class ChartHistoricalFiltred with _$ChartHistoricalFiltred {
  ///
  const factory ChartHistoricalFiltred({
    List<Historical>? targetHours,
    List<Historical>? targetDay,
    List<Historical>? targetWeek,
    List<Historical>? targetMonth,
    List<Historical>? targetYear,
    List<Historical>? targetAll,
  }) = _ChartHistoricalFiltred;
}

///
@freezed
class ChartHistorical with _$ChartHistorical {
  ///
  const factory ChartHistorical({
    required String symbol,
    required List<Historical> historical,
  }) = _ChartHistorical;

  /// Заглушка
  static const empty = ChartHistorical(
    symbol: '',
    historical: [],
  );
}

/// Historical
@freezed
class Historical with _$Historical {
  ///
  const factory Historical({
    required DateTime date,
    required double open,
    required double low,
    required double high,
    required double close,
    required double volume,
  }) = _Historical;

  /// Заглушка
  static final empty = Historical(
    date: Consts.invalidDateTime,
    open: Consts.invalidDoubleValue,
    low: Consts.invalidDoubleValue,
    high: Consts.invalidDoubleValue,
    close: Consts.invalidDoubleValue,
    volume: Consts.invalidDoubleValue,
  );
}
