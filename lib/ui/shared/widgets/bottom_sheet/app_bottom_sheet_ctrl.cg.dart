import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/domain/transactions/transactions.cg.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_scan/tron_scan_provider.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/screens/favorites/screen_bottom_sheet/add_favorite.dart';
import 'package:trenergy_wallet/ui/screens/favorites/screen_bottom_sheet/delete_favorite.dart';
import 'package:trenergy_wallet/ui/screens/safety/change_pincode_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/screens/settings/settings_screen.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/account/accounts.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/account/new_account.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/buy_energy/buy_energy.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/buy_energy/buy_energy_faq.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/buy_energy/wait_energy.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/currency/currency.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/favorites/favorites.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/language/language.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/model/bottom_sheet_model.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/pin/pin_confirm_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/receive/receive.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/address_recipient.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/amount_currency.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/choose_asset.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/sended_currency.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/transfer_currency.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/tokens/tokens.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/transaction/transaction.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';
part 'gen/app_bottom_sheet_ctrl.cg.g.dart';

///
@Riverpod(keepAlive: true)
class AppBottomSheetCtrl extends _$AppBottomSheetCtrl {
  /// максимальная высота BottomSheet
  double get maxHeight =>
      screenHeight -
      Consts.toolbarHeight -
      MediaQuery.of(routeContext!).viewPadding.top;

  /// половина высоты BottomSheet
  double get halfHeight => screenHeight * .6;

  @override
  BottomSheetModel build() {
    return BottomSheetModel.empty;
  }

//== Accounts ==/
  /// Аккаунты
  void accounts() {
    state = state.copyWith(
      title: 'mobile.accounts'.tr(),
      height: halfHeight,
      defHeight: halfHeight,
      child: const AccountsSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: null,
      hasInsideScroll: BottomSheetModel.empty.hasInsideScroll,
    );
  }

  /// Добавление нового аккаунта
  void addNewAccount() {
    state = state.copyWith(
      title: 'mobile.new_account'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const NewAccountSheet(),
      onTapBack: accounts,
      onTapClose: closeSheet,
    );
  }

  ///
  void deleteAccount() {
    state = state.copyWith(
      title: 'mobile.deleting_account'.tr(),
      height: 260,
      defHeight: 260,
      child: const DeleteAccountSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
    );
  }

//== SEND ==//
  /// Выбор актива
  void chooseAsset({bool isReceive = false}) {
    state = state.copyWith(
      title: 'mobile.choose_asset'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: ChooseAssetSheet(
        isReceive: isReceive,
      ),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
    );
  }

  /// Отправка валюты
  void addressRecipient({bool hasTapBack = false}) {
    state = state.copyWith(
      title: 'mobile.address_recipient'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const AddressRecipientSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: hasTapBack ? chooseAsset : BottomSheetModel.empty.onTapBack,
    );
  }

  /// Перевод
  void amountMoney() {
    state = state.copyWith(
      title: 'mobile.sum'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const AmountCurrencySheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: addressRecipient,
    );
  }

  /// Перевод
  void transferCurrency() {
    state = state.copyWith(
      title: 'mobile.funds_transaction'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const TransferCurrencySheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: amountMoney,
    );
  }

  /// Перевод
  void sendedCurrency() {
    state = state.copyWith(
      title: 'mobile.funds_were_sent'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const SendedCurrencySheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
    );
  }

//== SEND ==//

//== RECEIVE ==//

  /// Получить
  void receiveSheet() {
    state = state.copyWith(
      title: 'mobile.get'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const ReceiveSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
    );
  }

//== RECEIVE ==//

//== FAVORITES ==//

  /// Перевод
  void showListFavorite() {
    state = state.copyWith(
      title: 'mobile.favorites_addresses'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const FavoritesSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
    );
  }

  /// Перевод
  void addFavorite({String? address}) {
    state = state.copyWith(
      title: 'mobile.add_address'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: AddFavoriteSheet(address: address),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
    );
  }

