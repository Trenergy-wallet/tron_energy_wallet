import 'dart:async';

import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/keys/private_key.dart';
import 'package:on_chain/tron/src/models/contract/balance/transfer_contract.dart';
import 'package:on_chain/tron/src/models/contract/transaction/transaction.dart';
import 'package:on_chain/tron/src/provider/methods/create_transaction.dart';
import 'package:on_chain/tron/src/provider/provider/provider.dart';
import 'package:on_chain/tron/src/utils/tron_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/project_tr_energy/consumers.cg.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/data/repo/remote/crypto_service/tron_http_provider.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/logic/repo/transactions/transactions_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';

part 'gen/buy_energy_provider.cg.g.dart';

///
@Riverpod(keepAlive: true)
class BuyEnergyService extends _$BuyEnergyService {
  ///
  LocalRepo get localRepo => ref.read(repoProvider).local;

  ///
  int _resourceAmount = 0;

  /// Кол-во запросов
  int countRequest = 0;

  @override
  bool build() {
    return false;
  }

  ///
  Future<void> fetchWalletTopUp({
    required int resourceAmount,
    required int costTrx,
  }) async {
    _resourceAmount = resourceAmount;

    /// запрос на получение адреса для пополнения мерчанта
    final res = await ref.read(repoProvider).tronEnergy.fetchWalletTopUp();
    await res.fold(
      (l) {
        showError(l);
        reloadRequest(ref);
        throw l;
      },
      (r) async {
        /// формирование контракта для пополнения
        final toHex = await sendAmountTrx(
          toAddress: r.address,
          amount: costTrx.toString(),
          resourceAmount: resourceAmount,
        );

        /// отправляем мерчату транзакцию на пополнение
        final resTrans =
            await ref.read(repoProvider).transactions.postTransaction(
                  hex: toHex,
                );

        resTrans.fold(
          (l) {
            showError(l, showToast: false);
          },
          (r) {
            ref.read(appBottomSheetCtrlProvider.notifier).waitEnergy();
            fetchAccount();
          },
        );
      },
    );
  }

  ///
  Future<void> fetchAccount() async {
    /// запрос на получение аккаунта
    final res = await ref.read(repoProvider).tronEnergy.fetchAccount();
    await res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) async {
        /// находим адрес трона
        final appAsset =
            geAppAsset(ref.read(accountServiceProvider)) ?? AppAsset.empty;

        if (r.balance > 0) {
          /// создаем потребителя
          final resPost = await ref.read(repoProvider).tronEnergy.postConsumers(
                ConsumersBody(
                  paymentPeriod: '1',
                  address: appAsset.address,
                  resourceAmount: _resourceAmount,
                  autoRenewal: 0,
                  consumptionType: 1,
                  name: '',
                ),
              );
          await resPost.fold(
            (l) {
              showError(l, showToast: false);
            },
            (r) async {
              /// активируем потребителя
              final rez = await ref
                  .read(repoProvider)
                  .tronEnergy
                  .activate(consumerId: r.id);

              rez.fold((l) {
                showError(l, showToast: false);
              }, (r) {
                ref
                  ..read(accountServiceProvider.notifier).getAccount()
                  ..invalidate(transactionsServiceProvider);
                countRequest = 0;
                _resourceAmount = 0;
              });
            },
          );
        } else {
          countRequest += 1;

          /// ограничение по запросам
          if (countRequest >= 15) {
            return;
          }

          await delayMs(Consts.exitTimeInMillis * 2).then((_) {
            fetchAccount();
          });
        }
      },
    );
  }

  /// Отправить trx
  Future<String> sendAmountTrx({
    required String toAddress,
    required String amount,
    required int resourceAmount,
  }) async {
    final sk = localRepo.getSecretKey();
    final account = localRepo.getAccount(sk: sk);

    // Удаление скобок и разделение строки по запятым
    final stringNumbers = account.privateKey
        .substring(1, account.privateKey.length - 1)
        .split(',');

    // Преобразование каждого элемента в int
    final numbers =
        stringNumbers.map((String str) => int.parse(str.trim())).toList();

    final ownerPrivateKey = TronPrivateKey.fromBytes(numbers);

    final rpc = TronProvider(
      TronHTTPProvider(
        url: AppConfig.apiTrx,
      ),
    );

    /// create transfer contract (TRX Transfer)
    final transferContract = TransferContract(
      amount: TronHelper.toSun(amount),
      ownerAddress: TronAddress(account.address),
      toAddress: TronAddress(toAddress),
    );

    /// validate transacation and got required data like block hash and ....
    final request = await rpc.request(
      TronRequestCreateTransaction.fromContract(
        transferContract,
      ),
    );

    /// An error has occurred with the request, and we need to investigate
    /// the issue to determine what is happening.
    if (!request.isSuccess) {
      return 'error request ${request.error}';
    }

    /// get transactionRaw from response and make sure set fee limit
    final rawTr = request.transactionRaw!;

    /// get transaaction digest and sign with private key
    final sign = ownerPrivateKey.sign(rawTr.toBuffer());

    /// create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTr, signature: [sign]);

    return transaction.toHex;
  }
}
