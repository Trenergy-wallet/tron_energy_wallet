import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/wallet/models/confirm_seed_model.cg.dart';

part 'gen/mnemonic_phrase_model.cg.f.dart';

/// Модель для подтверждения мнемонической фразы
@freezed
class MnemonicPhraseModel with _$MnemonicPhraseModel {
  /// Модель для подтверждения мнемонической фразы
  const factory MnemonicPhraseModel({
    required String mnemonic,
    required List<ConfirmSeedModel> confirmList,
    @Default(false) bool isLoading,
  }) = _MnemonicPhraseModel;

  /// константный синглтон для семантики "Отсутствие данных"
  static const MnemonicPhraseModel empty = MnemonicPhraseModel(
    mnemonic: '',
    confirmList: [],
  );
}
