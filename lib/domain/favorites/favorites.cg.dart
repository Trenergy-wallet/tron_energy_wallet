import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/favorites.cg.f.dart';

///  Favorites
@freezed
class Favorites with _$Favorites {
  ///  Favorites
  const factory Favorites({
    required int id,
    required String name,
    required String address,
  }) = _Favorites;

  /// константный синглтон для семантики "Отсутствие данных"
  static const Favorites empty = Favorites(
    id: 0,
    name: '',
    address: '',
  );
}
