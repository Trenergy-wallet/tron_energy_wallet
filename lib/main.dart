import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/repo/local/impl/hive_repo.cg.dart';
import 'package:trenergy_wallet/logic/providers/locale_provider.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'fcm_init.dart';

/// Вызов функции инициализации, параметризованной флавором.
/// Функция инициализации может быть любая.
Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await _fcmInit();

  await AppConfig.instance.load();
  await initHive();
  await EasyLocalization.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).whenComplete(() async {
    runApp(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: AppConfig.supportedLocales.keys.toList(),
          path: Consts.localePath,
          // если не задать startLocale устанавливается локаль системы
          // по умолчанию
          startLocale: AppConfig.defaultLocale,
          // en
          fallbackLocale: AppConfig.fallbackLocale,
          child: const TheApp(),
        ),
      ),
    );
  });
}

///\
class TheApp extends ConsumerWidget {
  ///
  const TheApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeController.provider);

    // ref.read(fcmProvider);

    /// Этот костыль нужен для EasyLocalisation, тк при смене локали
    /// выводятся новые значения на текущий экран, а если в стеке есть
    /// другой экран, там остаются старые значения
    /// см https://github.com/aissat/easy_localization/issues/370
    void rebuildAllChildren(BuildContext context) {
      void rebuild(Element el) {
        el
          ..markNeedsBuild()
          ..visitChildren(rebuild);
      }

      (context as Element).visitChildren(rebuild);
    }

    rebuildAllChildren(context);

    /// Сохраним локаль в провайдере для дальнейшего использования
    addPostFrameCallback(() async {
      final savedLocale = ref.read(localeControllerProvider);
      final currentLocale = context.locale;
      if (savedLocale != currentLocale) {
        ref.read(localeControllerProvider.notifier).setLocale(currentLocale);
      }
    });

    return ScreenUtilInit(
      designSize: figmaSize,
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
      child: MaterialApp.router(
        title: 'TR.ENERGY WALLET',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          const LocaleNamesLocalizationsDelegate(),
          ...context.localizationDelegates,
        ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: theme.data.copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        themeMode: theme.mode,
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        routerDelegate: appRouter.routerDelegate,
      ),
    );
  }
}
