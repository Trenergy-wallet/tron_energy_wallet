import 'package:flutter_test/flutter_test.dart';
import 'package:trenergy_wallet/core/utils.dart';

import '../shared/common.dart';

void main() {
  myTest('numbWithoutZero test', () {

    const d = 12.196;
    final r = numbWithoutZero(d, precision: 2);
    expect(r, equals('12.2'));

    <double, String>{
      0: '0',
      35: '35',
      -45: '-45',
      100.0: '100',
      0.19: '0.19',
      18.8: '18.8',
      0.20: '0.2',
      123.32432400: '123.324324',
      -23.400: '-23.4',
    }.forEach((key, value) {
      final initialValue = key;
      final expectedValue = value;
      final actualValue = numbWithoutZero(initialValue);
      expect(actualValue, expectedValue);
    });
  });
}
