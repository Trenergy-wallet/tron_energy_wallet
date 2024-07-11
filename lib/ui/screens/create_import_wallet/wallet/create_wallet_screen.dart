part of 'wallet_ctrl.cg.dart';

/// Экран создания нового кошелька
class CreateWalletScreen extends ConsumerStatefulWidget {
  /// Экран создания нового кошелька
  const CreateWalletScreen({this.showRules = true, super.key});

  /// Показывать ли правила
  final bool showRules;

  @override
  ConsumerState<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends ConsumerState<CreateWalletScreen> {
  @override
  void initState() {
    super.initState();
    addPostFrameCallback(() {
      ref.watch(walletCtrlProvider.notifier).generateMnemonic();
      if (widget.showRules) {
        showAppModalBottomSheet<void>(
          context: context,
          children: [const _RulesBottomSheet()],
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// слушатель для осздания кошелька
    ref.watch(createAccountCtrlProvider);
    final m = ref.watch(walletCtrlProvider);

    final c = ref.watch(walletCtrlProvider.notifier);
    final mnemonic = m.mnemonic.split(' ');

    return AppScaffoldAuth(
      navBarEnable: false,
      appBar: SimpleAppBar(title: 'mobile.new_wallet'.tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Consts.padBasic / 2),
        child: Column(
          children: [
            24.sbHeight,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.negativeLightMid,
                borderRadius: Consts.borderRadiusAll8,
              ),
              child: Row(
                children: [
                  AppIcons.icon(AppIcons.shieldExclamation),
                  8.sbWidth,
                  Flexible(
                    child: AppText.bodySmallTextCond(
                      'mobile.make_sure_no_one_looking_screen'.tr(),
                      color: AppColors.negativeContrastBright,
                    ),
                  ),
                ],
              ),
            ),
            24.sbHeight,
            Center(
              child: Wrap(
                spacing: 2,
                runSpacing: 2,
                alignment: WrapAlignment.center,
                children: [
                  for (var i = 0; i < mnemonic.length; i++)
                    _PhraseBlock(
                      numb: (i + 1).toString(),
                      text: mnemonic[i],
                      width: (screenWidth - Consts.padBasic - 4) / 3,
                    ),
                ],
              ),
            ),
            24.sbHeight,
            AppButtonText(
              text: 'mobile.copy_sid_phrase'.tr(),
              onTap: () {
                clipBoardCopy(m.mnemonic);
              },
              leftPathIcon: AppIcons.copyIcon,
            ),
            const Spacer(),
            AppButton.limeL(
              text: 'mobile.i_saved_sid_phrase'.tr(),
              onTap: c.goToConfirmWallet,
            ),
            44.sbHeight,
          ],
        ),
      ),
    );
  }
}
