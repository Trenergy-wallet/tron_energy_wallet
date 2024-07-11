import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';

/// rive файлов switch
class TestRive extends StatefulWidget {
  /// rive файлов switch
  const TestRive({
    required this.text,
    super.key,
  });

  ///
  final String text;

  @override
  State<TestRive> createState() => _TestRiveState();
}

class _TestRiveState extends State<TestRive> {
  Artboard? _riveArtboard;
  TextValueRun? textRun;
  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/images/button_test.riv').then(
      (data) async {
        final file = RiveFile.import(data);

        final artboard = file.mainArtboard;

        final controller = StateMachineController.fromArtboard(
          artboard,
          'State Machine 1',
        );

        if (controller != null) {
          artboard.addController(controller);
          textRun = artboard.component<TextValueRun>('Run');
          textRun?.text = widget.text;
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  void didUpdateWidget(TestRive oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      textRun?.text = widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_riveArtboard == null) {
      return SizedBox(height: 52, width: screenWidth);
    }
    return SizedBox(
      height: 52,
      child: Rive(
        artboard: _riveArtboard!.instance(),
      ),
    );
  }
}
