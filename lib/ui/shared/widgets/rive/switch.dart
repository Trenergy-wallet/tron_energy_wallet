import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

/// rive файлов switch
class RiveSwitch extends StatefulWidget {
  /// rive файлов switch
  const RiveSwitch({
    required this.onTap,
    this.disabled = false,
    this.isOn = false,
    this.isNeedAutoTap = true,
    super.key,
  });

  /// Включен ли checkbox
  final bool isOn;

  /// Заблокирован ли checkbox
  final bool disabled;

  /// Заблокирован ли checkbox
  final bool isNeedAutoTap;

  /// Нажатие
  final void Function(bool) onTap;

  @override
  State<RiveSwitch> createState() => _RiveSwitchState();
}

class _RiveSwitchState extends State<RiveSwitch> {
  Artboard? _riveArtboard;
  SMIInput<bool>? _isOn;
  SMIInput<bool>? _disabled;
  SMITrigger? _tap;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/images/rive/switch.riv').then(
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
  void didUpdateWidget(RiveSwitch oldWidget) {
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
      height: 24,
      width: 40,
      child: GestureDetector(
        onTap: () {
          if (_disabled!.value) {
            _tap?.fire();
          } else {
            if (widget.isNeedAutoTap) {
              _tap?.fire();
            }
            _isOn?.value = !_isOn!.value;
          }
          widget.onTap.call(_isOn!.value);
        },
        child: Rive(
          artboard: _riveArtboard!,
        ),
      ),
    );
  }
}
