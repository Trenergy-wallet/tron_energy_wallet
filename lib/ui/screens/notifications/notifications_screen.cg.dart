import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart'
    hide PopupMenuButton, PopupMenuDivider, PopupMenuItem;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/ext.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/notification/notification.cg.dart';
import 'package:trenergy_wallet/logic/providers/locale_provider.cg.dart';
import 'package:trenergy_wallet/logic/providers/push_notifications_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/screens/notifications/local_popup_menu.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_modal_bottom_sheet.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/enter/app_scaffold.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/appbar_simple.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/checkbox.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

part 'gen/notifications_screen.cg.f.dart';

part 'gen/notifications_screen.cg.g.dart';

part 'notifications_screen.dart';

part 'widgets/base_card.dart';

@riverpod
class _ScreenCtrl extends _$ScreenCtrl {
  /// Карта-хелпер для подсчета выбранных карточек.
  final _selections = <String, bool>{};

  @override
  Future<_ScreenModel> build() async {
    final allow = ref.watch(pushNotificationsProvider);
    if (!allow) {
      return const _ScreenModel(allowNotifications: false);
    }

    final repo = ref.read(repoProvider).notifications;

    // Запрашиваем данные (пока так)
    final tmpData = await repo.fetch();
    return Future.delayed(const Duration(milliseconds: 150), () {
      return _ScreenModel(
        items: tmpData.fold(
          (l) => [],
          (r) => r.map(
            (e) {
              return switch (e) {
                NotificationPayment() => _Item.payment(
                    uid: e.id,
                    time: e.createdAt ?? now,
                    type: e.type == NotificationType.incoming
                        ? _PaymentType.income
                        : _PaymentType.outcome,
                    value: e.amount,
                    currency: e.unit,
                    balance: e.balance,
                    read: e.readAt != null,
                  ),
                NotificationEnergy() => _Item.energy(
                    uid: e.id,
                    time: e.createdAt ?? now,
                    value: e.amount ?? '0',
                    read: e.readAt != null,
                  ),
              };
            },
          ).toList(),
        ),
      );
    });
  }

  void showDialog(BuildContext context, _PopupMenuItemType item) {
    state.whenData((value) {
      switch (item) {
        case _PopupMenuItemType.choose:
          state = AsyncData(
            value.copyWith(
              showSelectMarker: !value.showSelectMarker,
            ),
          );
        case _PopupMenuItemType.deleteAll:
          showAppModalBottomSheet<void>(
            context: context,
            children: [
              Column(
                children: [
                  AppButton.strokeL(
                    text: 'mobile.delete_everything'.tr(),
                    isNegative: true,
                    height: 52,
                    onTap: () {
                      deleteAll();
                      Navigator.of(context).pop();
                    },
                  ),
                  8.sbHeight,
                  AppButton.strokeL(
                    text: 'mobile.cancellation'.tr(),
                    height: 52,
                    onTap: Navigator.of(context).pop,
                  ),
                ],
              ),
            ],
          );
      }
    });
  }

  void updateSelectedCount(_ItemModel item) {
    state.whenData((value) {
      final idx = value.items.indexWhere((e) => e.uid == item.uid);
      if (idx == Consts.invalidIntValue) {
        _selections.remove(item.uid);
        return;
      }

      if (item.selected) {
        _selections[item.uid] = true;
      } else {
        _selections.remove(item.uid);
      }

      final cnt = _selections.entries.fold(0, (p, e) {
        return e.value ? p + 1 : p;
      });

      state = AsyncData(value.copyWith(selectedCount: cnt));
    });
  }

  void cancelSelection() {
    state = AsyncData(
      state.asData!.value.copyWith(
        selectedCount: 0,
        selectionType: _ScreenModelSelectionType.selectNone,
        items: state.asData!.value.items
            .map((e) => e.copyWith(selected: false))
            .toList(),
      ),
    );
    _selections.clear();

    delayMs(1).then((value) {
      state = AsyncData(
        state.asData!.value.copyWith(
          selectionType: _ScreenModelSelectionType.unused,
          showSelectMarker: false,
        ),
      );
    });
  }

  void updateItem(_Item item) {
    state = AsyncData(
      state.asData!.value.copyWith(
        items: state.asData!.value.items
            .map((e) => e.uid == item.uid ? item : e)
            .toList(),
      ),
    );
  }

  void markAsRead(_Item item) {
    ref.read(repoProvider).notifications.read(item.uid);
  }

  void markAsUnread(_Item item) {
    ref.read(repoProvider).notifications.unread(item.uid);
  }

