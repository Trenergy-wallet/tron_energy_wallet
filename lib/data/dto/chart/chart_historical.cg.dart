import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/chart/chart_historical.cg.dart';
import 'package:trenergy_wallet/logic/repo/chart/repo/chart_repo_base.dart';

part 'gen/chart_historical.cg.f.dart';
part 'gen/chart_historical.cg.g.dart';

///
@freezed
class ChartHistoricalDto with _$ChartHistoricalDto {
  ///
  const factory ChartHistoricalDto({
    String? symbol,
    List<HistoricalDto>? historical,
  }) = _ChartHistoricalDto;

  const ChartHistoricalDto._();

  ///
  factory ChartHistoricalDto.fromJson(Map<String, dynamic> json) =>
      _$ChartHistoricalDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrChartIntraday toDomain() {
    final data = ChartHistorical(
      symbol: ifNullPrintErrAndSet(
        data: symbol,
        functionName: 'ChartHistoricalDto.toDomain',
        variableName: 'symbol',
        ifNullValue: '',
      ),
      historical: ifNullPrintErrAndSet(
        data: historical?.map((e) => e.toDomain()).toList(),
        functionName: 'ChartHistoricalDto.toDomain',
        variableName: 'historical',
        ifNullValue: [],
      ),
    );

    return safeToDomain(
      () => Right(data.historical),
      status: true,
      response: data,
    );
  }
}

/// DTO для котировок
@freezed
class HistoricalDto with _$HistoricalDto {
  /// DTO для котировок внутри дня
  const factory HistoricalDto({
    DateTime? date,
    double? open,
    double? low,
    double? high,
    double? close,
    double? volume,
  }) = _HistoricalDto;

  const HistoricalDto._();

  ///
  factory HistoricalDto.fromJson(Map<String, dynamic> json) =>
      _$HistoricalDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  Historical toDomain() {
    final data = Historical(
      date: ifNullPrintErrAndSet(
        data: date,
        functionName: 'HistoricalDto.toDomain',
        variableName: 'date',
        ifNullValue: Consts.invalidDateTime,
      ),
      open: ifNullPrintErrAndSet(
        data: open,
        functionName: 'HistoricalDto.toDomain',
        variableName: 'open',
        ifNullValue: Consts.invalidDoubleValue,
      ),
      low: ifNullPrintErrAndSet(
        data: low,
        functionName: 'HistoricalDto.toDomain',
        variableName: 'low',
        ifNullValue: Consts.invalidDoubleValue,
      ),
      high: ifNullPrintErrAndSet(
        data: high,
        functionName: 'HistoricalDto.toDomain',
        variableName: 'high',
        ifNullValue: Consts.invalidDoubleValue,
      ),
      close: ifNullPrintErrAndSet(
        data: close,
        functionName: 'HistoricalDto.toDomain',
        variableName: 'close',
        ifNullValue: Consts.invalidDoubleValue,
      ),
      volume: ifNullPrintErrAndSet(
        data: volume,
        functionName: 'HistoricalDto.toDomain',
        variableName: 'volume',
        ifNullValue: Consts.invalidDoubleValue,
      ),
    );

    return data;
  }

  /// Защищенное конвертирование в доменный тип.
}
