part of 'wallet_ctrl.cg.dart';

/// Экран подтверждение нового кошелька
class ConfirmWalletScreen extends ConsumerWidget {
  /// Экран подтверждение нового кошелька
  const ConfirmWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// слушатель для осздания кошелька
    ref.watch(createAccountCtrlProvider);
    final m = ref.watch(walletCtrlProvider);
    final c = ref.watch(walletCtrlProvider.notifier);

    return AppScaffold(
      navBarEnable: false,
      appBar: SimpleAppBar(title: 'mobile.confirmation_sid_phrase'.tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Consts.padBasic / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.sbHeight,
            AppText.bodySmallText(
              'mobile.choose_right_option'.tr(),
              color: AppColors.bwGrayBright,
            ),
            8.sbHeight,
            for (final cm in m.confirmList)
              _ConfirmBlock(
                confirmModel: cm,
                onTap: (v, b) {
                  b ? c.addWords(v) : c.removeWords(v);
                },
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppButton.limeL(
                text: 'mobile.confirm'.tr(),
                onTap: c.checkMnemonic,
              ),
            ),
            44.sbHeight,
          ],
        ),
      ),
    );
  }
}
