import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// rive файлов refresh
class RiveRefresh extends StatelessWidget {
  /// rive файлов refresh
  const RiveRefresh({super.key});

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(
      'assets/images/rive/refresh.riv',
      stateMachines: ['State Machine 1'],
      artboard: 'loader',
      useArtboardSize: true,
    );
  }
}
