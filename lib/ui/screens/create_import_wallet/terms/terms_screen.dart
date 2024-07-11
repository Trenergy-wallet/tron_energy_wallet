part of 'terms_ctrl.cg.dart';

/// Экран Условия использования
class TermsScreen extends ConsumerWidget {
  /// Экран Условия использования
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enterM = ref.watch(enterCtrlProvider);
    final m = ref.watch(_termsCtrlProvider);
    final c = ref.watch(_termsCtrlProvider.notifier);

    return AppScaffoldAuth(
      navBarEnable: false,
      appBar: SimpleAppBar(title: 'mobile.conditions_use'.tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            for (var i = 0; i < m.length; i++) ...[
              _Container(
                text: m[i].text.tr(),
                accepted: m[i].accepted,
                onChanged: (v) => c.onChanged(value: v, index: i),
              ),
              8.sbHeight,
            ],
            const Spacer(),
            AppButton.limeL(
              text: enterM == EnterType.create
                  ? 'mobile.show_sid_phrase'.tr()
                  : 'mobile.import_wallet_phrase'.tr(),
              onTap: c.goToCreateWallet,
              isDisabled: m.any((e) => !e.accepted),
            ),
            44.sbHeight,
          ],
        ),
      ),
    );
  }
}
