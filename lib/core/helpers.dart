import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';

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

    final r = callback.call();
    return r;
  } on Error catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on CheckedFromJsonException catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on Exception catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  }
}

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
  } on Error catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on CheckedFromJsonException catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on Exception catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  }
}

dynamic orThrowForNull(String fieldName) {
  InAppLogger.instance.logInfoMessage('orThrowForNull', '$fieldName is null');
  throw Exception('$fieldName is null');
}

dynamic orThrowFor(String fieldName, {String suffix = 'is wrong'}) {
  InAppLogger.instance.logInfoMessage('orThrowFor', '$fieldName $suffix');
  throw Exception('$fieldName $suffix');
}

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

    return ifNullValue;
  }
  return data;
}

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

Future<Either<ExtendedErrors, R>> safeFunc<R>(
  Future<Either<ExtendedErrors, R>> Function() f,
) async {
  try {
    final r = await f.call();
    return r;
  } on Error catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  } on Exception catch (e) {
    return left(ExtendedErrors.simple(e.toString()));
  }
}

class BackendGuard {
  BackendGuard._();

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
