part of '../current_asset.cg.dart';

class _SendReceiveBtn extends ConsumerWidget {
  const _SendReceiveBtn({
    required this.onTapSend,
    this.onTapReceive,
  });

  final void Function() onTapSend;
  final void Function()? onTapReceive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountService = ref.watch(accountServiceProvider);
    final account = accountService.valueOrNull ?? Account.empty;

    final hasAssets = account.assets.isNotEmpty;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Container(
          icon: AppIcons.sendUp(),
          text: 'mobile.send'.tr(),
          onTap: onTapSend,
        ),
        40.sbWidth,
        _Container(
          icon: AppIcons.receiveDown(),
          text: 'mobile.get'.tr(),
          onTap: hasAssets
              ? onTapReceive
              : () {
                  appAlert(value: 'mobile.list_assets_empty'.tr());
                },
        ),
      ],
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.icon,
    required this.text,
    this.onTap,
  });

  final Widget icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.bwBrightPrimary,
                ),
              ),
              child: icon,
            ),
          ),
          8.sbHeight,
          AppText.mButtonRegular(
            text,
            color: AppColors.bwBrightPrimary,
          ),
        ],
      ),
    );
  }
}
