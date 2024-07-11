import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Вывод тоста об ошибке
Future<void> appAlert({
  /// Текст ошибки
  required String value,
  Color? color,
  int timeInSec = 1,
  ToastGravity? gravity,
}) async {
  await delayMs(Consts.humanFriendlyDelay).then(
    (_) => Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: color ?? AppColors.bwBrightPrimary,
      textColor: Colors.white,
      fontSize: 16,
      timeInSecForIosWeb: timeInSec,
    ),
  );
}
