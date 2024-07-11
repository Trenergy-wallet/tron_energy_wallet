import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';

/// Расширения для String?
extension StringNX on String? {
  /// Безопасный перевод даты из текста в домен
  DateTime tryParseToDateTime() {
    return DateTime.tryParse(this ?? '') ?? Consts.invalidDateTime;
  }
}

/// Расширения для int?
extension IntNX on int? {
  /// int? => bool? подразумевая что любое значение > 0 дает true
  bool? get toBoolOrNull => this != null ? this! > 0 : null;

  /// Добываем DateTime через DateTime.fromMillisecondsSinceEpoch
  DateTime get parseToLocalDateTime {
    return DateTime.fromMillisecondsSinceEpoch((this ?? 0) * 1000).toLocal();
  }

  /// Конверт в строку длиной минимум 2 символа
  String get doubleDigitsHour {
    return this == null
        ? '-1'
        : (this ?? 0) < 10
            ? '0$this'
            : toString();
  }
}

/// Расширения на String
extension StringX on String {
  /// Просто удобный маркер для быстрого поиска в коде нелокализованных строк.
  /// Возвращает текущую строку.
  String get hardcoded => this;

  /// Ограничение на максимальную длину
  String maxLen(int max) {
    assert(max > -1, 'maxLen Cant be negative');
    return length < max ? this : substring(0, max);
  }

  /// Переводит первый символ в верхний регистр каждого слова в строке
  String get capitalizeWords => split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  /// Эта функция принимает один аргумент partLength и возвращает часть строки.
  /// В первую очередь, происходит проверка с помощью выражения assert, что
  /// значение partLength не отрицательно. Если partLength равен нулю, то
  /// функция возвращает текущую строку.
  /// Если partLength * 2 >= length (длина части больше или равна половине
  /// длины строки), то также возвращается текущая строка.
  /// В противном случае, функция возвращает часть строки с начала и конца,
  /// которые равны partLength. Возвращаемая часть выглядит как "$start..$end".
  String safePart(int partLength) {
    assert(partLength > -1, 'maxLen Cant be negative');
    if (partLength == 0) {
      return this;
    }
    if (partLength * 2 >= length) {
      return this;
    }
    final start = substring(0, partLength);
    final end = substring(length - partLength, length);
    return '$start..$end';
  }

  /// DateTime из String с обработкой Exception (возвращается DateTime.now)
  /// Формат yyyy-MM-dd
  DateTime get dateTimeFromBackend {
    try {
      return DateFormat('yyyy-MM-dd').parse(this);
    } on Exception catch (_) {
      return now;
    }
  }

  /// DateTime из String с обработкой Exception (возвращается DateTime.now)
  /// Формат yyyy-MM-dd HH:mm:ss
  DateTime get dateTimeWithTimeFromBackend {
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(this);
    } on Exception catch (_) {
      return now;
    }
  }

  /// Проверка на email
  bool isValidEmail() {
    return RegExp(Consts.emailRegex).hasMatch(this);
  }

  /// Получить короткий адрес кошелька
  String get shortAddressWallet {
    if (isEmpty) return this;
    final firstSixElements = substring(0, 6);
    var lastSixElements = '';
    if (length > 5) {
      lastSixElements = substring(length - 6);
    }
    return '$firstSixElements...$lastSixElements';
  }

  ///
  String ifEmptyString(String str) {
    return isEmpty ? str : this;
  }
}

/// Расширения на num
extension EdgeInsetsX on num {
  /// Превращаем число в EdgeInsets.symmetric c horizontal
  EdgeInsets get insetsHor => EdgeInsets.symmetric(horizontal: this * 1.0);

  /// Превращаем число в EdgeInsets.symmetric c vertical
  EdgeInsets get insetsVert => EdgeInsets.symmetric(vertical: this * 1.0);

  /// Превращаем число в EdgeInsets.all
  EdgeInsets get insetsAll => EdgeInsets.all(this * 1.0);
}

/// Расширения для [TextEditingController]
extension TextEditingControllerX on TextEditingController {
  /// Устанавливает текст и одновременно позиционирует курсор в конец.
  ///
  /// ```dart
  ///  someTextController.withText(value);
  /// ```
  TextEditingController adjust(String text) {
    this.text = text;
    selection = TextSelection.collapsed(offset: text.length);
    return this;
  }
}

/// Расширения на DateTime
extension DateTimeX on DateTime {
  /// Превращаем DateTime в строку dd-MM-yyyy
  String get stringFromDateTime {
    try {
      return DateFormat('dd-MM-yyyy').format(this);
    } on Exception catch (_) {
      return '';
    }
  }

  /// Превращаем DateTime в строку yyyy-MM-dd for api
  String get stringDateTimeForApi {
    try {
      return DateFormat('yyyy-MM-dd').format(this);
    } on Exception catch (_) {
      return '';
    }
  }

  /// Проверка, является ли DateTime Consts.invalidDateTime
  bool get isValid {
    return this != Consts.invalidDateTime;
  }

  /// Превращаем DateTime в строку dd/MM/yyyy HH:mm
  String convertDateTimeForUi() {
    if (this == Consts.invalidDateTime) return '';
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }

  /// Свободное форматирование по заданному формату.
  String fmt(String format, [String? locale]) {
    if (this == Consts.invalidDateTime) return '';
    return DateFormat(format, locale).format(this);
  }
}

/// Улучшаем ref
extension RefExtention on AutoDisposeRef<Object?> {
  /// Чтобы элементы не убивались сразу после выхода за область отображения
  /// добавим возможность для выбора их времени жизни. В будущем, этот метод
  /// обещают встроить в riverpod
  void cacheFor(Duration duration) {
    final keepAliveLink = keepAlive();
    Timer(duration, keepAliveLink.close);
  }
}

/// Функция сравнения наполнения листов
extension ListCompareX on List<Object> {
  /// Функция сравнения наполнения листов (содержат одни и те же элементы)
  bool containsSameElements(List<Object> v2) {
    if (length == v2.length) {
      final v2copy = v2.toList();
      for (final e in this) {
        if (v2copy.contains(e)) {
          v2copy.remove(e);
        } else {
          break;
        }
      }
      if (v2copy.isEmpty) return true;
    }
    return false;
  }
}

/// Расширения для BuildContext
extension BuildContextX on BuildContext {
  /// Размер экрана по ширине
  double get w => MediaQuery.of(this).size.width;

  /// Размер экрана по высоте
  double get h => MediaQuery.of(this).size.height;

  /// Размер экрана по ширине / 2
  double get wCenter => w / 2;
}
