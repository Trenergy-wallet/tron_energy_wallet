import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/send_model.cg.f.dart';

/// Модель для отправки средств
@freezed
class SendModel with _$SendModel {
  /// Модель настроек BottomSheet
  const factory SendModel({
    /// адрес куда отправить
    required String addressRecipient,

    /// количество на отправку
    required String amount,
  }) = _SendModel;

  /// константный синглтон для семантики "Отсутствие данных"
  static const SendModel empty = SendModel(
    addressRecipient: '',
    amount: '',
  );
}
