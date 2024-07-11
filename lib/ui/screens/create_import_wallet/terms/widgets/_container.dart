part of '../terms_ctrl.cg.dart';

class _Container extends StatefulWidget {
  const _Container({
    required this.text,
    required this.accepted,
    required this.onChanged,
  });

  final String text;
  final bool accepted;
  final void Function(bool?) onChanged;

  @override
  State<_Container> createState() => _ContainerState();
}

class _ContainerState extends State<_Container> {
  // bool accepted = false;

  // @override
  // void initState() {
  //   super.initState();
  //   accepted = widget.accepted;
  // }

  // void toggle() {
  //   setState(() {
  //     accepted = true;
  //   });
  //   widget.onChanged(true);
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(true),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.bwBrightPrimary,
          ),
        ),
        child: Row(
          children: [
            AbsorbPointer(
              child: RiveCheckbox(
                isOn: widget.accepted,
                // disabled: widget.accepted,
                onTap: (_) {},
              ),
            ),
            8.sbWidth,
            Flexible(
              child: AppText.bodyRegularCond(
                widget.text,
                color: widget.accepted
                    ? AppColors.bwGrayBright
                    : AppColors.bwBrightPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
