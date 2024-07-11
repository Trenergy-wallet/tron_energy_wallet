part of 'wallet_ctrl.cg.dart';

/// Экран импорта кошелька
class ImportWalletScreen extends HookConsumerWidget {
  /// Экран импорта кошелька
  const ImportWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// слушатель для осздания кошелька
    ref.watch(createAccountCtrlProvider);
    final m = ref.watch(walletCtrlProvider);
    final c = ref.watch(walletCtrlProvider.notifier);

    final nameCtrl = useTextEditingController();
    final mnemonicCtrl = useTextEditingController();

    useListenable(mnemonicCtrl);

    final keyboardH = MediaQuery.of(context).viewInsets.bottom;
    final isShowKeyboard = keyboardH > 100;

    final isLoading = useState(false);

    return AppScaffoldAuth(
      navBarEnable: false,
      appBar: SimpleAppBar(title: 'mobile.import_wallet'.tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Consts.padBasic / 2),
        child: Column(
          children: [
            24.sbHeight,
            AppInput(
              title: 'mobile.name_wallet'.tr(),
              hintText: 'mobile.name_wallet'.tr(),
              controller: nameCtrl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            24.sbHeight,
            AppInput.textarea(
              title: 'mobile.sid_phrase'.tr(),
              hintText: 'mobile.usually_12_18_24_words'.tr(),
              height: 120,
              controller: mnemonicCtrl,
              textInputAction: TextInputAction.done,
              titleInsertBtn: () async {
                final t = await clipBoardPast();
                mnemonicCtrl.text = t.trimRight();
              },
              onFieldSubmitted: (_) {
                c.importWallet(
                  mnemonic: mnemonicCtrl.text,
                  name: nameCtrl.text.isEmpty ? null : nameCtrl.text,
                );
              },
            ),
            const Spacer(),
            if (isShowKeyboard)
              AppButton.limeL(
                text: 'mobile.confirm'.tr(),
                isDisabled: isLoading.value || mnemonicCtrl.text.isEmpty,
                onTap: () {
                  isLoading.value = true;
                  delayMs(Consts.humanFriendlyDelay * 2).then((_) {
                    c.importWallet(
                      mnemonic: mnemonicCtrl.text,
                      name: nameCtrl.text.isEmpty ? null : nameCtrl.text,
                    );
                  });
                },
              ),
            if (isShowKeyboard) (keyboardH + 8).sbHeight,
          ],
        ),
      ),
    );
  }
}
