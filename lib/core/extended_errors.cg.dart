import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/extended_errors.cg.f.dart';
part 'gen/extended_errors.cg.g.dart';

/// Класс отображающий сложную структуру ошибок,
/// которые могут придти с бэка.
@Freezed(toStringOverride: false)
class ExtendedErrors with _$ExtendedErrors implements Exception {
  /// Конструктор для ошибок с бэка.
  const factory ExtendedErrors({
    required String error,
    required Map<String, List<dynamic>> errors,
    @Default({}) Map<String, List<dynamic>> onlyUserFieldsErrors,
  }) = _ExtendedErrors;

  const ExtendedErrors._();

  /// Конструктор для простых ошибок с бэка.
  factory ExtendedErrors.simple(String error) => ExtendedErrors(
        error: error,
        errors: {
          'errors': [error],
        },
      );

  /// Конструктор для пустых ошибок с бэка.
  /// Используется для того, чтобы не писать проверки на null.
  factory ExtendedErrors.empty() => const ExtendedErrors(
        error: '',
        errors: {
          'errors': [''],
        },
      );

  /// Десериализация из json.
  factory ExtendedErrors.fromJson(Map<String, dynamic> json) =>
      _$ExtendedErrorsFromJson(json);

  @override
  String toString() {
    if (errors['errors']?.length == 1) {
      return 'Error: $error';
    } else {
      return 'All errors: $errors';
    }
  }
}

/// Расширение для [ExtendedErrors].
extension ExtendedErrorsX on ExtendedErrors {
  /// Запись показывает является ли ошибка ошибкой Dio.
  static const isDioKey = 'is_dio';

  /// Статус ошибки Dio.
  static const dioErrorKey = 'dio_error';

  /// Запись показывает номер статуса ошибки Dio.
  static const dioStatusCodeKey = 'dio_status_code';

  /// Запись показывает api, который вызвал ошибку Dio.
  static const dioApiKey = 'dio_api';

  /// Группа ошибок Dio.
  static const dio = 'dio';

  /// Ключ для основной ошибки.
  static const errorKey = 'error';

  /// Ключ для ошибок.
  static const errorsKey = 'errors';

  /// Ключ для ошибок, которые нужно показывать пользователю.
  static const userErrorsKey = 'only_user_fields';

  /// Флаг наличия ошибок.
  bool get hasErrors => error.isNotEmpty;

  /// Основная ошибка
  String get mainErrorValue {
    return error;
  }

  /// Ошибки из листов [ExtendedErrors.errors]
  List<dynamic> get errorsValue {
    return errors.values.expand((e) => e).toList();
  }

  /// Ошибки из листов [ExtendedErrors.onlyUserFieldsErrors]
  List<dynamic> get onlyUserFieldsErrorsValue {
    return onlyUserFieldsErrors.values.expand((e) => e).toList();
  }

  /// Выборка ошибок по приоритету.
  ///
  List<dynamic> get smartErrorsValue {
    if (onlyUserFieldsErrorsValue.isNotEmpty) {
      return onlyUserFieldsErrorsValue;
    }
    if (errorsValue.isNotEmpty) {
      return errorsValue;
    }
    return [mainErrorValue];
  }

  /// Флаг наличия ошибок Dio.
  bool get isDioError {
    return errors[isDioKey]?.isNotEmpty ?? false;
  }

  /// Ошибка Dio.
  int get dioStatusCode {
    return errors[dioStatusCodeKey]?.first as int? ?? 0;
  }

  /// Ошибка Dio.
  String get dioApi {
    final list = (errors[dioApiKey] as List<String>?) ?? [];
    return list.isNotEmpty ? list.first : '';
  }

  /// Выборка ошибок по приоритету + отладочные сообщения
  List<dynamic> get debugErrorsValue {
    return [...smartErrorsValue, dioApi, dioStatusCode];
  }
}

/// Парсит поле error из ответа
ExtendedErrors parseError(Map<String, dynamic> errorsMap) {
  try {
    final error = errorsMap[ExtendedErrorsX.errorKey] as String? ?? '';

    final errorsDynamic =
        errorsMap[ExtendedErrorsX.errorsKey] as Map<String, dynamic>? ??
            <String, List<dynamic>>{};

    // Если поле only_user_fields отсутствует, то собираю ошибки
    // по полям вручную.
    // Отсеиваю ошибки, которые начинаются с dio и оставшиеся кладу
    // в отдельную мапу onlyUserFields
    final onlyUserFields = errorsMap[ExtendedErrorsX.userErrorsKey];
    var userErrorsDynamic = <String, dynamic>{};
    if (onlyUserFields == null) {
      for (final element in errorsDynamic.entries) {
        if (!element.key.contains(ExtendedErrorsX.dio)) {
          userErrorsDynamic[element.key] = element.value;
        }
      }
    } else {
      if (onlyUserFields is List && onlyUserFields.isEmpty) {
        userErrorsDynamic = <String, List<List<dynamic>>>{};
      } else {
        if (onlyUserFields is Map<String, dynamic>) {
          userErrorsDynamic = onlyUserFields;
        } else {
          userErrorsDynamic = <String, List<List<dynamic>>>{};
        }
      }
    }

    final errorsAsLists =
        errorsDynamic.map((key, value) => MapEntry(key, [value]));

    final userErrorsAsLists =
        userErrorsDynamic.map((key, value) => MapEntry(key, [value]));

    return ExtendedErrors(
      error: error,
      errors: errorsAsLists,
      onlyUserFieldsErrors: userErrorsAsLists,
    );
  } on Exception catch (e) {
    return ExtendedErrors.simple(e.toString());
  }
}
