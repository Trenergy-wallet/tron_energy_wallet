import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/data/dto/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/repo/info_repo_base.dart';

part 'gen/blockchains.cg.f.dart';
part 'gen/blockchains.cg.g.dart';

/// DTO Blockchains
@freezed
class BlockchainsDto with _$BlockchainsDto {
  /// DTO Blockchains
  const factory BlockchainsDto({
    required bool status,
    Map<String, dynamic>? errors,
    List<BlockchainDto>? data,
  }) = _BlockchainsDto;

  const BlockchainsDto._();

  ///
  factory BlockchainsDto.fromJson(Map<String, dynamic> json) =>
      _$BlockchainsDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrListAppBlockchain toDomain() {
    return safeToDomain(
      () => Right(data?.map((e) => e.toDomain()).toList() ?? []),
      status: status,
      errors: errors,
      response: data,
    );
  }
}
