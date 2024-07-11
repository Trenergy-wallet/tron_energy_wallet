import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/ext.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';
import 'package:trenergy_wallet/logic/providers/locale_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/shared/app_alert.dart';

part 'gen/dio_provider.cg.g.dart';

final InAppLogger _inAppLogger = InAppLogger.instance;

// Добавил, чтобы мы выводили headers только при их изменении, иначе они
// просто заполняют лог ненужной информацией
var _headers = '';

/// init this provider in main
@Riverpod(keepAlive: true)
Dio dio(DioRef ref, String baseUrl) {
  final isTrEnergyProject = baseUrl == AppConfig.apiTrEnergy;
  final options = BaseOptions(
    baseUrl: baseUrl,
    // Нельзя имхо без таймаутов
    connectTimeout: const Duration(milliseconds: 10000),
    receiveTimeout: const Duration(milliseconds: 10000),
    sendTimeout: const Duration(milliseconds: 10000),
  );
  final dioInit = Dio(options);
  dioInit.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        await _setHeaders(
          options,
          ref,
          isTrEnergyProject: isTrEnergyProject,
        );

        var logLine = '${options.method} ${options.uri}';
        if (options.data != null) {
          logLine += '\ndata:${options.data}';
        }
        if (options.extra.isNotEmpty) {
          logLine += ' \nextra:${options.extra}';
        }
        _inAppLogger.logInfoMessage('HTTP REQUEST', logLine);

        // Что это и зачем не понял, на всякий случай добавил в лог
        if (!AppConfig.isProduction &&
            options.data != null &&
            options.data is Map) {
          final bodyAsString = jsonEncode(options.data);
          if (bodyAsString.length > 2) {
            _inAppLogger.logInfoMessage('HTTP REQUEST BODY', bodyAsString);
          }
        }

        return handler.next(options);
      },
      onResponse: (response, handler) async {
        final respString = response.toString();
        _inAppLogger.logInfoMessage(
          'HTTP RESPONSE',
          respString.substring(
            0,
            respString.length > 500 ? 500 : respString.length - 1,
          ),
        );
        return handler.next(response);
      },
      onError: (e, handler) => _onError(e, handler, ref),
    ),
  );
  _inAppLogger.logInfoMessage('Dio', 'Init ✅ base url: $baseUrl');
  return dioInit;
}

Future<dynamic> _onError(
  DioException e,
  ErrorInterceptorHandler handler,
  Ref ref,
) async {
  // Закоменчу пока - слишком много ошибки дублируются в логе

  return _resolveErrorForClient(e.response?.statusCode ?? -1, e, handler, ref);
}

/// Помощь для передачи разного рода ошибок клиенту
/// Передается код и ендпойнт
Future<dynamic> _resolveErrorForClient(
  int statusCode,
  DioException e,
  ErrorInterceptorHandler handler,
  Ref ref,
) async {
  final partOf = [
    DioExceptionType.connectionTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.sendTimeout,
  ].contains(e.type)
      ? 'Timeout. Please try again'.hardcoded
      : e.toString().maxLen(200);

  var errors = <String, dynamic>{};
  // если каст непроходит, вся обработка прекращается, что приводит к
  // ошибке бесконечной загрузки
  try {
    errors = e.response?.data as Map<String, dynamic>;
  } catch (_) {}

  if (!errors.containsKey(ExtendedErrorsX.errorKey)) {
    errors[ExtendedErrorsX.errorKey] = partOf;
  }
  if (!errors.containsKey(ExtendedErrorsX.errorsKey)) {
    errors[ExtendedErrorsX.errorsKey] = <String, dynamic>{
      ExtendedErrorsX.errorKey: [errors[ExtendedErrorsX.errorKey]],
    };
  }
  if (errors[ExtendedErrorsX.errorsKey] is Map<String, dynamic>) {
    // Тут добавим полезную инфу
    (errors[ExtendedErrorsX.errorsKey]
        as Map<String, dynamic>)[ExtendedErrorsX.dioStatusCodeKey] = statusCode;
    (errors[ExtendedErrorsX.errorsKey]
            as Map<String, dynamic>)[ExtendedErrorsX.dioApiKey] =
        e.requestOptions.path;
    //~ Тут добавим полезную инфу
  }
  if ([401, 402].contains(statusCode)) {
    _inAppLogger.logInfoMessage(
      'DioBuilder',
      '‼️ _resolveErrorForClient: errors.LOGOUT=$statusCode',
    );
    unawaited(appAlert(value: 'Token expired. Logout'.hardcoded));
    addPostFrameCallback(() {
      final localRepo = ref.read(repoProvider).local;
      final sk = localRepo.getSecretKey();
      final account = localRepo.getAccount(sk: sk);
      localRepo.deleteAccountList(account);
    });
  } else {
    _inAppLogger.logInfoMessage(
      'DioBuilder',
      '‼️ _resolveErrorForClient: errors $errors',
    );
  }

  final respNew = Response(
    requestOptions:
        e.response?.requestOptions ?? RequestOptions(path: 'unknown path'),
    data: <String, dynamic>{
      'status': false,
      'errors': errors,
    },
  );
  return handler.resolve(respNew);
}

Future<void> _setHeaders(
  RequestOptions options,
  Ref ref, {
  bool isTrEnergyProject = false,
}) async {
  final localRepo = ref.read(repoProvider).local;
  final sk = localRepo.getSecretKey();
  final localAccount = localRepo.getAccount(sk: sk);

  if (localAccount.token.isNotEmpty) {
    final localAccount = localRepo.getAccount(sk: sk);
    final accountApi =
        ref.read(accountServiceProvider).valueOrNull ?? Account.empty;

    final trenergyToken = accountApi.trenergyToken;

    final t = isTrEnergyProject ? trenergyToken : localAccount.token;

    options.headers['Authorization'] = 'Bearer $t';
  }

  if (options.responseType != ResponseType.bytes) {
    options.headers['Accept'] = 'application/json';
  }

  if (!(options.headers.toString() == _headers)) {
    _inAppLogger.logInfoMessage(
      'DioBuilder',
      '❕ INFO ❕ _setHeaders: ${options.headers}',
    );
    options.headers['Service-Lang'] = ref.read(localeControllerProvider);
    _headers = options.headers.toString();
  }
}
