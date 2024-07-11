import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' hide Key;
import 'package:flutter/material.dart' as material;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';
import 'package:trenergy_wallet/ui/shared/app_alert.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Геттер текущего времени.
DateTime get now => DateTime.now();

/// Helper для штатного /// debugPrint,
/// Так как штатный оказывается не убирается в релизе.
void debugModePrint(String? message, {int? wrapWidth}) {
  if (!kReleaseMode) {
    debugPrint(message, wrapWidth: wrapWidth);
  }
}

/// Сокращатель для [Future.delayed] в миллисекундах.
Future<void> delayMs(int milliseconds) async {
  await Future<void>.delayed(Duration(milliseconds: milliseconds));
}

/// Сокращатель для [SchedulerBinding.addPostFrameCallback].
void addPostFrameCallback(VoidCallback callback) {
  SchedulerBinding.instance.addPostFrameCallback((_) => callback());
}

/// Генератор случайного ключа.
String generateKey(int length, {String seedString = ''}) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

  /// Используем хэш код строки в качестве семени
  final rnd = Random(seedString.hashCode);

  final keyPart = String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
    ),
  );

  // Вставляем seedString в сгенерированный ключ
  return seedString + keyPart;
}

///
String encryptUtils({
  required String secretKey,
  required String str,
}) {
  final key = Key.fromUtf8(secretKey);

  final b64key = Key.fromUtf8(base64Url.encode(key.bytes).substring(0, 32));
  final fernet = Fernet(b64key);
  final encrypter = Encrypter(fernet);

  final encrypted = encrypter.encrypt(str);
  return encrypted.base64;
}

///
String decryptUtils({
  required String secretKey,
  required String encrypted,
}) {
  final key = Key.fromUtf8(secretKey);

  final b64key = Key.fromUtf8(base64Url.encode(key.bytes).substring(0, 32));
  final fernet = Fernet(b64key);
  final encrypter = Encrypter(fernet);

  final decrypted = encrypter.decrypt64(encrypted);
  return decrypted;
}

/// Перезапуск запроса
void reloadRequest(Ref ref) {
  delayMs(Consts.reloadRequest).then((value) => ref.invalidateSelf());
}

/// Запись в лог + показ ошибки тостом (если это предумотрено статус кодом)
///
/// prefixForLog - префикс для лога, чтобы можно было передавать
/// контекстные данные, например, имя метода, в котором произошла ошибка.
///
/// ```dart
/// showError(l, prefixForLog: 'getNews');
/// ```
Future<dynamic> showError(
  ExtendedErrors l, {
  String? prefixForLog,
  bool showToast = true,
  int timeInSec = 1,
}) async {
  InAppLogger.instance.logInfoMessage(prefixForLog ?? 'showError', l);

  if (showToast) {
    // Сперва пробуем отобразить главную ошибку.
    if (l.error.isNotEmpty) {
      unawaited(
        appAlert(
          value: l.error,
          color: AppColors.blackBright,
          timeInSec: timeInSec,
        ),
      );
    } else if (l.smartErrorsValue.length == 1) {
      unawaited(
        appAlert(
          /// очистим вывод от ненужных скобок
          value:
              l.smartErrorsValue.toString().replaceAll(RegExp(r'[\[\]]'), ''),
          color: AppColors.blackBright,
          timeInSec: timeInSec,
        ),
      );
    } else {
      unawaited(
        appAlert(
          value: '${l.smartErrorsValue[0]} + ${l.smartErrorsValue.length - 1} '
              'errors',
          color: AppColors.blackBright,
          timeInSec: timeInSec,
        ),
      );
    }
  }
}

/// From GetX package
/// This "function" class is the implementation of `debouncer()` Worker.
/// It calls the function passed after specified [delay] parameter.
/// Example:
/// ```
/// final delayed = Debouncer( delay: Duration( seconds: 1 )) ;
/// print( 'the next function will be called after 1 sec' );
/// delayed( () => print( 'called after 1 sec' ));
/// ```
class Debouncer {
  // ignore: public_member_api_docs
  Debouncer({this.delay});

  /// Задержка отработки
  final Duration? delay;
  Timer? _timer;

  /// Какие действия мы выполняем после истечения задержки
  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay!, action);
  }

  /// Notifies if the delayed call is active.
  bool get isRunning => _timer?.isActive ?? false;

  /// Cancel the current delayed call.
  void cancel() => _timer?.cancel();
}

/// Оборачиваем в try/catch и возвращаем константное значяение
/// для кривых дат типа "15-08-2023 22:50:06"
DateTime tryParseShitToDateTime(String? dateString) {
  try {
    return parseDate(dateString ?? '');
  } on Exception catch (_) {
    return Consts.invalidDateTime;
  }
}

