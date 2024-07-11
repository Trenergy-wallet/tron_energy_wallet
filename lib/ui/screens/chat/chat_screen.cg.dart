import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/enter/app_scaffold.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/chat_coming_soon.dart';

part 'gen/chat_screen.cg.g.dart';
part 'chat_screen.dart';

@riverpod
class _ChatCtrl extends _$ChatCtrl {
  LocalRepo get localRepo => ref.read(repoProvider).local;

  @override
  bool build() {
    return false;
  }
}
