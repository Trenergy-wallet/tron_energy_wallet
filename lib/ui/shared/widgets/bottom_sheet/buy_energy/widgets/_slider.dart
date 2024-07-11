part of '../buy_energy.dart';

class _Slider extends ConsumerStatefulWidget {
  const _Slider({
    required this.onChange,
    required this.value,
    required this.maxEnergy,
    super.key,
  });

  final void Function(double) onChange;
  final double value;
  final double maxEnergy;

  @override
  ConsumerState<_Slider> createState() => _SliderState();
}

class _SliderState extends ConsumerState<_Slider> {
  double value = Consts.transactionAverageCost.toDouble();
  int division = 9;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  void changeValue(double v) {
    setState(() {
      value = v;
    });
    widget.onChange.call(v);
  }

  @override
  void didUpdateWidget(covariant _Slider oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      value = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 12,
          activeTrackColor: AppColors.buttonsLimeMid,
          inactiveTrackColor: AppColors.buttonsLimeDull,
          thumbColor: AppColors.blackBright,
          thumbShape: _ThumpShape(thumbRadius: 16),
          trackShape: const CustomSliderTrackShape(),
          overlayShape: SliderComponentShape.noThumb,
        ),
        child: Container(
          height: 16,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: AppColors.blackBright),
          ),
          child: Stack(
            children: [
              Slider(
                value: value,
                onChanged: changeValue,
                divisions: 15,
                min: Consts.transactionAverageCost.toDouble(),

                /// 560K - это временное решение, до написание своего слайдера с
                max: Consts.maxEnergySlider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
class _ThumpShape extends SliderComponentShape {
  ///
  _ThumpShape({
    this.thumbRadius = 6.0,
  });

  ///
  final double thumbRadius;

  ///
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required ui.TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final fillPaint = Paint()
      ..color = AppColors.buttonsLimeBright
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = sliderTheme.thumbColor ?? AppColors.buttonsLimeBright
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas
      ..drawCircle(center, thumbRadius, fillPaint)
      ..drawCircle(center, thumbRadius, borderPaint);
  }

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }
}

///
class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  ///
  const CustomSliderTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