  ///
  void patchFavorite({
    required int id,
    String? name,
    String? address,
  }) {
    state = state.copyWith(
      title: 'mobile.update_addresses'.tr(),
      height: halfHeight,
      defHeight: halfHeight,
      child: AddFavoriteSheet(
        name: name,
        address: address,
        id: id,
        isEdit: true,
      ),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
    );
  }

  ///
  Future<bool?> deleteFavorite({String? address}) async {
    final c = ref.read(favoritesServiceProvider.notifier);
    if (address == null) {
      c.timerCompleter = Completer<bool>();
    }
    state = state.copyWith(
      title: 'mobile.deleting_address'.tr(),
      height: 260,
      defHeight: 260,
      child: DeleteFavoriteSheet(address: address),
      isActiveSheet: true,
      onTapClose: () {
        c.timerCompleter.complete(false);
        closeSheet();
      },
      onTapBack: BottomSheetModel.empty.onTapBack,
      onTapBackground: () {
        c.timerCompleter.complete(false);
        closeSheet();
      },
    );

    return c.timerCompleter.future;
  }

//== FAVORITES ==//

//== PIN CODE ==//
  /// Изменить пин
  void changePin() {
    state = state.copyWith(
      title: 'mobile.current_pin'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const ChangePinSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
    );
  }

  /// Пин сохранен
  void newPinSaved() {
    state = state.copyWith(
      title: 'mobile.saved_pin'.tr(),
      height: 570,
      defHeight: 570,
      child: const ChangedPinSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
    );
  }

  /// Пин сохранен
  void pinConfirm({required void Function() ifEqualsStartFunc}) {
    state = state.copyWith(
      title: 'mobile.check_pin'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: PinConfirmSheet(ifEqualsStartFunc: ifEqualsStartFunc),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
    );
  }
//== PIN CODE ==//

  /// Валюта
  void currency() {
    state = state.copyWith(
      title: 'mobile.currency'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const CurrencySheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
    );
  }

  /// Язык
  void language() {
    state = state.copyWith(
      title: 'mobile.language'.tr(),
      height: halfHeight,
      defHeight: halfHeight,
      child: const LanguageSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
    );
  }

  /// Токены
  void tokens() {
    state = state.copyWith(
      title: 'mobile.tokens'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const TokensSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
    );
  }

  /// Транзакция
  void transaction(TransactionsData trans) {
    ref.read(tronScanServiceProvider.notifier).getTronScan(hash: trans.txId);
    state = state.copyWith(
      title: 'mobile.funds_transaction'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: TransactionSheet(
        trans: trans,
      ),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
    );
  }

  //== Buy Energy ==//
  /// Покупка энергии
  void buyEnergyFaq() {
    state = state.copyWith(
      title: 'mobile.save_commissions'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const BuyEnergyFaqSheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
      colorBg: AppColors.blue,
    );
  }

  ///
  void buyEnergy() {
    state = state.copyWith(
      title: 'mobile.buying_energy'.tr(),
      height: halfHeight,
      defHeight: halfHeight,
      child: const BuyEnergySheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
      colorBg: AppColors.primaryDull,
    );
  }

  ///
  void waitEnergy() {
    state = state.copyWith(
      title: 'mobile.replenishment_energy'.tr(),
      height: maxHeight,
      defHeight: maxHeight,
      child: const WaitEnergySheet(),
      isActiveSheet: true,
      onTapClose: closeSheet,
      onTapBack: BottomSheetModel.empty.onTapBack,
      hasInsideScroll: false,
    );
  }

  //== Buy Energy ==//
  ///
  void updateHeight(double height) {
    state = state.copyWith(height: height);
  }

  ///
  void updateOnTapBack(void Function()? onTapBack) {
    state = state.copyWith(onTapBack: onTapBack);
  }

  ///
  void updateOnTapClose(void Function() onTapClose) {
    state = state.copyWith(onTapClose: onTapClose);
  }

  ///
  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  ///
  void updateChild(Widget child) {
    state = state.copyWith(child: child);
  }

  ///
  void closeSheet() {
    state = BottomSheetModel.empty.copyWith(
      child: state.child,
      title: state.title,
    );
  }
}
