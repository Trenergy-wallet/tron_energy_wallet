/// Тип графика
enum ChartType {
  /// За час
  h(
    type: 'chart_hour',
  ),

  /// За день
  d(
    type: 'chart_day',
  ),

  /// За неделю
  w(
    type: 'chart_week',
  ),

  /// За месяц
  m(
    type: 'chart_month',
  ),

  /// За год
  y(
    type: 'chart_year',
  ),

  /// За весь период
  all(
    type: 'chart_all',
  );

  const ChartType({required this.type});

  ///
  final String type;
}
