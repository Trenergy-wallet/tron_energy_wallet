/// Тип сборки
enum EnvironmentType {
  /// Stage
  stage('.stage'),

  /// Demo
  demo('.demo'),

  /// Production
  prod('');

  const EnvironmentType(this.appIdSuffix);

  /// Должен совпадать со значениями из android/app/src/build.gradle
  final String appIdSuffix;

  @override
  String toString() => name;

  /// Достаем тип из ключа dotenv.env['ENVIRONMENT'] или другой String?
  static EnvironmentType fromString(String? key) => switch (key) {
        'stage' => EnvironmentType.stage,
        'demo' => EnvironmentType.demo,
        'prod' => EnvironmentType.prod,
        null || _ => EnvironmentType.stage,
      };
}
