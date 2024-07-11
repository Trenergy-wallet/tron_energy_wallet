part of '../wallet_ctrl.cg.dart';

class _PhraseBlock extends StatefulWidget {
  const _PhraseBlock({
    required this.text,
    this.numb,
    this.width,
    this.onTap,
  });

  final String text;
  final String? numb;
  final double? width;
  final void Function(String, bool)? onTap;

  @override
  State<_PhraseBlock> createState() => _PhraseBlockState();
}

class _PhraseBlockState extends State<_PhraseBlock> {
  bool isSelected = false;

  void toggle() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: widget.onTap == null
            ? null
            : () {
                toggle();
                widget.onTap?.call(widget.text, isSelected);
              },
        child: Ink(
          width: widget.width,
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
          decoration: BoxDecoration(
            color:
                isSelected ? AppColors.buttonsBWBright : AppColors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.bwBrightPrimary,
            ),
          ),
          child: Row(
            mainAxisAlignment: widget.numb != null
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              if (widget.numb != null) ...[
                SizedBox(
                  width: 20,
                  child: AppText.bodyCaption(
                    widget.numb,
                    color: isSelected
                        ? AppColors.buttonsLimeBright
                        : AppColors.bwBrightPrimary,
                  ),
                ),
              ],
              Flexible(
                child: AppText.bodySemiBoldCond(
                  widget.text,
                  color: isSelected
                      ? AppColors.buttonsLimeBright
                      : AppColors.bwBrightPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
