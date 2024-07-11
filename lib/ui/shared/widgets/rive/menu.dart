import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';

/// rive файл menu
class RiveMenu extends StatefulWidget {
  /// rive файл menu
  const RiveMenu({
    required this.number,
    required this.onTap,
    super.key,
  });

  /// Включен ли checkbox
  final double number;

  /// Нажатие
  final void Function(int) onTap;

  @override
  State<RiveMenu> createState() => _RiveCheckboxState();
}

class _RiveCheckboxState extends State<RiveMenu> {
  StateMachineController? controller;
  Artboard? _riveArtboardWallet;
  Artboard? _riveArtboardSettings;

  RiveEvent? riveEvent;

// settings.riv
// wallet.riv
  @override
  void initState() {
    super.initState();
    // rootBundle.load('assets/images/rive/tab_bar.riv').then(
    rootBundle.load('assets/images/rive/wallet.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;

        controller =
            StateMachineController.fromArtboard(artboard, 'State Machine');

        if (controller != null) {
          artboard.addController(controller!);
          controller?.findInput<double>('number')?.value = 0;
          controller!.addEventListener(_events);
        }
        setState(() => _riveArtboardWallet = artboard);
      },
    );
    rootBundle.load('assets/images/rive/settings.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;

        controller =
            StateMachineController.fromArtboard(artboard, 'State Machine');

        if (controller != null) {
          artboard.addController(controller!);
          controller?.findInput<double>('number')?.value = 0;
          controller!.addEventListener(_events);
        }
        setState(() => _riveArtboardSettings = artboard);
      },
    );
  }

  void _events(RiveEvent riveEvent) {
    final numb = riveEvent.properties['number']! as double;

    if (widget.number != numb) {
      addPostFrameCallback(() {
        widget.onTap.call(numb.toInt());
      });
    }
  }

  @override
  void didUpdateWidget(covariant RiveMenu oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.number != widget.number) {
      controller?.findInput<double>('number')?.value = widget.number;
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
    if (_riveArtboardSettings == null && _riveArtboardWallet == null) {
      return SizedBox(height: 84, width: screenWidth);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 100,
          height: 48,
          child: Rive(
            artboard: _riveArtboardWallet!,
            enablePointerEvents: true,
            antialiasing: false,
          ),
        ),
        SizedBox(
          width: 100,
          height: 48,
          child: Rive(
            artboard: _riveArtboardSettings!,
            enablePointerEvents: true,
            antialiasing: false,
          ),
        ),
      ],
    );
  }
}
