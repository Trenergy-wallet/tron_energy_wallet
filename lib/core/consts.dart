import 'package:flutter/material.dart';

/// Константы живут тут
class Consts {
  /// Слова для TRX
  static const trxWords = 'TRX,TRON';

  /// TRX
  static const trx = 'TRX';

  /// TRON
  static const tron = 'TRON';

  /// Высота маленького экрана
  static const smallScreenHeight = 700;

  /// Это можно использовать для проверки версионности
  /// кешированных в репе данных.
  static const appVersion = 1;

  /// default icon size
  static const iconSize = 24.0;

  /// Регулярка email
  static const emailRegex =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  /// Регулярка phone
  static const phoneRegex =
      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';

  /// каталог хранения файлов переводов
  static const localePath = 'assets/translations';

  /// количество нулей после запятой
  static const decimalDef = 6;

  /// Ошибочное значение -1 int
  static const invalidIntValue = -1;

  /// Ошибочное значение -1 double
  static const invalidDoubleValue = -1.0;

  /// int 100
  static const delayMill100 = 100;

  /// int 2000
  static const exitTimeInMillis = 2000;

  /// Время перезапуска запроса
  static const reloadRequest = 10000;

  /// int 250
  static const humanFriendlyDelay = 250;

  /// int 1500
  static const delayTimePin = 1500;

  /// это 2мб в байтах
  static const twoMb = 2097152;

  /// Высота AppBar
  static const toolbarHeight = 56.0;

  /// Решено делать такую инвалидную дату.
  static final DateTime invalidDateTime = DateTime(1900);

  /// Locale('ru')
  static const ruLocale = Locale('ru');

  /// Locale('en')
  static const enLocale = Locale('en');

  /// При отсутствии связи как часто обновляем данные
  static const reloadTimeout = Duration(seconds: 2);

  /// Длина адреса
  static const addressLength = 34;

  /// double Horizontal padding
  static const horizontalPadding = 16.0;

  /// Высота кнопок обратной связи
  // в дизайне 48, уменьшаем до 38 по таске
  static const replyButtonHeight = 38.0;

  /// Базовая высота для всяких виджетов типа инпутов и текстов.
  static const heightBasic = 48.0;

  /// 2048кб, но ставим чуть меньше, на всякий случай
  static const maxImageSizeInBytes = 2048000;

  /// Время жизни autoDipose provider-ов
  static const providerTTL = Duration(minutes: 5);

  /// отступы
  static const padBasic = 40.0;

  /// Почта риелтора по-умолчанию
  static const realtorDefaultEmail = 'trenergy EMAIL';

  /// Firebase dynamic link
  static const firebaseDynamicLinkPrefix = 'LINK FIREBASE TRON ENERGY';

  /// Сообщение, отправляемое WebView в момент успеха.
  static const walletConnectResultSuccess = 'Connect finish';

  /// Сообщение, отправляемое WebView в момент ошибки.
  static const walletConnectResultFailure = 'Error wallet';

  /// Тестовое сообщение, отправляемое WebView в момент отправки запроса прав.
  static const walletConnectResultTest = 'Wallet Test';

  /// левая стрелочка в пагинации
  static const leftArrowPaging = -1;

  /// правая стрелочка в пагинации
  static const rightArrowPaging = -2;

  ///
  static const curveCubic = Cubic(0, .31, .54, 1);

  ///
  static const animateDuration = Duration(milliseconds: 300);

  /// BorderRadius
  static const borderRadiusAll8 = BorderRadius.all(Radius.circular(8));

  /// BorderRadius
  static const borderRadiusAll10 = BorderRadius.all(Radius.circular(10));

  /// BorderRadius
  static const borderRadiusAll12 = BorderRadius.all(Radius.circular(12));

  /// BorderRadius
  static const borderRadiusAll16 = BorderRadius.all(Radius.circular(16));

  /// Padding для bottom sheet
  static const gapHoriz12 = EdgeInsets.symmetric(horizontal: 12);

  /// ключ для перехода на экран токена
  static const asset = 'asset';

  /// Ключ для bottom navigation bar
  static const bottomNavKey = 'bottomNav';

  /// Ошибка при проверке адреса
  static const walletCheckError = 'walletCheckError';

  /// Сколько элементов на странице
  static const perPage = 10;

  /// Некая константа, взятая по аналогии с нашим фронтендом (Рома)
  static const transactionAverageCost = 35000;

  /// TRX - это основная валюта блокчейна Tron. Как и у Bitcoin, у TRX есть
  /// самая маленькая единица, называемая SUN. 1 TRX равен 1 000 000 SUN.
  /// Это стандартная практика для многих криптовалют, чтобы избежать потери
  /// точности при выполнении математических операций 1.
  /// Когда вы умножаете или делите TRX на 1 000 000, вы фактически
  /// преобразуете его из основной единицы (TRX) в самую маленькую единицу
  /// (SUN). Это обычно делается для более точных расчетов, особенно при работе
  /// с сетью Tron.
  /// Когда вы делите на 1 000 000, вы преобразуете SUN обратно в TRX.
  /// Это обычно делается для отображения суммы в более удобном для человека
  /// формате.
  static const trxMillion = 1000000;

  /// Цена одной энергии в санах
  static const trxSun = 200;

  /// Type:
  /// 1 - transfer
  /// 2 - energy
  /// Тип транзакции
  static const typeTransfer = 1;

  /// Максималка энергии
  static const maxEnergySlider = 560000.0;
}
