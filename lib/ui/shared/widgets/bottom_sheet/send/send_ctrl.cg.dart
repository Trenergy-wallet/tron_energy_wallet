import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:on_chain/solidity/contract/contract_abi.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/keys/private_key.dart';
import 'package:on_chain/tron/src/models/contract/balance/transfer_contract.dart';
import 'package:on_chain/tron/src/models/contract/transaction/transaction.dart';
import 'package:on_chain/tron/src/provider/provider.dart';
import 'package:on_chain/tron/src/utils/tron_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/config/trc20_abi.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/data/repo/remote/crypto_service/tron_http_provider.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/estimate_fee_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/wallet_check_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/logic/repo/transactions/transactions_provider.cg.dart';
import 'package:trenergy_wallet/ui/screens/wallet/current_asset.cg.dart';
import 'package:trenergy_wallet/ui/shared/app_alert.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/model/send_model.cg.dart';
part 'gen/send_ctrl.cg.g.dart';

///
@riverpod
class SendCtrl extends _$SendCtrl {
  /// Repo local
  LocalRepo get localRepo => ref.read(repoProvider).local;

  @override
  SendModel build() {
    return SendModel.empty;
  }

  /// Добавить адрес кому отправить
  void updateAddressRecipient(String address) {
    ref.read(walletCheckCtrlProvider.notifier).checkAddress(address);

    state = state.copyWith(addressRecipient: address);
  }

  /// Добавить адрес кому отправить
  void updateAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  /// Перейти к валюте
  void goToAmountCurrency(String address) {
    final estimNotif = ref.read(estimateFeeCtrlProvider.notifier);
    final localRepo = ref.read(repoProvider).local;
    final useFavList = localRepo.getOnlyFavorites();

    final favList = ref.read(favoritesServiceProvider).valueOrNull ?? [];
    if (useFavList) {
      if (favList.any((f) => f.address == address)) {
        /// запрос на комиссию
        estimNotif.estimateFee();
        ref.read(appBottomSheetCtrlProvider.notifier).amountMoney();
      } else {
        appAlert(
          value: 'mobile.enabled_mode_only_favorites_addresses'.tr(),
          gravity: ToastGravity.TOP,
          timeInSec: 2,
        );
      }
    } else {
      /// запрос на комиссию
      estimNotif.estimateFee();
      ref.read(appBottomSheetCtrlProvider.notifier).amountMoney();
    }
  }

  /// Отправить
  void sendAmount() {
    final asset = ref.read(currentAssetProvider);

    if (asset.token.name == Consts.tron || asset.token.name == Consts.trx) {
      sendAmountTrx();
    } else {
      sendAmountOther();
    }
  }

  /// Отправить trx
  Future<void> sendAmountTrx() async {
    final appBottom = ref.read(appBottomSheetCtrlProvider.notifier);
    final transNotif = ref.read(transactionsServiceProvider.notifier);
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

    final asset = ref.read(currentAssetProvider);
    final rpc = TronProvider(
      TronHTTPProvider(
        url: AppConfig.apiTrx,
      ),
    );

    final amount = state.amount.replaceAll(' ', '');

    /// create transfer contract (TRX Transfer)
    final transferContract = TransferContract(
      amount: TronHelper.toSun(amount),
      ownerAddress: TronAddress(asset.address),
      toAddress: TronAddress(state.addressRecipient),
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
      return;
    }

    /// get transactionRaw from response and make sure set fee limit
    final rawTr = request.transactionRaw!;

    /// get transaaction digest and sign with private key
    final sign = ownerPrivateKey.sign(rawTr.toBuffer());

    /// create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTr, signature: [sign]);

    final toHex = transaction.toHex;

    appBottom.pinConfirm(
      ifEqualsStartFunc: () async {
        await transNotif.postTransaction(hex: toHex);
      },
    );
  }

  /// Отправить другую валюту
  Future<void> sendAmountOther() async {
    final asset = ref.read(currentAssetProvider);
    final appBottom = ref.read(appBottomSheetCtrlProvider.notifier);
    final transNotif = ref.read(transactionsServiceProvider.notifier);
    final sk = localRepo.getSecretKey();
    final account = localRepo.getAccount(sk: sk);
    // Удаление скобок и разделение строки по запятым
    final stringNumbers = account.privateKey
        .substring(1, account.privateKey.length - 1)
        .split(',');

    /// столько нулей нужно приписать к еденице
    final buffer = StringBuffer()..write('1');
    for (var i = 0; i < asset.token.decimal; i++) {
      buffer.write('0');
    }

    final decimal = int.tryParse(buffer.toString()) ?? 0;

    // Преобразование каждого элемента в int
    final numbers =
        stringNumbers.map((String str) => int.parse(str.trim())).toList();

    final ownerPrivateKey = TronPrivateKey.fromBytes(numbers);

    final rpc = TronProvider(
      TronHTTPProvider(
        url: AppConfig.apiTrx,
      ),
    );

    final amountParse = state.amount.replaceAll(' ', '');
    final amount = double.tryParse(amountParse) ?? 0;
    final totalAmount = amount * decimal;

    final contract = ContractABI.fromJson(trc20Abi, isTron: true);

    final function = contract.functionFromName('transfer');

    /// address /// amount
    final transferparams = [
      TronAddress(state.addressRecipient),
      BigInt.from(totalAmount),
    ];

    final contractAddress = TronAddress(asset.token.contractAddress);

    final request = await rpc.request(
      TronRequestTriggerConstantContract(
        ownerAddress: TronAddress(asset.address),
        contractAddress: contractAddress,
        data: function.encodeHex(transferparams),
      ),
    );

    /// An error has occurred with the request, and we need to investigate
    /// the issue to determine what is happening.
    if (!request.isSuccess) {
      return;
    }

    /// get transactionRaw from response and make sure set fee limit
    final rawTr = request.transactionRaw!.copyWith(
      feeLimit: TronHelper.toSun('100'),
    );

    /// get transaaction digest and sign with private key
    final sign = ownerPrivateKey.sign(rawTr.toBuffer());

    /// create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTr, signature: [sign]);

    final toHex = transaction.toHex;

    /// send transaction to network
    // await rpc.request(TronRequestBroadcastHex(transaction: toHex));
    appBottom.pinConfirm(
      ifEqualsStartFunc: () async {
        await transNotif.postTransaction(hex: toHex);
      },
    );
  }
}
