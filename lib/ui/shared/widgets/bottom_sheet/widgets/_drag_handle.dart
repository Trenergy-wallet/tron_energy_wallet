part of '../app_bottom_sheet.dart';

class _DragHandle extends ConsumerStatefulWidget {
  const _DragHandle();

  @override
  ConsumerState<_DragHandle> createState() => _DragHandleState();
}

class _DragHandleState extends ConsumerState<_DragHandle> {
  double defHeight = 0;

  @override
  void initState() {
    super.initState();
    final appBottomM = ref.read(appBottomSheetCtrlProvider);
    defHeight = appBottomM.height;
  }

  @override
  Widget build(BuildContext context) {
    final appBottomM = ref.watch(appBottomSheetCtrlProvider);
    final appBottomC = ref.watch(appBottomSheetCtrlProvider.notifier);
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        // appBottomC.updateHeight(details.primaryDelta!);
      },
      onLongPressMoveUpdate: (details) {
        /// dinamic height
        /// localOffsetFromOrigin - смещение относительно начала экрана
        final dh = appBottomM.defHeight - details.localOffsetFromOrigin.dy;

        /// есмещение выше 120 (свайп вниз) то закрываем боттом слишком
        if (!details.localOffsetFromOrigin.dy.isNegative &&
            details.localOffsetFromOrigin.dy >= 120) {
          appBottomC.closeSheet();

          /// есмещение выше 120 (свайп вврех) то закрываем боттом слишком
        } else if (details.localOffsetFromOrigin.dy.isNegative &&
            details.localOffsetFromOrigin.dy <= -120) {
          appBottomC.updateHeight(appBottomM.defHeight);

          /// меняем высоту боттом шита
        } else {
          appBottomC.updateHeight(dh);
        }
      },
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          ref.read(appBottomSheetCtrlProvider.notifier).closeSheet();
        }
      },
      child: Container(
        width: screenWidth,
        padding: const EdgeInsets.only(top: 4, bottom: 17),
        color: AppColors.transparent,
        child: Center(
          child: Container(
            height: 4,
            width: 32,
            decoration: BoxDecoration(
              color: AppColors.bwGrayDull,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
            ),
          ),
        ),
      ),
    );
  }
}
