import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/logic/repo/auth/auth_provider.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/enter_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/terms/model/terms_model.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/auth/app_scaffold_auth.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/appbar_simple.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/checkbox.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'gen/terms_ctrl.cg.g.dart';

part 'widgets/_container.dart';

part 'terms_screen.dart';

@riverpod
class _TermsCtrl extends _$TermsCtrl {
  @override
  List<TermsModel> build() {
    ref.read(authServiceProvider.notifier).fetchAuthMessage();
    const list = <TermsModel>[
      TermsModel(text: 'mobile.terms_1'),
      TermsModel(text: 'mobile.terms_2'),
      TermsModel(text: 'mobile.terms_3'),
      TermsModel(text: 'mobile.terms_4'),
    ];
    return list;
  }

  void onChanged({bool? value, required int index}) {
    final l = List<TermsModel>.from(state);
    l[index] = l[index].copyWith(accepted: true);
    state = l;
  }

  void goToCreateWallet() {
    final type = ref.read(enterCtrlProvider);
    if (type == EnterType.create) {
      appRouter.push(ScreenPaths.createWallet);
    } else {
      appRouter.push(ScreenPaths.importWallet);
    }
  }
}
