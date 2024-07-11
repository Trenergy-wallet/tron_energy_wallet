import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';

/// Хелпер для упрощения перевода в домен.
///
/// Передавая туда поле [status] от DTO, автоматизируем проверку и выдачу
/// "влево", если [status] false.
///
/// Кроме того, обрабатываются и правильно передаются переданные ошибки,
/// а при помощи пробрасываемого колбека можно передать и правильные данные.
///
/// _Пример:_
///
///  1. В DTO прилетает штатный набор полей, включая `status`, карту `errors`,
///    и данные в поле `response`
///  2. Перед вызовом колбека проверим статус, и если он false, то вернем
///    лево с переданными и обработанными ошибками
///  3. Затем  проверим `response` на NULL, и если он нулевой, то вернем лево
///    с оповещением.
///  4. Если все нормально, то вызываем колбек, и на стороне клиента колбек
///    вернет правый карман так, как ему нужно
///  5. Если в процессе выскочат ошибка или исключение, вернется лево
///
/// ```dart
/// @freezed
/// class TempTokenDto with _$TempTokenDto {
///   /// DTO для типа GET 1.7
///   const factory TempTokenDto({
///     required bool status,
///     Map<String, dynamic>? errors,
///     TempTokenDataDto? data,
///   }) = _TempTokenDto;
///
///   const TempTokenDto._();
///
///   ///
///   factory TempTokenDto.fromJson(Map<String, dynamic> json) =>
///       _$TempTokenDtoFromJson(json);
///
///   /// Защищенное конвертирование в доменный тип.
///   ErrOrTempToken toDomain() {
///     return safeToDomain(
///           () => Right(data?.toDomain() ?? TempToken.empty),
///       status: status,
///       errors: errors,
///       response: data,
///     );
///   }
/// }
//// ```
///
Either<ExtendedErrors, R> safeToDomain<R>(
  Either<ExtendedErrors, R> Function() callback, {
  required bool status,
  required dynamic response,
  Map<String, dynamic>? errors,
}) {
  try {
    if (!status) {
      return Left(parseError(errors ?? <String, dynamic>{}));
    }
    if (response == null) {
      return Left(ExtendedErrors.simple('${R.runtimeType}: response is null'));
    }
    //
    final r = callback.call();
    return r;
  }
  // Здесь нельзя по-другому - бэк может возвращать некорректные параметры,
  // которые не могут быть распарсены в доменную модель.
  // И если не отлавливать - будет RSOD или что-то вроде того.
  // ignore: avoid_catching_errors
  on Error catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on CheckedFromJsonException catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on Exception catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  }
}

/// Хелпер для упрощения перевода в домен Wss данных
Either<ExtendedErrors, R> safeToDomainWss<R>(
  Either<ExtendedErrors, R> Function() callback, {
  required dynamic data,
}) {
  try {
    if (data == null) {
      return Left(ExtendedErrors.simple('${R.runtimeType}: data is null'));
    }
    final r = callback.call();
    return r;
  }
  // Здесь нельзя по-другому - бэк может возвращать некорректные параметры,
  // которые не могут быть распарсены в доменную модель.
  // И если не отлавливать - будет RSOD или что-то вроде того.
  // ignore: avoid_catching_errors
  on Error catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on CheckedFromJsonException catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on Exception catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  }
}

/// Метод для выбрасыванияя исключения в случае, когда дефолтное значение
/// по каким-то причинам не к месту, например,
/// когда нужно понять, что не так с входящим от бека.
dynamic orThrowForNull(String fieldName) {
  InAppLogger.instance.logInfoMessage('orThrowForNull', '$fieldName is null');
  throw Exception('$fieldName is null');
}

/// То же самое, что [orThrowForNull] только кастомизировано.
dynamic orThrowFor(String fieldName, {String suffix = 'is wrong'}) {
  InAppLogger.instance.logInfoMessage('orThrowFor', '$fieldName $suffix');
  throw Exception('$fieldName $suffix');
}

