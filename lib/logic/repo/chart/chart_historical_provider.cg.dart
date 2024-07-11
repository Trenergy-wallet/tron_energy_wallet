import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/ext.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/domain/chart/chart_historical.cg.dart';
import 'package:trenergy_wallet/logic/repo/chart/enum/chart_enum.dart';
import 'package:trenergy_wallet/logic/repo/chart/repo/chart_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/chart_historical_provider.cg.g.dart';

/// Контроллер auth для полуучения и отправки контрольной подписи.
@Riverpod(keepAlive: true)
class ChartHistoricalService extends _$ChartHistoricalService {
  /// Repo local
  LocalRepo get localRepo => ref.read(repoProvider).local;

  @override
  ChartHistoricalFiltred build() {
    return const ChartHistoricalFiltred();
  }

  ///
  void clearAll() {
    state = const ChartHistoricalFiltred();
  }

  /// Запрос криптовалюты на график
  Future<void> fetchChart({required String currency}) async {
    clearAll();
    if (currency == Consts.tron) {
      currency = Consts.trx;
    }

    final now = DateTime.now();
    final weekDayEarlier = now.subtract(const Duration(days: 7));
    final oneDayEarlier = now.subtract(const Duration(days: 1));
    final oneHourEarlier = now.subtract(const Duration(hours: 1));

    final res = await Future.wait<ErrOrChartIntraday>([
      ref.read(repoProvider).chart.getChart(
            currency: '${currency}USD',
          ),
      ref.read(repoProvider).chart.getIntraDay(
            currency: '${currency}USD',
            from: weekDayEarlier.stringDateTimeForApi,
            to: now.stringDateTimeForApi,
            timeIntraday: '4hour',
          ),
      ref.read(repoProvider).chart.getIntraDay(
            currency: '${currency}USD',
            from: oneDayEarlier.stringDateTimeForApi,
            to: now.stringDateTimeForApi,
            timeIntraday: '15min',
          ),
      ref.read(repoProvider).chart.getIntraDay(
            currency: '${currency}USD',
            from: oneHourEarlier.stringDateTimeForApi,
            to: now.stringDateTimeForApi,
            timeIntraday: '1min',
          ),
    ]);

    final resAllYearsMonth = res[0];
    final resWeek = res[1];
    final resDay = res[2];
    final resHour = res[3];

    getChart(resAllYearsMonth);
    getWeek(resWeek);
    getDay(resDay);
    getHour(resHour);
  }

  /// Запрос криптовалюты на график
  void getChart(ErrOrChartIntraday res) {
    return res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) {
        final filteredByWeek = <Historical>[];
        final filteredByMonth = <Historical>[];
        final filteredByYear = <Historical>[];

        for (var i = 0; i < 14; i++) {
          filteredByWeek.add(r[i]);
        }
        for (var i = 0; i < 30; i++) {
          filteredByMonth.add(r[i]);
        }
        for (var i = 0; i < 365; i++) {
          filteredByYear.add(r[i]);
        }

        state = state.copyWith(
          targetMonth: filteredByMonth,
          targetYear: filteredByYear,
          targetAll: r,
        );
      },
    );
  }

  /// Запрос криптовалюты на график

  /// Запрос криптовалюты на график
  void getWeek(ErrOrChartIntraday res) {
    res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) {
        final timeNow = DateTime(
          now.year,
          now.month,
          now.day,
          now.hour,
        );
        final timeReceive = DateTime(
          r[0].date.year,
          r[0].date.month,
          r[0].date.day,
          r[0].date.hour,
        );

        /// так как с апи прилетает другое время находим разницу между текущим
        /// и добавляем к списку эту разницу, чтоб делать дальнейшие расчеты
        /// по текущему времени
        final difference = timeNow.difference(timeReceive);
        final readyHistory = <Historical>[];
        for (final d in r) {
          final addDifference = d.date.add(difference);
          final time = now.difference(addDifference);
          if (time.inDays < 7) {
            readyHistory.add(d);
          } else {
            /// выход за пределы 1 часа останавливаем цикл
            break;
          }
        }
        state = state.copyWith(targetWeek: readyHistory);
      },
    );
  }

  /// Запрос криптовалюты на график
  void getDay(ErrOrChartIntraday res) {
    res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) {
        final timeNow = DateTime(
          now.year,
          now.month,
          now.day,
        );
        final timeReceive = DateTime(
          r[0].date.year,
          r[0].date.month,
          r[0].date.day,
        );

        /// так как с апи прилетает другое время находим разницу между текущим
        /// и добавляем к списку эту разницу, чтоб делать дальнейшие расчеты
        /// по текущему времени
        final difference = timeNow.difference(timeReceive);
        final readyHistory = <Historical>[];
        for (final d in r) {
          final addDifference = d.date.add(difference);
          final time = now.difference(addDifference);
          if (time.inDays < 1) {
            readyHistory.add(d);
          } else {
            /// выход за пределы 1 часа останавливаем цикл
            break;
          }
        }
        state = state.copyWith(targetDay: readyHistory);
      },
    );
  }

  /// Запрос криптовалюты на график
  void getHour(ErrOrChartIntraday res) {
    res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) {
        final timeNow = DateTime(
          now.year,
          now.month,
          now.day,
          now.hour,
        );
        final timeReceive = DateTime(
          r[0].date.year,
          r[0].date.month,
          r[0].date.day,
          r[0].date.hour,
        );

        /// так как с апи прилетает другое время находим разницу между текущим
        /// и добавляем к списку эту разницу, чтоб делать дальнейшие расчеты
        /// по текущему времени
        final difference = timeNow.difference(timeReceive);
        final readyHistory = <Historical>[];
        for (final d in r) {
          final addDifference = d.date.add(difference);
          final time = now.difference(addDifference);
          if (time.inHours < 1) {
            readyHistory.add(d);
          } else {
            /// выход за пределы 1 часа останавливаем цикл
            break;
          }
        }

        state = state.copyWith(targetHours: readyHistory);
      },
    );
  }

  /// Возвращает список данных для графика
  List<Historical>? getSpot(ChartType type, ChartHistoricalFiltred data) {
    switch (type) {
      /// За час
      case ChartType.h:
        return data.targetHours?.reversed.toList() ?? [];

      /// За день
      case ChartType.d:
        return data.targetDay?.reversed.toList() ?? [];

      /// За неделю
      case ChartType.w:
        return data.targetWeek?.reversed.toList() ?? [];

      /// За месяц
      case ChartType.m:
        return data.targetMonth?.reversed.toList() ?? [];

      /// За год
      case ChartType.y:
        return data.targetYear?.reversed.toList() ?? [];

      /// За весь период
      case ChartType.all:
        return data.targetAll?.reversed.toList() ?? [];
    }
  }
}
