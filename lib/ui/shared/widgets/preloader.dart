import 'package:flutter/material.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/refresh.dart';

/// Стандартный виджет процесса загрузки
class Preloader extends StatelessWidget {
  /// Стандартный виджет процесса загрузки
  const Preloader({
    this.size,
    this.color,
    this.isCoins = false,
    super.key,
  });

  /// Размер
  final double? size;

  /// Цвет
  final Color? color;

  /// Прелоадер монет
  final bool isCoins;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 100,
        height: size ?? 100,
        child: const RiveRefresh(),
        // child: RivePreloader(isCoins: isCoins),
      ),
    );
  }
}
