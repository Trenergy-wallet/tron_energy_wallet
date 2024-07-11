import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/token.cg.f.dart';

/// 1.2 Post Token Message
@freezed
class Token with _$Token {
  /// 1.2 Post Token Message
  const factory Token({
    required String token,
  }) = _Token;

  /// константный синглтон для семантики "Отсутствие данных"
  static const Token empty = Token(
    token: '',
  );
}
