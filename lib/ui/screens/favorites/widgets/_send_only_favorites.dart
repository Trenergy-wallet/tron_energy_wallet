part of '../favorites_screen.dart';

class _SendOnlyFavorites extends HookConsumerWidget {
  const _SendOnlyFavorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localRepo = ref.watch(repoProvider).local;
    final useFavList = localRepo.getOnlyFavorites();

    final appBottom = ref.watch(appBottomSheetCtrlProvider.notifier);

    /// некая заглушка, чтоб была перерисовка виджета
    final useFav = useState(useFavList);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: Consts.borderRadiusAll16,
        color: AppColors.primaryDull,
        border: Border.all(
          color: AppColors.bwBrightPrimary,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: AppText.bodyRegularCond(
              'mobile.sending_funds_only_addresses_favorites'.tr(),
            ),
          ),
          12.sbWidth,
          RiveSwitch(
            onTap: (v) {
              if (!v) {
                appBottom.pinConfirm(
                  ifEqualsStartFunc: () {
                    localRepo.saveOnlyFavorites(v);
                    useFav.value = false;
                    appBottom.closeSheet();
                  },
                );
              } else {
                useFav.value = true;
                localRepo.saveOnlyFavorites(v);
              }
            },
            isOn: useFavList,
            isNeedAutoTap: false,
          ),
        ],
      ),
    );
  }
}
