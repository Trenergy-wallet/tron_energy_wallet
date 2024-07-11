part of '../notifications_screen.cg.dart';

class _BaseCard extends ConsumerWidget {
  const _BaseCard(this.model, {super.key});

  final _Item model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(_itemCtrlProvider(model));
    final ctrl = ref.watch(_itemCtrlProvider(model).notifier);
    final showMarker = ref
            .watch(
              _screenCtrlProvider.select(
                (v) => v.whenData((v) => v.showSelectMarker),
              ),
            )
            .valueOrNull ??
        false;
    return VisibilityDetector(
      key: Key(model.uid),
      onVisibilityChanged: ctrl.onVisibilityInfoChanged,
      child: Row(
        children: [
          Visibility(
            visible: showMarker,
            child: Row(
              children: [
                RiveCheckbox(
                  isOn: ref.watch(_itemCtrlProvider(model)).selected,
                  onTap: (_) {
                    ref
                        .read(_itemCtrlProvider(model).notifier)
                        .toggleSelection();
                  },
                ),
                16.sbWidth,
              ],
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              padding: const EdgeInsets.all(12),
              color: m.read
                  ? AppColors.primaryDull
                  : AppColors.buttonsLimeBright.withOpacity(0.2),
              duration: const Duration(milliseconds: 150),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppText.bodySemiBoldCond(
                        m.title,
                        color: AppColors.blackBright,
                      ),
                      const Spacer(),
                      _TimeWidget(text: m.time),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1),
                        child: m.read ? null : 4.sbWidth,
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: m.read ? null : const _TagNew(),
                      ),
                    ],
                  ),
                  switch (model) {
                    __Payment() => _PaymentPart(model as __Payment),
                    __Energy() => _EnergyPart(model as __Energy),
                  },
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentPart extends ConsumerWidget {
  const _PaymentPart(this.model, {super.key});

  final __Payment model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(_itemCtrlProvider(model)) as __PaymentModel;
    return Column(
      children: [
        12.sbHeight,
        Row(
          children: [
            _Price(
              value: m.value,
              type: m.type,
              unit: m.currency,
            ),
          ],
        ),
        12.sbHeight,
        Row(
          children: [
            _Balance(
              value: m.balance,
              unit: m.currency,
            ),
          ],
        ),
      ],
    );
  }
}

class _EnergyPart extends ConsumerWidget {
  const _EnergyPart(this.model, {super.key});

  final __Energy model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(_itemCtrlProvider(model)) as __EnergyModel;
    final s = m.value.replaceAll(',', '');
    final v = (double.tryParse(s) ?? 0).toStringAsFixed(0);
    return Column(
      children: [
        12.sbHeight,
        Row(
          children: [
            AppText.bodyMediumCond(
              '+$v ${'mobile.energy'.tr()}',
              color: AppColors.blueVioletBright,
            ),
          ],
        ),
      ],
    );
  }
}

enum _PaymentType {
  income,
  outcome,
}