/// При null принт ошибки и выдача [ifNullValue]
/// Если не null, просто возвращаем данные
T ifNullPrintErrAndSet<T>({
  required T? data,
  required String functionName,
  required String variableName,
  required T ifNullValue,
  String? parentSlug,
}) {
  if (data == null) {
    InAppLogger.instance.logInfoMessage(
        functionName,
        '${parentSlug != null ? 'Parent: $parentSlug :' : ''} data is null'
        ' :: $variableName');
    // ПМ сказал не выводить никакую ошибку, тк текст в любом случае будет
    // непонятен пользователю, а неинформативное сообщение выводить смысла нет
    // appAlert(value: msg, color: AppColors.dangerPrimary);
    return ifNullValue;
  }
  return data;
}

/// В случае ошибкии парсинга в колбеке автоматически записывается лог
/// и выводится умолчательное значение.
T ifCatchPrintErrAndSet<T>({
  required T Function() onParse,
  required String functionName,
  required String variableName,
  required T ifCatchValue,
  String? parentSlug,
}) {
  try {
    return onParse.call();
  } on Exception catch (e) {
    InAppLogger.instance.logInfoMessage(
        functionName,
        '${parentSlug != null ? 'Parent: $parentSlug :' : ''} error = $e'
        ' :: $variableName');
    return ifCatchValue;
  }
}

// /// Миксин сделан для удобства вынесения второстепенной логики в репах.
// mixin RepositoryImplMixin {
//   /// Хелпер для упрощения перевода в домен
//   Future<Either<ExtendedErrors, R>> safeFunc<R>(
//     Future<Either<ExtendedErrors, R>> Function() f,
//   ) async {
//     try {
//       final r = await f.call();
//       return r;
//     }
//     // Здесь нельзя по-другому - бэк может возвращать некорректные параметры,
//     // которые не могут быть распарсены в доменную модель.
//     // И если не отлавливать - будет RSOD или что-то вроде того.
//     // ignore: avoid_catching_errors
//     on Error catch (e) {
//       return left(ExtendedErrors.simple(e.toString()));
//     } on Exception catch (e) {
//       return left(ExtendedErrors.simple(e.toString()));
//     }
//   }
// }

/// Хелпер для упрощения перевода в домен
Future<Either<ExtendedErrors, R>> safeFunc<R>(
  Future<Either<ExtendedErrors, R>> Function() f,
) async {
  try {
    final r = await f.call();
    return r;
  }
  // Здесь нельзя по-другому - бэк может возвращать некорректные параметры,
  // которые не могут быть распарсены в доменную модель.
  // И если не отлавливать - будет RSOD или что-то вроде того.
  // ignore: avoid_catching_errors
  on Error catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on Exception catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  }
}

/// Набор функций для работы с хаотическим бэкендом (как правило PHP-way).
///
/// Не секрет, что заменить инты на строки, строки на булы
/// им запросто, а нам тут все ломает на входе.
///
/// Методы предназначены для возможного учета возможных вариантов,
/// которые мы пытаемся привести уже к порядочным типам.
class BackendGuard {
  BackendGuard._();

  /// <b>Попытка преобразовать в bool все возможные фокусы PHP</b></p>.
  ///
  /// Ребята там играются, меняя инты на строки, строки на булы,
  /// предполагая что весь мир прогнется под них</p>.
  ///
  /// <b>Пытаемся позвать санитаров:</b>
  ///
  /// - Если на входе null - возвращаем null
  /// - Если получилось bool - возвращаем его
  /// - Если получилось int - возвращаем значение аргумента отнсительно нуля
  /// - Если получилось double - возвращаем значение аргумента отнсительно нуля
  /// - Если получилось String - соответствие с "true" или "1"
  /// - Если ничего не получилось - возвращаем null и пишем в лог.
  ///
  /// [context] - контекст для логов - функция, класс, название переменной.
  static bool? tryParseBool(
    dynamic value, {
    String context = ' ... ',
    bool showWarning = false,
  }) {
    if (value == null) {
      return null;
    }

    if (value is bool) {
      return value;
    }

    if (showWarning) {
      InAppLogger.instance.logWarning(
        '‼️BackendChaos.tryParseBool for $context',
        'value `$value` not bool, but ${value.runtimeType}, try to parse it',
      );
    }

    if (value is int) {
      return value > 0;
    }

    if (value is double) {
      return value > 0;
    }

    if (value is String) {
      if (value == 'true' || value == '1') {
        return true;
      } else {
        return false;
      }
    }

    InAppLogger.instance.logError(
      '‼️BackendChaos.tryParseBool for $context',
      'value was $value, but it was not bool, int, double or string',
    );

    return null;
  }

