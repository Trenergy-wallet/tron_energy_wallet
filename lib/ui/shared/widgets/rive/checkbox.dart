import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

/// rive файлов checkbox
class RiveCheckbox extends StatefulWidget {
  /// rive файлов checkbox
  const RiveCheckbox({
    required this.onTap,
    this.disabled = false,
    this.isOn = false,
    super.key,
  });

  /// Ширина.
  static const width = 24.0;

  /// Высота.
  static const height = 24.0;

  /// Включен ли checkbox
  final bool isOn;

  /// Заблокирован ли checkbox
  final bool disabled;

  /// Нажатие
  final void Function(bool) onTap;

  @override
  State<RiveCheckbox> createState() => _RiveCheckboxState();
}

class _RiveCheckboxState extends State<RiveCheckbox> {
  Artboard? _riveArtboard;
  SMIInput<bool>? _isOn;
  SMIInput<bool>? _disabled;
  SMITrigger? _tap;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/images/rive/checkbox.riv').then(
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
          _disabled = controller.findInput('disabled');
          _tap = controller.findInput<bool>('tap') as SMITrigger?;

          _isOn?.value = widget.isOn;
          _disabled?.value = widget.disabled;
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  void didUpdateWidget(RiveCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOn != oldWidget.isOn) {
      _tap?.fire();
    }
    _isOn?.value = widget.isOn;
    _disabled?.value = widget.disabled;
  }

  @override
  Widget build(BuildContext context) {
    if (_riveArtboard == null) {
      return const SizedBox(height: 24, width: 24);
    }
    return SizedBox(
      height: RiveCheckbox.width,
      width: RiveCheckbox.height,
      child: GestureDetector(
        onTap: () {
          if (_disabled!.value) {
            _tap?.fire();
          } else {
            _tap?.fire();
            _isOn?.value = !_isOn!.value;
          }
          widget.onTap.call(_isOn!.value);
        },
        child: Rive(
          artboard: _riveArtboard!,
          useArtboardSize: true,
        ),
      ),
    );
  }
}
