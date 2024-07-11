import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

/// rive файлов chat
class RiveChat extends StatefulWidget {
  /// rive файлов chat
  const RiveChat({
    required this.isActive,
    super.key,
  });

  /// Включен ли checkbox
  final bool isActive;

  @override
  State<RiveChat> createState() => _RiveChatState();
}

class _RiveChatState extends State<RiveChat> {
  Artboard? _riveArtboard;
  SMIInput<bool>? _isOn;
  SMITrigger? _tap;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/images/rive/chat_v2.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;

        final controller = StateMachineController.fromArtboard(
          artboard,
          'State Machine',
        );

        if (controller != null) {
          artboard.addController(controller);
          _isOn = controller.findInput('is_on');
          _tap = controller.findInput<bool>('tap') as SMITrigger?;

          _tap?.fire();
          _isOn?.value = widget.isActive;
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  void didUpdateWidget(RiveChat oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      _tap?.fire();
      _isOn?.value = widget.isActive;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_riveArtboard == null) {
      return const SizedBox(height: 48, width: 100);
    }
    return Rive(
      artboard: _riveArtboard!,
      useArtboardSize: true,
    );
  }
}
