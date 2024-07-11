import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/ui/router/router.dart';

part 'gen/locale_provider.cg.g.dart';

/// Контроллер локали.
@riverpod
class LocaleController extends _$LocaleController {
  /// Поддерживаемые локали.
  List<Locale> get supportedLocales => AppConfig.supportedLocales.keys.toList();

  /// Поддерживаемые значения локали.
  List<String> get localesValues => AppConfig.supportedLocales.values.toList();

  @override
  Locale build() {
    final context = routeContext;
    if (context != null && EasyLocalization.of(context) != null) {
      return EasyLocalization.of(context)!.locale;
    }
    return AppConfig.defaultLocale;
  }

  /// Сохранить новую локаль. Текущая локаль в приложении при этом НЕ МЕНЯЕТСЯ
  /// Тк основной менеджер локали - EasyLocalisation
  // ignore: avoid_setters_without_getters
  void setLocaleByLanguageCode(String value) {
    // проверок много не бывает
    if (state.languageCode != value) {
      state = Locale(value);

      // там, где данные надписей напрямую приходят от бэка, требуется
      // перезапустить запросы
      // ref.invalidate(someProvider);
    }
  }

  /// Перелокалимся.
  ///
  /// Защищаемся от неподдерживаемых локалей.
  void setLocale(Locale? value) {
    // value = Locale('de'); чисто проверить...
    if (value == null) return;
    final supported = AppConfig.supportedLocales.keys;
    if (!supported.contains(value) || routeContext == null) {
      return;
    }

    if (state != value) {
      final easyLocalization = EasyLocalization.of(routeContext!);
      easyLocalization?.setLocale(value);
      state = value;
    }
  }
}
