import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';

/// rive файлов coming soon
class RiveComingSoon extends StatelessWidget {
  /// rive файлов coming soon
  const RiveComingSoon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenWidth * 1.11,
      constraints: const BoxConstraints(
        maxHeight: 430 * 1.11,
        maxWidth: 430,
      ),
      child: const RiveAnimation.asset(
        'assets/images/rive/chat_coming_soon.riv',
        stateMachines: ['State Machine 1'],
        // useArtboardSize: true,
        fit: BoxFit.cover,
      ),
    );
  }
}
