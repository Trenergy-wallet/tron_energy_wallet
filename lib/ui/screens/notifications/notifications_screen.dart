part of 'notifications_screen.cg.dart';

enum _PopupMenuItemType {
  choose,
  deleteAll,
}

const BorderSide _side = BorderSide.none;
const BorderRadiusGeometry _borderRadius = BorderRadius.zero;

class _CustomWalletMenuShape extends ShapeBorder {
  const _CustomWalletMenuShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final path = Path()
      ..addRRect(
        _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
      );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final rRect = _borderRadius.resolve(textDirection).toRRect(rect);

    final path = Path()
      ..moveTo(0, 10)
      ..quadraticBezierTo(0, 0, 10, 0)
      ..lineTo(rRect.width - 10, 0)
      ..quadraticBezierTo(rRect.width, 0, rRect.width, 10)
      ..lineTo(rRect.width, rRect.height - 10)
      ..quadraticBezierTo(
        rRect.width,
        rRect.height,
        rRect.width - 10,
        rRect.height,
      )
      ..lineTo(10, rRect.height)
      ..quadraticBezierTo(0, rRect.height, 0, rRect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(getOuterPath(rect)..close(), paint);
  }

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}

/// Экран уведомлений.
class NotificationsScreen extends ConsumerWidget {
  /// Экран уведомлений.
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(_screenCtrlProvider);
    return AppScaffold(
      appBar: SimpleAppBar(
        title: 'mobile.notifications'.tr(),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(color: Colors.black),
            ),
            child: PopupMenuButton<_PopupMenuItemType>(
              padding: EdgeInsets.zero,
              shape: const _CustomWalletMenuShape(),
              position: PopupMenuPosition.under,
              onSelected: (item) =>
                  ref.read(_screenCtrlProvider.notifier).showDialog(
                        context,
                        item,
                      ),
              itemBuilder: (context) => [
                PopupMenuItem<_PopupMenuItemType>(
                  value: _PopupMenuItemType.choose,
                  child: AppText.bodyMediumCond('сhoose'.tr()),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<_PopupMenuItemType>(
                  value: _PopupMenuItemType.deleteAll,
                  child: AppText.bodyMediumCond(
                    'mobile.delete_everything'.tr(),
                    color: AppColors.negativeContrastBright,
                  ),
                ),
              ],
              child: AppIcons.dots(),
            ),
          ),
          16.sbWidth,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: m.when(
          data: (d) {
            // На будущее
            //
            // if (!d.allowNotifications) {
            //   return Center(
            //     child: GestureDetector(
            //       onTap: () => ref
            //           .read(pushNotificationsProvider.notifier)
            //           .savePushFlag(true),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Text(
            //             'Нотификации отключены'.tr(),
            //           ),
            //           ElevatedButton(
            //             onPressed: () => ref
            //                 .read(pushNotificationsProvider.notifier)
            //                 .savePushFlag(true),
            //             child: Text('Включить'.tr()),
            //           ),
            //         ],
            //       ),
            //     ),
            //   );
            // }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (_, index) {
                      var sameDate = true;
                      final time = d.items[index].time;
                      if (index == 0) {
                        sameDate = false;
                      } else {
                        sameDate = time.isSameDate(d.items[index - 1].time);
                      }

                      if (index == 0 || !sameDate) {
                        return Column(
                          children: [
                            _DayDelimiter(
                              text: time.isToday
                                  ? 'mobile.today'.tr()
                                  : time.fmt(
                                      'MMM dd yyyy',
                                      ref
                                          .watch(localeControllerProvider)
                                          .languageCode,
                                    ),
                            ),
                            10.sbHeight,
                            _BaseCard(d.items[index]),
                          ],
                        );
                      }
                      return _BaseCard(d.items[index]);
                    },
                    separatorBuilder: (c, i) => 10.sbHeight,
                    itemCount: d.items.length,
                  ),
                ),
                AnimatedContainer(
                  height: (m.valueOrNull?.showSelectMarker ?? false) ? 108 : 0,
                  padding: const EdgeInsets.only(top: 12),
                  alignment: Alignment.topCenter,
                  duration: const Duration(milliseconds: 250),
                  child: const _DeletionButtons(),
                ),
              ],
            );
          },
          error: (_, __) => const Text('error'),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

/// Локальное анонимное расширение для дат.
extension on DateTime {
  /// Та же самая дата
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool get isToday {
    final today = DateTime(now.year, now.month, now.day);
    return today == DateTime(year, month, day);
  }
}

class _DeletionButtons extends ConsumerWidget {
  const _DeletionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(_screenCtrlProvider).valueOrNull?.selectedCount ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: AppButton.strokeL(
            text: 'mobile.delete'.tr(),
            isNegative: true,
            height: 52,
            isDisabled: m == 0,
            onTap: ref.read(_screenCtrlProvider.notifier).deleteSelected,
            // width: 140,
          ),
        ),
        12.sbWidth,
        Expanded(
          child: AppButton.strokeL(
            text: 'mobile.cancellation'.tr(),
            onTap: ref.read(_screenCtrlProvider.notifier).cancelSelection,
            height: 52,
            // width: 140,
          ),
        ),
      ],
    );
  }
}

class _DayDelimiter extends StatelessWidget {
  const _DayDelimiter({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.buttonsBWBright,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(text),
        ),
        Expanded(
          child: Divider(
            color: AppColors.buttonsBWBright,
          ),
        ),
      ],
    );
  }
}

class _TimeWidget extends StatelessWidget {
  const _TimeWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText.bodyCaption(text);
  }
}

/// Тег, отображающий признак "Новое сообщение"
class _TagNew extends StatelessWidget {
  const _TagNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.negativeContrastBright,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppText.bodyCaptionXS(
        'mobile.new'.tr(),
        // TODO(vvk): непонятно - цвет F7F7FA в цветовых макетах разный
        color: Colors.white,
      ),
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({
    super.key,
    required this.value,
    required this.type,
    required this.unit,
  });

  final double value;
  final String unit;

  final _PaymentType type;

  @override
  Widget build(BuildContext context) {
    final prefix = type == _PaymentType.income ? '+' : '-';
    final color = type == _PaymentType.income
        ? AppColors.positiveBright
        : AppColors.negativeBright;
    final price = numbWithoutZero(value, precision: 2);

    return AppText.bodyMediumCond('$prefix$price $unit', color: color);
  }
}

class _Balance extends StatelessWidget {
  const _Balance({super.key, required this.value, required this.unit});

  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final text = '${'mobile.balance'.tr()}: ${formatAmount(value)} $unit';
    return AppText.bodyMediumCond(text);
  }
}
