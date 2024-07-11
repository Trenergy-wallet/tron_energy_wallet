import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/notification/notification.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/push_messages_provider.cg.g.dart';

/// Контроллер для управления сохраненными нотификациями
@Riverpod(keepAlive: true)
class PushMessagesController extends _$PushMessagesController {
  // static const  _name = 'PushMessagesController';

  RepoBase get _repo => ref.read(repoProvider);

  @override
  Future<List<Notification>> build() async {
    // return <Notification>[];
    final res = await _repo.notifications.fetch();
    return res.fold(
      (l) {
        showError(l, prefixForLog: 'PushMessagesController.build');
        throw l;
      },
      (r) => r,
    );
  }
}
