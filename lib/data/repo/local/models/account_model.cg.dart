import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/account_model.cg.f.dart';
part 'gen/account_model.cg.g.dart';

/// AccountModel
@Freezed(fromJson: true, toJson: true)
class AccountModel with _$AccountModel {
  /// AccountModel
  const factory AccountModel({
    required String name,
    required String description,
    required String iconPath,
    required String iconColorBg,
    required String address,
    required String privateKey,
    required String publicKey,
    required String token,
    required String mnemonic,
    @Default(false) bool useFavorite,
  }) = _AccountModel;

  const AccountModel._();

  /// AccountModel fromJson
  factory AccountModel.fromJson(Map<String, dynamic> json) =
      _$AccountModelImpl.fromJson;

  /// Цвет фона иконка
  Color get iconColorBG => Color(int.parse(iconColorBg, radix: 16));

  /// константный синглтон для семантики "Отсутствие данных"
  static const AccountModel empty = AccountModel(
    name: '',
    description: '',
    iconPath: '',
    address: '',
    privateKey: '',
    publicKey: '',
    token: '',
    mnemonic: '',
    iconColorBg: '0xFF000000',
  );
}
