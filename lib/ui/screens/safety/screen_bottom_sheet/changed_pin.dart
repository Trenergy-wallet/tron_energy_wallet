part of '../change_pincode_ctrl.cg.dart';

/// Добавление в избранное
class ChangedPinSheet extends HookConsumerWidget {
  /// Добавление в избранное
  const ChangedPinSheet({
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

    return Column(
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                AppIcons.walletMan(
                  width: 243,
                  height: 243,
                ),
                40.sbHeight,
                Padding(
                  padding: Consts.gapHoriz12,
                  child: AppText.bodyRegularCond('mobile.pin_changed'.tr()),
                ),
                51.sbHeight,
              ],
            ),
          ),
        ),
        Flexible(
          child: ButtonBottomSheet(
            padHoriz: 12,
            onTapBtn: appBottomSheetC.closeSheet,
            nameBtn: 'mobile.great'.tr(),
          ),
        ),
      ],
    );
  }
}
