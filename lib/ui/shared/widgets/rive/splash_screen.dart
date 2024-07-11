import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// rive файлов splash screen
class RiveSplashScreen extends StatelessWidget {
  /// rive файлов splash screen
  const RiveSplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(
      'assets/images/rive/splash_screen.riv',
      stateMachines: ['State Machine 1'],
      // useArtboardSize: true,
      // fit: BoxFit.cover,
    );
  }
}