/// Перевод даты из строки "dd-mm-yyyy hh:mm:ss" в DateTime.
///
/// т.к. бэк отдает дату в строке с секундами.
/// секунды отбрасываем. И переводим дату в DateTime
/// пример входа: "15-08-2023 22:50:06"
DateTime parseDate(String dateString) {
  /// т.к. бэк отдает дату в строке с секундами.
  /// секунды отбрасываем. И переводим дату в DateTime
  /// пример входа: "15-08-2023 22:50:06"
  final date = dateString.split(' ');
  final dateParts = date.first.split('-');

  var day = 0;
  var month = 0;
  var year = 0;

  if (dateParts.length > 2) {
    month = int.parse(dateParts[1]);
    year = int.parse(dateParts[2]);

    day = int.parse(dateParts[0]);
  } else {
    month = int.parse(dateParts[0]);
    year = int.parse(dateParts[1]);

    day = 1;
  }

  return DateTime(year, month, day);
}

/// Получаем данные из буфера обмена
Future<String> clipBoardPast() async {
  // Получаем данные из буфера обмена
  final data = await Clipboard.getData('text/plain');
  if (data != null) {
    // Устанавливаем текст из буфера обмена в TextField
    return data.text ?? '';
  }
  return '';
}

/// Получаем данные из буфера обмена
Future<void> clipBoardCopy(String v, {String? tooltip}) async {
  await Clipboard.setData(ClipboardData(text: v)).then(
    (_) {
      appAlert(
        value: tooltip ?? 'mobile.tooltip_copy'.tr(),
        timeInSec: 2,
      );
    },
  );
}

/// после запятой 8 значения если 0 то не пишется
String numbWithoutZero(double d, {int precision = 6}) {
  var asFixedInt = 0;
  if (d.toString().contains('.')) {
    final fee = d.toString().split('.').last;

    for (var i = 0;
        i < (fee.length >= precision ? precision : fee.length);
        ++i) {
      final ii = int.tryParse(fee[i]) ?? 0;
      if (ii > 0) {
        asFixedInt = i + 1;
      }
    }
  }
  final tmpStr = d.toStringAsFixed(asFixedInt);
  // так избегаем удаления интового 0
  final double2 = double.tryParse(tmpStr) ?? 0.00;
  return double2.truncateToDouble() == double2
      ? double2.toInt().toString()
      : double2.toString();
  // Предыдущий вариант. Но оставляет последний 0 если было округление,
  // вот так: 12.196 -> 12.20
  // return d.toStringAsFixed(asFixedInt);
}

/// Форматируем сумму для ввода по макету
String formatAmount(String amount) {
  // Удаляем все символы, кроме цифр и точки
  var newText = amount.replaceAll(RegExp('[^0-9.]'), '');

  // Удаляем все точки, кроме одной
  newText = newText.replaceAll(RegExp(r'\.+'), '.');

  // Добавляем пробелы после каждого третьего числа,
  // если точка не находится в конце
  newText = newText.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match.group(0)} ',
  );

  // Удаляем лишние пробелы в начале и конце
  newText = newText.trim();

  // Ограничиваем количество цифр после точки до двух
  if (newText.contains('.')) {
    newText = newText.replaceAll(' .', '.');
    final parts = newText.split('.');
    newText = '${parts[0]}.${parts[1].replaceAll(' ', '')}';
  }

  return newText;
}

/// Короткое представление суммы
String compactCurrency(num value) {
  var v = value;
  if (v < 0) v = 0;

  const locale = Locale('en_En');

  return NumberFormat.compactCurrency(
    locale: locale.toString(),
    symbol: '',
  ).format(v);
}

/// Вычисляем процент изменения цены
double calculatePercentageChange(double oldPrice, double newPrice) {
  final difference = newPrice - oldPrice;
  final percentageChange = (difference / oldPrice) * 100;
  return percentageChange;
}

/// Форматируем число с точкой до двух цифр после точки
class CustomNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = formatAmount(newValue.text);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

/// Определяем цвет текста в зависимости от цвета
bool getColorLuminance(Color color) {
  return color.computeLuminance() < 0.179;
}

/// Получаем активный токен TRX
AppAsset? geAppAsset(AsyncValue<Account> accountService) {
  AppAsset? appAsset;

  final account = accountService.valueOrNull ?? Account.empty;
  for (final w in account.assets) {
    if (w.token.name == Consts.trx || w.token.name == Consts.tron) {
      appAsset = w;
    }
  }
  return appAsset;
}

/// Определяем цвет текста в зависимости от процента
Color getColorForEnergy(double percent) {
  if (percent >= 0 && percent <= .2) {
    return const Color(0xffF35D2E);
  }
  if (percent >= .2 && percent <= .5) {
    return const Color(0xffF3D42E);
  }
  if (percent >= .5 && percent <= 1) {
    return const Color(0xff32F728);
  }

  return const Color(0xff32F728);
}

/// Определяем цвет текста в зависимости от процента
material.Widget getProgressIconRound(double percent) {
  if (percent >= 0 && percent <= .2) {
    return AppIcons.progressBarEnd0();
  }
  if (percent >= .2 && percent <= .5) {
    return AppIcons.progressBarEnd20();
  }
  if (percent >= .5 && percent <= 1) {
    return AppIcons.progressBarEnd50();
  }

  return AppIcons.progressBarEnd50();
}
