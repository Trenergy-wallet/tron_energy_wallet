import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/favorites/favorites.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';

part 'gen/favorites_provider.cg.g.dart';

/// Контроллер account для полуучения данных о пользователей
@Riverpod(keepAlive: true)
class FavoritesService extends _$FavoritesService {
  ///
  Favorites currentFavorites = Favorites.empty;

  /// timer
  Completer<bool> timerCompleter = Completer<bool>();

  @override
  Future<List<Favorites>> build() async {
    final res = await ref.read(repoProvider).favorites.getFavorites();

    return res.fold(
      (l) {
        showError(l, showToast: false);
        return [];
      },
      (r) => r,
    );
  }

  /// currentFavorites
  void chooseFavorites(Favorites value) {
    timerCompleter = Completer<bool>();
    currentFavorites = value;
  }

  /// Добавление в избранное
  Future<void> postPatchFavorite({
    required String name,
    required String address,
    int? id,
    bool isEdit = false,
  }) async {
    final res = isEdit
        ? await ref.read(repoProvider).favorites.patchFavorites(
              name: name,
              favoriteId: id ?? 0,
              address: address,
            )
        : await ref.read(repoProvider).favorites.postFavorites(
              name: name,
              address: address,
            );

    // ignore: cascade_invocations
    res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) {
        ref.invalidateSelf();
        ref.read(appBottomSheetCtrlProvider.notifier).closeSheet();
      },
    );
  }

  /// Удаление из избранных
  Future<void> destroyFavorites({required int favoriteId}) async {
    final res = await ref.read(repoProvider).favorites.destroyFavorites(
          favoriteId: favoriteId,
        );

    return res.fold(
      (l) {
        showError(l, showToast: false);
        timerCompleter.complete(false);
      },
      (r) {
        timerCompleter.complete(true);
        delayMs(Consts.humanFriendlyDelay)
            .then((value) => ref.invalidateSelf());
      },
    );
  }
}
