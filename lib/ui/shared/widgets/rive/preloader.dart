import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// rive файлов preloader
class RivePreloader extends StatelessWidget {
  /// rive файлов preloader
  const RivePreloader({
    this.isCoins = false,
    super.key,
  });

  ///
  final bool isCoins;

  @override
  Widget build(BuildContext context) {
    const artboard1 = 'Coins';
    const artboard2 = 'Stars';
    return RiveAnimation.asset(
      'assets/images/rive/preloader.riv',
      stateMachines: const ['State Machine 1'],
      artboard: isCoins ? artboard1 : artboard2,
      fit: BoxFit.cover,
    );
  }
}