  /// <b>Попытка преобразовать в int все возможные фокусы PHP</b></p>.
  ///
  /// Ребята там играются, меняя инты на строки, строки на булы,
  /// предполагая что весь мир прогнется под них</p>.
  ///
  /// <b>Пытаемся позвать санитаров:</b>
  ///
  /// - Если на входе null - возвращаем null
  /// - Если получилось int - возвращаем его
  /// - Если получилось double - возвращаем double.toInt()
  /// - Если получилось String - int.tryParse()
  /// - Если ничего не получилось - возвращаем null и пишем в лог.
  ///
  /// [context] - контекст для логов - функция, класс, название переменной.
  static int? tryParseInt(
    dynamic value, {
    String context = ' ... ',
    bool showWarning = false,
  }) {
    if (value == null) {
      return null;
    }

    if (value is int) {
      return value;
    }

    if (showWarning) {
      InAppLogger.instance.logWarning(
        '‼️BackendChaos.tryParseInt for $context',
        'value `$value` not int, but ${value.runtimeType}, try to parse it',
      );
    }

    if (value is double) {
      return value.toInt();
    }

    if (value is String) {
      return int.tryParse(value);
    }

    InAppLogger.instance.logError(
      '‼️BackendChaos.tryParseInt for $context',
      'value was $value, but it was not int, double or string',
    );

    return null;
  }

  /// <b>Попытка преобразовать в double все возможные фокусы PHP</b></p>.
  ///
  /// Ребята там играются, меняя инты на строки, строки на булы,
  /// предполагая что весь мир прогнется под них</p>.
  ///
  /// <b>Пытаемся позвать санитаров:</b>
  ///
  /// - Если на входе null - возвращаем null
  /// - Если получилось double - возвращаем его
  /// - Если получилось int - возвращаем int.toDouble()
  /// - Если получилось String - double.tryParse()
  /// - Если ничего не получилось - возвращаем null и пишем в лог.
  ///
  /// [context] - контекст для логов - функция, класс, название переменной.
  static double? tryParseDouble(
    dynamic value, {
    String context = ' ... ',
    bool showWarning = false,
  }) {
    if (value == null) {
      return null;
    }

    if (value is double) {
      return value;
    }

    if (showWarning) {
      InAppLogger.instance.logWarning(
        '‼️BackendChaos.tryParseDouble for $context',
        'value `$value` not double, but ${value.runtimeType}, try to parse it',
      );
    }

    if (value is int) {
      return value.toDouble();
    }

    if (value is String) {
      if (value.contains(',')) {
        value.replaceAll(',', '.');
      }

      return double.tryParse(value);
    }

    InAppLogger.instance.logError(
      '‼️BackendChaos.tryParseDouble for $context',
      'value was $value, but it was not  double, int or string',
    );

    return null;
  }

  /// Назрела необходимость парсить мапы.
  /// Бэк с завидным постоянством возвращает нам вместо пустого объекта
  /// пустой массив.
  ///
  /// Это не вылечится пока бэкендеры не научатся в гарды, то есть никогда.
  ///
  /// [showWarning] по умолчанию true, так как это серьезный косяк,
  ///   и ошибка должна отображаться.
  static Map<K, V>? tryParseMap<K, V>(
    dynamic value, {
    String context = ' ... ',
    bool showWarning = true,
  }) {
    if (value == null) {
      return null;
    }

    if (value is Map<K, V>) {
      return value;
    }

    if (showWarning) {
      InAppLogger.instance.logWarning(
        '‼️ BackendChaos.tryParseMap for $context',
        'value `$value` not Map, but ${value.runtimeType}, try to parse it',
      );
    }

    if (value is List<dynamic> && value.isEmpty) {
      return {};
    }

    if (value is String) {
      return {};
    }

    InAppLogger.instance.logError(
      '‼️BackendChaos.tryParseMap for $context',
      'value was $value, but it was not empty List or string',
    );

    return null;
  }
}
