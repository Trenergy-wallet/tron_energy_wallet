import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/logic/repo/account/repo/account_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/assets/repo/assets_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/auth/repo/auth_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/chart/repo/chart_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/favorites/repo/favorites_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/info/repo/info_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/notifications/notifications.dart';
import 'package:trenergy_wallet/logic/repo/project_tr_energy/repo/project_tr_energy_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/repo_impl.dart';
import 'package:trenergy_wallet/logic/repo/transactions/repo/transactions_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/tron_energy_pipe/repo/tron_energy_repo_base.dart';
import 'package:trenergy_wallet/logic/repo/tron_scan/repo/tron_scan_repo_base.dart';

part 'gen/repo.cg.g.dart';

/// Связка риверпода и репозитория
@Riverpod(keepAlive: true)
RepoBase repo(RepoRef ref) => Repo(ref);

/// Базовый класс главного репозитория
abstract interface class RepoBase {
  /// Локальные данные
  LocalRepo get local;

  /// Auth
  AuthRepo get auth;

  /// Account
  AccountRepo get account;

  /// Info
  InfoRepo get info;

  /// Assets
  AssetsRepo get assets;

  /// Favorites
  FavoritesRepo get favorites;

  /// Notifications
  NotificationsRepo get notifications;

  /// Transactions
  TransactionsRepo get transactions;

  /// Chart
  ChartRepo get chart;

  /// TronEnergyPipe
  TronEnergyPipeRepo get tronEnergyPipe;

  /// TronEnergy
  TronEnergyProjectRepo get tronEnergy;

  /// TronScan
  TronScanRepo get tronScan;
}
