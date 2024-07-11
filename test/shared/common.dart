import 'dart:io';
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:trenergy_wallet/core/utils.dart';

///
String testDelimiter({int length = 80, bool time = true}) =>
    '-'.repeat(length) + (time ? '\n$now' : '\n');

///
extension StringTyper on String {
  /// repeating string [cnt] times
  String repeat([int cnt = 2]) {
    return List.generate(cnt, (i) => this).join();
  }
}

final random = Random();
String tempPath =
    path.join(Directory.current.path, '.dart_tool', 'test', 'tmp');

Future<Directory> getTempDir() async {
  final name = random.nextInt(pow(2, 32) as int);
  final dir = Directory(path.join(tempPath, '${name}_tmp'));
  if (dir.existsSync()) {
    await dir.delete(recursive: true);
  }
  await dir.create(recursive: true);
  return dir;
}

/// Автоматически вставляет строку-описатель в терминал для разделения тестов.
@isTest
void myTest(
  String description,
  dynamic Function() body, {
  String? testOn,
  Timeout? timeout,
  dynamic skip,
  dynamic tags,
  Map<String, dynamic>? onPlatform,
  int? retry,
}) {
  test(
    description,
    () async {
      // та самая строка-описатель перед начало теста в логе
      body();
    },
    testOn: testOn,
    timeout: timeout,
    skip: skip,
    onPlatform: onPlatform,
    tags: tags,
    retry: retry,
  );
}
