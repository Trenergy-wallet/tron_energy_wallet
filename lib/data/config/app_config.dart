import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:trenergy_wallet/data/config/enum/environment.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';

/// Конфигурация запуска приложения, которая частично подтягивается из env
final class AppConfig {
  AppConfig._instantiate();

  /// Синглтон конфигурации
  static final AppConfig instance = AppConfig._instantiate();

  final InAppLogger _inAppLogger = InAppLogger.instance;

  final deviceInfo = DeviceInfoPlugin();

  /// isProduction ?
  static bool get isProduction =>
      kReleaseMode || environment == EnvironmentType.prod;

  /// Тип environment
  static EnvironmentType get environment => _environment;

  /// apiEndpoint - URI REST клиента
  static final String apiEndpoint = dotenv.env['API_URI'] ?? '';

  /// apiTrx - URI REST клиента
  static final String apiTrx = dotenv.env['API_TRX'] ?? '';

  /// apiTrxTxid - путь для получения txid
  static final String apiTrxTxid = dotenv.env['URL_TRX_TXID'] ?? '';

  /// домен для получения списка курсов валют
  static final String apiEndpointChart = dotenv.env['API_URL_CHART'] ?? '';

  /// api для проекта tron energy
  static final String apiTrEnergy = dotenv.env['API_URI_TRENERGY'] ?? '';

  /// api для получения tron scan
  static final String apiTronscan = dotenv.env['API_TRONSCANAPI'] ?? '';

  /// ключ для получения курсов валют
  static final String apiKeyChart = dotenv.env['API_KEY_CHART'] ?? '';

  /// apiEndpointSecondary - URI REST клиента
  static final String apiEndpointSecondary =
      dotenv.env['API_URI_SECONDARY'] ?? '';

  /// Web-frontend
  static String get webEndpoint => dotenv.env['WEB_FRONT_URI'] ?? '';

  /// wssEndpoint - URI чатов
  static String get wssEndpoint => dotenv.env['WSS_URI'] ?? '';

  /// sentryDSN
  static String? get sentryDSN => dotenv.env['SENTRY_DSN'];

  /// MapBox public token
  static String get mapBoxToken => dotenv.env['MAPBOX_PUBLIC_TOKEN'] ?? '';

  /// IOS bundle ID
  static String get iosBundleId => dotenv.env['BUNDLE_ID'] ?? '';

  /// Apple store ID (APP_STORE_ID)
  static String get iosStoreId => dotenv.env['APP_STORE_ID'] ?? '';

  /// IOS CLIENT ID (нужно для авторизации гугла)
  static String? get iosClientId {
    final res = dotenv.env['IOS_CLIENT_ID'];
    if (res == null) {
      InAppLogger.instance.logInfoMessage('AppConfig', 'NO KEY: IOS_CLIENT_ID');
    }
    return res;
  }

  // Only for development
  // static String? get devUsername => dotenv.env['DEV_USER_NAME'];
  // static String? get devPassword => dotenv.env['DEV_USER_PASSWORD'];

  /// Тип системы, где запущено приложение
  // ignore: non_constant_identifier_names
  // static String get OS => Platform.operatingSystem;

  static String? _appVersion;
  static String? _appVersionUI;

  /// Версия приложения
  // ignore: non_constant_identifier_names
  static String? get appVersion => _appVersion;
  static String? get appVersionUI => _appVersionUI;

  static late final String _packageName;

  // ignore: non_constant_identifier_names
  static String get packageName => _packageName;

  static bool _isAndroid = false;

  static bool get isAndroid => _isAndroid;

  static bool _isIOS = false;

  static bool get isIOS => _isIOS;

  static const String appName = 'Treneregy Wallet';

  static String _deviceName = '';

  // ignore: non_constant_identifier_names
  static String get deviceName => _deviceName;

  // ignore: non_constant_identifier_names
  static List<String> get testers => dotenv.env.containsKey('TESTERS')
      ? dotenv.env['TESTERS']!.split(',').toList()
      : [''];

  late final PackageInfo _packageInfo;

  static late final EnvironmentType _environment;

  static const defaultLocale = Locale('en');

  static const fallbackLocale = Locale('ru');

  static final supportedLocales = {
    defaultLocale: 'English',
    fallbackLocale: 'Русский',
  };

  /// Загрузка конфигурации при старте приложения
  ///
  /// В том числе загружает переменные окружения из файла .env.
  /// Основана на передаче параметра через командную строку, например:
  /// ```dart
  /// flutter build apk --flavor stage --dart-define=app.flavor=stage
  /// ```
  ///
  /// В папке `assets/` находятся соответствующие файлы `.env.stage`,
  /// `.env.prod`, `.env.dev` и т.д.
  Future<void> load() async {
    const appFlavorKey = 'app.flavor';
    const defaultFlavor = 'demo';
    const flavor = String.fromEnvironment(
      appFlavorKey,
      defaultValue: defaultFlavor,
    );

    _environment = EnvironmentType.fromString(flavor);

    await dotenv.load(fileName: 'assets/.env');
    _packageInfo = await PackageInfo.fromPlatform();

    _appVersion = '${_packageInfo.version}+${_packageInfo.buildNumber}';

    _appVersionUI = _packageInfo.version;

    _packageName = _packageInfo.packageName;

    if (kIsWeb) {
      _isAndroid = false;
      _isIOS = false;
      _deviceName = 'Web';
    } else {
      if (Platform.isAndroid) {
        final di = await deviceInfo.androidInfo;
        _isAndroid = true;
        _deviceName = '${di.brand} ${di.model} ${di.product}';
      } else if (Platform.isIOS) {
        final di = await deviceInfo.iosInfo;
        _isIOS = true;
        _deviceName =
            '${di.name} ${di.model} ${di.systemName} ${di.systemVersion}';
      }
    }

    _inAppLogger
      ..logInfoMessage('AppConfig', 'APP_ID: $packageName')
      ..logInfoMessage('AppConfig', 'ENVIRONMENT: ${environment.name}')
      ..logInfoMessage('AppConfig', 'APP_VERSION: $appVersion')
      ..logInfoMessage('AppConfig', 'DEVICE: $_deviceName')
      ..logInfoMessage('AppConfig', 'API ENDPOINT: $apiEndpoint');
  }

  String get buildNumber => _packageInfo.buildNumber;

  String get version => _packageInfo.version;

// static SentryFlutterOptions sentryFlutterOptions(
//     SentryFlutterOptions options) {
//   return options
//     ..dsn = sentryDSN
//     ..environment = environment
//     ..beforeSend = _beforeSend
//     ..attachScreenshot = true;
// }
}

// FutureOr<SentryEvent?> _beforeSend(SentryEvent e, {dynamic hint}) async {
//   InAppLogger.instance.addToLog(
//     '❗SENTRY ERROR❗',
//     'type: ${e.exceptions?.first.type}, value: ${e.exceptions?.first.value},\n'
//         'eventId: ${e.eventId.toString()}, level: ${e.level?.name},
//         mechanism: ${e.exceptions?.first.mechanism?.type}, '
//         '\nmessage: ${e.message?.toJson()},\n'
//         'stackTrace last frame:
//         ${e.exceptions?.first.stackTrace?.frames.last.toJson()}',
//   );
//   return e;
// }

// ignore_for_file: public_member_api_docs
