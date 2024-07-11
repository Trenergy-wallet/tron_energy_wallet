part of 'settings_screen.cg.dart';

///
class SettingsScreen extends ConsumerWidget {
  ///
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account =
        ref.watch(accountServiceProvider).valueOrNull ?? Account.empty;

    final ctrl = ref.watch(accountServiceProvider.notifier);

    final needPush = ref.watch(pushNotificationsProvider);

    final appBottomCtrl = ref.read(appBottomSheetCtrlProvider.notifier);
    final favoritesService = ref.watch(favoritesServiceProvider);
    final favorites = favoritesService.valueOrNull ?? [];
    final locale = ref.watch(localeControllerProvider);
    return AppScaffold(
      navBarEnable: false,
      appBar: SimpleAppBar(
        title: 'mobile.settings'.tr(),
        hasLeading: false,
      ),
      body: Column(
        children: [
          Container(
            width: screenWidth,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primaryDull,
              border: Border.all(color: AppColors.bwBrightPrimary),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Switch(
                //   value: needPush,
                //   onChanged: ctrl.switchPushNotifications,
                // ),

                ItemContainer(
                  isFirst: true,
                  title: 'mobile.push_notifications'.tr(),
                  iconPath: AppIcons.bellIcon,
                  rightWidget: RiveSwitch(
                    isOn: needPush,
                    onTap: ctrl.switchPushNotifications,
                  ),
                ),
                ItemContainer(
                  title: 'mobile.favorites_addresses'.tr(),
                  iconPath: AppIcons.addressBook,
                  rightWidget: Row(
                    children: [
                      AppText.bodySmallText('${favorites.length}'),
                      4.sbWidth,
                      AppIcons.chevronRight(),
                    ],
                  ),
                  onTap: () => appRouter.push(ScreenPaths.favorites),
                ),
                ItemContainer(
                  title: 'mobile.currency'.tr(),
                  iconPath: AppIcons.dollar,
                  rightWidget: Row(
                    children: [
                      AppText.bodySmallText(account.currency.code),
                      4.sbWidth,
                      AppIcons.chevronRight(),
                    ],
                  ),
                  onTap: appBottomCtrl.currency,
                ),
                ItemContainer(
                  title: 'mobile.safety'.tr(),
                  iconPath: AppIcons.lock,
                  rightWidget: AppIcons.chevronRight(),
                  onTap: () => appRouter.push(ScreenPaths.safety),
                ),
                // ItemContainer(
                //   title: 'theme'.tr(),
                //   iconPath: AppIcons.palette,
                //   rightWidget: Row(
                //     children: [
                //       /// theme_dark or theme_bright
                //       AppText.bodySmallText('theme_bright'.tr()),
                //       4.sbWidth,
                //       AppIcons.chevronRight(),
                //     ],
                //   ),
                //   onTap: () {},
                // ),
                ItemContainer(
                  title: 'mobile.language'.tr(),
                  iconPath: AppIcons.world,
                  rightWidget: Row(
                    children: [
                      AppText.bodySmallText(
                        (LocaleNames.of(context)?.nameOf(locale.languageCode) ??
                                '')
                            .capitalizeWords,
                      ),
                      4.sbWidth,
                      AppIcons.chevronRight(),
                    ],
                  ),
                  onTap: () {
                    ref.read(appBottomSheetCtrlProvider.notifier).language();
                  },
                ),
                ItemContainer(
                  isLast: true,
                  title: 'mobile.delete_account'.tr(),
                  color: AppColors.negativeBright,
                  iconPath: AppIcons.trashIcon,
                  hasDivider: false,
                  onTap: ref
                      .read(appBottomSheetCtrlProvider.notifier)
                      .deleteAccount,
                ),
              ],
            ),
          ),
          AppText.bodySmallTextCond(
            '${'mobile.application_version'.tr()}  v${AppConfig.appVersionUI}',
            color: AppColors.bwGrayBright,
          ),
        ],
      ),
    );
  }
}
