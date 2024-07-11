import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';

/// rive файл tron energy
class RiveTronEnergy extends StatefulWidget {
  /// rive файл tron energy
  const RiveTronEnergy({
    required this.progress,
    super.key,
  });

  /// Включен ли checkbox
  final double progress;

  @override
  State<RiveTronEnergy> createState() => _RiveCheckboxState();
}

class _RiveCheckboxState extends State<RiveTronEnergy> {
  StateMachineController? controller;
  Artboard? _riveArtboard;

  RiveEvent? riveEvent;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/images/rive/energy_level_pipe.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        // final sparks = file.artboards[3];
        final artboard = file.mainArtboard;

        controller =
            StateMachineController.fromArtboard(artboard, 'State Machine 1');

        if (controller != null) {
          artboard.addController(controller!);
          controller?.findInput<double>('Level')?.value = widget.progress;
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  void didUpdateWidget(covariant RiveTronEnergy oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.progress != widget.progress) {
      controller?.findInput<double>('Level')?.value = widget.progress;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

//84 высота меню
  @override
  Widget build(BuildContext context) {
    if (_riveArtboard == null) {
      return SizedBox(height: 84, width: screenWidth);
    }

    return Rive(
      artboard: _riveArtboard!,
      useArtboardSize: true,
    );
  }
}