  void deleteSelected() {
    state = state.whenData((value) {
      final tmp = List.of(value.items)
        ..removeWhere((element) => element.selected);

      // Удаление само по себе, перерисовка локально - оптимистик апдейт.
      final forDeletion = List.of(value.items)
        ..removeWhere((element) => !element.selected);
      for (final e in forDeletion) {
        ref.read(repoProvider).notifications.delete(e.uid);
      }

      return value.copyWith(
        selectedCount: 0,
        selectionType: _ScreenModelSelectionType.unused,
        items: tmp,
        showSelectMarker: false,
      );
    });
    _selections.clear();
  }

  void deleteAll() {
    ref.read(repoProvider).notifications.deleteAll();

    state = state.whenData((value) {
      return value.copyWith(
        selectedCount: 0,
        selectionType: _ScreenModelSelectionType.unused,
        items: [],
        showSelectMarker: false,
      );
    });
    _selections.clear();
  }
}

/// Item Controller for [_Item]
///
/// Ни на что не подписан, работает за счет того, что изменения в листе
/// отражаются на перерисовке списка виджетов, которые пересоздают
/// свои провайдеры.
@riverpod
class _ItemCtrl extends _$ItemCtrl {
  /// Используется для запуска подсчета 3 секунд при отображении карточки
  /// в поле видимости.
  final _debouncer = Debouncer(delay: const Duration(seconds: 3));

  @override
  _ItemModel build(_Item item) {
    ref.onDispose(_debouncer.cancel);

    return switch (item) {
      __Payment() => _ItemModel.payment(
          uid: item.uid,
          title: item.type == _PaymentType.income
              ? 'mobile.incoming_payment'.tr()
              : 'mobile.outgoing_payment'.tr(),
          time: item.time.fmt('HH:mm'),
          value: item.value,
          read: item.read,
          selected: item.selected,
          currency: item.currency,
          type: item.type,
          balance: numbWithoutZero(item.balance, precision: 2),
        ),
      __Energy() => _ItemModel.energy(
          uid: item.uid,
          title: 'mobile.energy_replenishment'.tr(),
          time: item.time.fmt('HH:mm'),
          value: item.value,
          read: item.read,
          selected: item.selected,
        ),
    };
  }

  void toggleSelection() {
    final tmp = !state.selected;
    state = state.copyWith(selected: tmp);
    ref.read(_screenCtrlProvider.notifier).updateSelectedCount(state);
    ref.read(_screenCtrlProvider.notifier).updateItem(
          item.copyWith(
            selected: tmp,
          ),
        );
  }

  /// При входе в поле зрения более чем на 95% запускаем отсчет дебаунсера,
  /// и если элемент не вышел из поля зрения, то дебаунсер отрабатывает,
  /// и элемент помечается как прочтенный.
  ///
  /// Иначе дебаунсер сбрасывается.
  void onVisibilityInfoChanged(VisibilityInfo info) {
    switch (info.visibleFraction) {
      case > 0.95:
        _debouncer.call(() {
          if (!item.read) {
            ref.read(_screenCtrlProvider.notifier)
              ..updateItem(item.copyWith(read: true))
              ..markAsRead(item);
          }
        });
      default:
        _debouncer.cancel();
    }
  }
}

@freezed
sealed class _ItemModel with _$ItemModel {
  const factory _ItemModel.payment({
    required String uid,
    required String title,
    required String time,
    @Default(false) bool selected,
    @Default(false) bool read,
    required double value,
    //
    required _PaymentType type,
    required String currency,
    required String balance,
  }) = __PaymentModel;

  const factory _ItemModel.energy({
    required String uid,
    required String title,
    required String time,
    @Default(false) bool selected,
    @Default(false) bool read,
    required String value,
  }) = __EnergyModel;
}

@freezed
sealed class _Item with _$Item {
  const factory _Item.payment({
    required String uid,
    required DateTime time,
    @Default(false) bool read,
    @Default(false) bool selected,
    required double value,
    //
    required _PaymentType type,
    required String currency,
    required double balance,
  }) = __Payment;

  const factory _Item.energy({
    required String uid,
    required DateTime time,
    @Default(false) bool read,
    @Default(false) bool selected,
    required String value,
  }) = __Energy;

  const _Item._();
}

@freezed
class _ScreenModel with _$ScreenModel {
  const factory _ScreenModel({
    @Default(true) bool allowNotifications,
    @Default([]) List<_Item> items,
    @Default(false) bool showSelectMarker,
    @Default(0) int selectedCount,
    @Default(_ScreenModelSelectionType.unused)
    _ScreenModelSelectionType selectionType,
  }) = __ScreenModel;
}

/// Тип выделения.
///
/// Используется для сбраывания выделения.
enum _ScreenModelSelectionType {
  unused,
  selectNone,
}
