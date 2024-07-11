import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_input.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';

/// Добавление в избранное
class AddFavoriteSheet extends HookConsumerWidget {
  /// Добавление в избранное
  const AddFavoriteSheet({
    this.name,
    this.address,
    this.isEdit = false,
    this.id,
    super.key,
  });

  /// Имя
  final String? name;

  /// Адрес
  final String? address;

  /// Режим редактирования
  final bool isEdit;

  /// ID Favorite
  final int? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBottomSheetC = ref.read(appBottomSheetCtrlProvider.notifier);
    final c = ref.read(favoritesServiceProvider.notifier);

    final nameCtrl = useTextEditingController(text: name);
    final addressCtrl = useTextEditingController(text: address);

    useListenable(nameCtrl);
    useListenable(addressCtrl);

    final keyboardH = MediaQuery.of(context).viewInsets.bottom;
    final isShowKeyboard = keyboardH > 100;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: Consts.gapHoriz12,
              child: Column(
                children: [
                  12.sbHeight,
                  AppInput(
                    title: 'mobile.name_address'.tr(),
                    hintText: 'mobile.contact'.tr(),
                    controller: nameCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      // decimal: true,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  24.sbHeight,
                  AppInput(
                    title: 'mobile.wallet_address'.tr(),
                    hintText: 'mobile.insert_address'.tr(),
                    controller: addressCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    // textInputAction: TextInputAction.done,
                  ),
                  20.sbHeight,
                ],
              ),
            ),
          ),
        ),
        if (isShowKeyboard)
          ButtonBottomSheet(
            padHoriz: 12,
            isDisabled: nameCtrl.text.isEmpty || addressCtrl.text.isEmpty,
            onTapBtn: () {
              appBottomSheetC.pinConfirm(
                ifEqualsStartFunc: () {
                  c.postPatchFavorite(
                    name: nameCtrl.text,
                    address: addressCtrl.text,
                    isEdit: isEdit,
                    id: id,
                  );
                },
              );
            },
            nameBtn: 'mobile.save'.tr(),
          ),
        if (isShowKeyboard) (keyboardH + 8).sbHeight,
      ],
    );
  }
}
