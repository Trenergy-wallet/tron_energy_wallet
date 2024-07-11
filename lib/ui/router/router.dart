import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:trenergy_wallet/ui/screens/chat/chat_screen.cg.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/enter_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/pin/pincode_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/terms/terms_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/wallet/wallet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/screens/favorites/favorites_screen.dart';
import 'package:trenergy_wallet/ui/screens/notifications/notifications_screen.cg.dart';
import 'package:trenergy_wallet/ui/screens/safety/change_pincode_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/screens/settings/settings_screen.cg.dart';
import 'package:trenergy_wallet/ui/screens/splash/splash_screen.cg.dart';
import 'package:trenergy_wallet/ui/screens/wallet/current_asset.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/enter/nav_screen.dart';

/// Список доступных названий для меню
/// enum должен быть в том же порядке что и branches
enum AppMenuType {
  /// кошелек
  wallet,

  /// чат
  chat,

  /// настройки
  settings,
}

/// Список доступных названий для роутов
final class ScreenPaths {
  const ScreenPaths._();

  /// Домой
  static const String wallet = '/';

  /// Экран заставки
  static const String splash = '/splash';

  /// Вход в кошелек
  static const String enterWallet = '/enter-wallet';

  /// Пин код
  static const String pinCode = '/pin-code';

  /// Экран Условия использования
  static const String terms = '/terms';

  /// Создание кошелька
  static const String createWallet = '/create-wallet';

  /// Подтверждение создания
  static const String confirmWallet = '/confirm-wallet';

  /// Импорт кошелька
  static const String importWallet = '/import-wallet';

  /// Чат
  static const String chat = '/chat';

  /// Настройки
  static const String settings = '/settings';

  /// Избранные
  static const String favorites = '/favorites';

  /// Экран токена
  static const String asset = '/asset';

  /// Уведомления
  static const String notifications = '/notifications';

  ///Экран Безопасности
  static const String safety = '/safety';

  /// Экран смены пин кода
  static const String changePin = '/change-pin';
}

/// Доступные роуты
final routes = [
  AppRoute(ScreenPaths.splash, (_) => const SplashScreen()),
  AppRoute(ScreenPaths.enterWallet, (_) => const EnterScreen()),
  AppRoute(ScreenPaths.terms, (_) => const TermsScreen()),
  AppRoute(ScreenPaths.pinCode, (_) => const PinCodeScreen()),
  AppRoute(ScreenPaths.createWallet, (p) {
    var showRules = true;
    if (p.extra != null && p.extra is bool) {
      final extra = p.extra! as bool;
      showRules = extra;
    }

    return CreateWalletScreen(
      showRules: showRules,
    );
  }),
  AppRoute(ScreenPaths.confirmWallet, (_) => const ConfirmWalletScreen()),
  AppRoute(ScreenPaths.importWallet, (_) => const ImportWalletScreen()),
  AppRoute(ScreenPaths.notifications, (_) => const NotificationsScreen()),
];

///
final branches = <StatefulShellBranch>[
  /// Кошелек
  StatefulShellBranch(
    initialLocation: ScreenPaths.wallet,
    routes: [
      AppRoute(ScreenPaths.wallet, (_) => const WalletScreen()),
      AppRoute(ScreenPaths.asset, (_) => const AssetScreen()),
    ],
  ),

  /// Чат
  StatefulShellBranch(
    initialLocation: ScreenPaths.chat,
    routes: [
      AppRoute(ScreenPaths.chat, (_) => const ChatScreen()),
    ],
  ),

  /// Настройки
  StatefulShellBranch(
    initialLocation: ScreenPaths.settings,
    routes: [
      AppRoute(ScreenPaths.settings, (_) => const SettingsScreen()),
      AppRoute(ScreenPaths.favorites, (_) => const FavoritesScreen()),
      AppRoute(ScreenPaths.safety, (_) => const SafetyScreen()),
      AppRoute(ScreenPaths.changePin, (_) => const ChangePinScreen()),
    ],
  ),
];

/// Навигатор по меню
late StatefulNavigationShell appRouterShell;

/// Навигатор по меню
void _goBranch(AppMenuType type) => appRouterShell.goBranch(type.index);

/// Переход на кошелек
void goToWallet() => _goBranch(AppMenuType.wallet);

/// Переход на чат
void goToChat() => _goBranch(AppMenuType.chat);

/// Переход на настройки
void goToSettings() => _goBranch(AppMenuType.settings);

/// Список страниц без нижней навигацией
final listPagesWithBottomNav = [
  ScreenPaths.asset,
  ScreenPaths.favorites,
  ScreenPaths.safety,
  ScreenPaths.changePin,
];

///
bool hasBottomNavFunc(String screenPaths) {
  if (listPagesWithBottomNav.contains(screenPaths)) {
    return false;
  }

  return true;
}

/// Главный роутер, который можно вызывать без доступа к context
final appRouter = GoRouter(
  initialLocation: ScreenPaths.splash,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      branches: branches,
      builder: (context, state, navigationShell) {
        appRouterShell = navigationShell;

        final hasBottomNav = hasBottomNavFunc(state.fullPath ?? '');

        return NavScreen(
          navigationShell: navigationShell,
          currentIndex: navigationShell.currentIndex,
          hasBottomNav: hasBottomNav,
        );
      },
    ),
    ...routes,
  ],
);

/// Custom GoRoute sub-class to make the router declaration easier to read
/// [useFade] - ставим, если нужна другая анимация перехода (не слайд)
final class AppRoute extends GoRoute {
  // ignore: public_member_api_docs
  AppRoute(
    String path,
    Widget Function(GoRouterState) builder, {
    List<GoRoute> super.routes = const [],
    super.name,
    this.useFade = false,
    Object? arguments,
  }) : super(
          path: path,
          pageBuilder: (_, state) {
            final pageContent = builder(state);
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                arguments: arguments,
                transitionDuration: const Duration(seconds: 1),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent, arguments: arguments);
          },
        );

  /// Используем ли Fade переход между страницами
  final bool useFade;
}

/// Безопасный возврат назад с экрана
/// Если возможности сделать pop нет, просто уходим на корневой экран
void tryGoBack() =>
    appRouter.canPop() ? appRouter.pop() : appRouter.go(ScreenPaths.wallet);

/// Доступ к контексту роутера.
BuildContext? get routeContext {
  return appRouter
      .routeInformationParser.configuration.navigatorKey.currentContext;
}
