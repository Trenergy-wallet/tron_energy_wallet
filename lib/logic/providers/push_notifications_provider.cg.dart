import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/push_notifications_provider.cg.g.dart';

/// Контроллер для управления сохраненными нотификациями
@Riverpod(keepAlive: true)
class PushNotifications extends _$PushNotifications {
  LocalRepo get _repo => ref.read(repoProvider).local;

  @override
  bool build() {
    return _repo.getPushFlag();
  }

  /// Сохраняет значение в репозиторий и обновляет себя.
  void savePushFlag(bool value) {
    _repo.savePushFlag(value);
    ref.invalidateSelf();
  }
}
