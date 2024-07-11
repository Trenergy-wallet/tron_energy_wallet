import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/data/dto/project_tr_energy/consumers.cg.dart';
import 'package:trenergy_wallet/domain/empty_data.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/acc_tr_energy.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/consumers.cg.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/wallet_top_up.cg.dart';

/// Интерфейс tr energy project репозитория
abstract interface class TronEnergyProjectRepo {
  /// Получить информацию об аккаунте (GET 9.1)
  Future<ErrOrAccountTrEnergy> fetchAccount();

  /// Получить адрес кошелека (GET 9.3)
  Future<ErrOrWalletTopUp> fetchWalletTopUp();

  /// отправить транзакции (POST 5.10)
  Future<ErrOrConsumersStore> postConsumers(ConsumersBody body);

  /// 5.4. Activate
  Future<ErrOrEmptyData> activate({required int consumerId});
}

///
typedef ErrOrAccountTrEnergy = Either<ExtendedErrors, AccountTrEnergy>;
