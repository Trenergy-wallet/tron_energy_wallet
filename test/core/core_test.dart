import 'package:flutter_test/flutter_test.dart';

import '../shared/common.dart';

const str = '''
{
  "data": {
    "status": true,
    "errors": null,
    "amount": 100.0
  }
}
''';

const map = {
  'status': true,
  'errors': null,
  'amount': 100.0,
};

void main() {
  myTest('Destruct test', () {
    // final json = jsonEncode(str);

    // var json = {
    //   'user': {'status': true, 'errors': null, 'amount': 13}
    // };

    final {'status': s, 'errors': e, 'amount': a} = map;

    expect(s, equals(true));
    expect(e, equals(null));
    expect(a, equals(100.0));
  });
}
