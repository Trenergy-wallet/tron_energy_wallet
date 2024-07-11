import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/data/repo/local/impl/hive_repo.cg.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/data/repo/remote/account/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/assets/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/auth/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/chart/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/favorites/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/info/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/notifications/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/project_tr_energy/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/transactions/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/tron_energy_pipe/provider.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/tron_scan/provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/repo/account_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/assets/repo/assets_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/auth/repo/auth_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/chart/repo/chart_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/favorites/repo/favorites_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/info/repo/info_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/notifications/notifications.dart';
import 'package:trenergy_wallet/logic/repo/project_tr_energy/repo/project_tr_energy_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/logic/repo/transactions/repo/transactions_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/tron_energy_pipe/repo/tron_energy_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/tron_scan/repo/tron_scan_repo_base.dart';

/// Реализация репозитория
final class Repo implements RepoBase {
  /// Реализация репозитория
  Repo(this._ref);

  final Ref _ref;

  @override
  LocalRepo get local => _ref.read(localRepoProvider);

  @override
  AuthRepo get auth => _ref.read(authProvider);

  @override
  AccountRepo get account => _ref.read(accountProvider);

  @override
  InfoRepo get info => _ref.read(infoProvider);

  @override
  AssetsRepo get assets => _ref.read(assetsProvider);

  @override
  FavoritesRepo get favorites => _ref.read(favoritesProvider);

  @override
  NotificationsRepo get notifications => _ref.read(notificationsProvider);
  @override
  TransactionsRepo get transactions => _ref.read(transactionsProvider);

  @override
  ChartRepo get chart => _ref.read(chartProvider);

  @override
  TronEnergyPipeRepo get tronEnergyPipe => _ref.read(tronEnergyPipeProvider);

  @override
  TronEnergyProjectRepo get tronEnergy => _ref.read(tronEnergyProjectProvider);

  @override
  TronScanRepo get tronScan => _ref.read(tronScanProvider);
}
