part of '../wallet_ctrl.cg.dart';

/// Widget слова подтверждения
class _ConfirmBlock extends StatelessWidget {
  /// Widget слова подтверждения
  const _ConfirmBlock({required this.confirmModel, required this.onTap});

  final ConfirmSeedModel confirmModel;
  final void Function(String, bool)? onTap;

  @override
  Widget build(BuildContext context) {
    /// шринина бллока кнопки
    final w = (screenWidth - Consts.padBasic - 4) / 3;

    final list = confirmModel.findSeedWord;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.sbHeight,
        AppText.bodySubTitle(
          '${'mobile.word'.tr()} #${confirmModel.findNumber}',
        ),
        8.sbHeight,
        Wrap(
          spacing: 2,
          runSpacing: 2,
          children: [
            for (var i = 0; i < list.length; i++)
              _PhraseBlock(
                text: list[i],
                width: w,
                onTap: onTap,
              ),
          ],
        ),
      ],
    );
  }
}
