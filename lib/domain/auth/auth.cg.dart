import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/auth.cg.f.dart';

/// 1.1 Get Auth Message
@freezed
class Auth with _$Auth {
  /// 1.1 Get Auth Message
  const factory Auth({
    required String message,
  }) = _Auth;

  /// константный синглтон для семантики "Отсутствие данных"
  static const Auth empty = Auth(
    message: '',
  );
}
