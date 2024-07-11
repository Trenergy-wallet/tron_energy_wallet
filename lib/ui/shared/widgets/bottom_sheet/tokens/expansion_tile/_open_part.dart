part of 'close_part.dart';

class _OpenPart extends ConsumerWidget {
  const _OpenPart({
    required this.list,
    required this.walletId,
    this.isOpen = false,
  });

  final bool isOpen;
  final int walletId;
  final List<AppToken> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        final item = list.elementAt(index);
        final shortName =
            item.shortName == Consts.tron ? Consts.trx : item.shortName;

        return Row(
          key: ValueKey(item.name),
          children: [
            ImgNetwork(
              width: 32,
              height: 32,
              pathImg: item.icon,
            ),
            6.sbWidth,
            AppText.bodySmallText(
              shortName,
              color: AppColors.blackBright,
            ),
            const Spacer(),
            RiveSwitch(
              isOn: item.isAddedToAssets,
              onTap: (v) {
                final blockchain =
                    ref.read(blockchainsServiceProvider.notifier);

                if (v) {
                  blockchain.addToken(
                    id: item.id,
                    walletId: walletId,
                  );
                } else {
                  blockchain.deleteToken(
                    id: item.id,
                    walletId: walletId,
                  );
                }
              },
            ),
          ],
        );
      },
      separatorBuilder: (_, __) => 16.sbHeight,
    );
  }
}
