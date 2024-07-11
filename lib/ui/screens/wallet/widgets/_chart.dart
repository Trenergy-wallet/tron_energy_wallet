part of '../current_asset.cg.dart';

///
class _ChartCurrency extends ConsumerStatefulWidget {
  ///
  const _ChartCurrency({
    required this.asset,
    super.key,
  });

  final AppAsset asset;
  @override
  ConsumerState<_ChartCurrency> createState() => __ChartCurrencyState();
}

class __ChartCurrencyState extends ConsumerState<_ChartCurrency> {
  AppAsset get asset => widget.asset;

  bool hasLoading = false;
  late ChartHistoricalFiltred data;

  /// Текущий график
  ChartType currentDay = ChartType.w;
  int currentIndexSpot = 0;

  List<DateTime> dateTimes = <DateTime>[Consts.invalidDateTime];
  List<double> prices = <double>[0];
  List<double> differencesPercent = <double>[0];
  List<FlSpot> spots = <FlSpot>[FlSpot.zero];

  double maxX = 0;
  double maxY = 0;
  double minY = 0;

  void changeIndexSpot(int index) {
    setState(() {
      currentIndexSpot = index;
    });
  }

  void changeLoading(bool b) {
    setState(() {
      hasLoading = b;
    });
  }

  void changeDay(ChartType type) {
    setState(() {
      currentDay = type;
    });
  }

  void clearAll() {
    spots.clear();
    prices.clear();
    differencesPercent.clear();
    dateTimes.clear();
  }

  void getMax(List<Historical> data) {
    clearAll();

    final maxHigh = data.map((e) => e.close).reduce(max);
    final minHigh = data.map((e) => e.close).reduce(min);
    setState(() {
      maxY = maxHigh + 0.00008;
      minY = minHigh - 0.00008;
      maxX = data.length.toDouble();

      for (var i = 0; i < data.length; i++) {
        spots.add(FlSpot(i.toDouble(), data[i].close));

        prices.add(data[i].close);
        differencesPercent
            .add(calculatePercentageChange(data[0].close, data[i].close));
        dateTimes.add(data[i].date);
      }
    });
    changeIndexSpot(data.length - 1);
  }

  final days = ChartType.values.toList();

  @override
  Widget build(BuildContext context) {
    final chartCtrl = ref.watch(chartHistoricalServiceProvider.notifier);

    ref.listen(chartHistoricalServiceProvider, (previous, next) {
      final list = [
        next.targetAll ?? [],
        next.targetYear ?? [],
        next.targetWeek ?? [],
        next.targetMonth ?? [],
        next.targetDay ?? [],
        next.targetHours ?? [],
      ];

      changeLoading(list.every((e) => e.isNotEmpty));
      data = next;
      if (hasLoading) {
        getMax(chartCtrl.getSpot(currentDay, data) ?? []);
      }
    });

    final percent = differencesPercent[currentIndexSpot];
    final isNegative = percent.isNegative;
    final priceSpot = numbWithoutZero(prices[currentIndexSpot]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.titleH1('${'mobile.price'.tr()} ${asset.token.shortName}'),
          12.sbHeight,
          AppText.bodyMedium('\$$priceSpot'),
          8.sbHeight,
          AppText.bodyMedium(
            '${numbWithoutZero(percent, precision: 2)}%',
            color: isNegative
                ? AppColors.negativeBright
                : AppColors.positiveBright,
          ),
          24.sbHeight,
          if (!hasLoading)
            const Preloader()
          else
            ClipRect(
              child: AspectRatio(
                aspectRatio: 3,
                child: LineChart(mainData(isNegative)),
              ),
            ),
          20.sbHeight,
          SizedBox(
            height: 24,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              separatorBuilder: (_, __) => 8.sbWidth,
              itemBuilder: (c, i) {
                /// 40 = 8 * days.length
                /// 24 = это отступ слева и справа по 12
                final w = (screenWidth - 64) / days.length;
                return AppButton.tertiary(
                  onTap: () {
                    if (hasLoading) {
                      changeDay(days[i]);
                      getMax(chartCtrl.getSpot(currentDay, data) ?? []);
                    }
                  },
                  width: w,
                  text: 'mobile.${days[i].type}'.tr(),
                  background: days[i] == currentDay
                      ? AppColors.buttonsLavenderBright
                      : AppColors.buttonsLavenderMid,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData(bool isNegative) {
    return LineChartData(
      gridData: const FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: const FlTitlesData(
        rightTitles: AxisTitles(),
        topTitles: AxisTitles(),
        bottomTitles: AxisTitles(),
        leftTitles: AxisTitles(),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map(
              (LineBarSpot touchedSpot) {
                return null;
              },
            ).toList();
          },
        ),
        touchCallback: (event, p1) {
          final d = spots.length - 1;
          if (event is FlTapUpEvent ||
              event is FlLongPressEnd ||
              event is FlPanEndEvent) {
            changeIndexSpot(d);
          } else {
            changeIndexSpot(p1?.lineBarSpots?[0].spotIndex ?? d);
          }
        },
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> indicators) {
          return indicators.map(
            (int index) {
              final line = FlLine(
                color: AppColors.bwGrayBright,
                strokeWidth: 1,
                dashArray: [3, 1],
              );
              return TouchedSpotIndicatorData(
                line,
                FlDotData(
                  getDotPainter: (p0, p1, p2, p3) {
                    return FlDotCirclePainter(
                      color: isNegative
                          ? AppColors.negativeBright
                          : AppColors.positiveContrastBright,
                      radius: 5,
                      strokeWidth: 1,
                      strokeColor: AppColors.bwBrightPrimary,
                    );
                  },
                ),
              );
            },
          ).toList();
        },
        getTouchLineEnd: (_, __) => double.infinity,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          isStrokeCapRound: true,
          color:
              isNegative ? AppColors.negativeBright : AppColors.positiveBright,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: isNegative
                ? AppColors.negativeLightMid
                : AppColors.positiveLightMid,
          ),
        ),
      ],
    );
  }
}
