// part of '../app_bottom_sheet.dart';

// class _Button extends StatelessWidget {
//   const _Button({
//     required this.onTapBtn,
//     required this.nameBtn,
//     this.isLimeBtn = true,
//     this.isShowBtn = true,
//   });

//   /// Кнопка
//   final void Function() onTapBtn;

//   /// Название кнопки
//   final String nameBtn;

//   /// Цвет кнопки
//   final bool isLimeBtn;

//   /// Показывать кнопку
//   final bool isShowBtn;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(12, 12, 12, 44),
//       color: isLimeBtn ? AppColors.primaryDull : AppColors.primaryBright,
//       child: isLimeBtn
//           ? AppButton.lime(onTap: onTapBtn, text: nameBtn)
//           : AppButton.primaryL(onTap: onTapBtn, text: nameBtn),
//     );
//   }
// }
