import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';
import 'package:trenergy_wallet/ui/shared/widgets/preloader.dart';

/// Изображение с загрузкой из интернета
/// [pathImg] - должно быть ссылкой на файл в интернет
class ImgNetwork extends StatelessWidget {
  /// Констрктор
  const ImgNetwork({
    required this.pathImg,
    super.key,
    this.borderRadius,
    this.width,
    this.height,
    this.fit,
  });

  /// Путь к файлу в интернет
  final String pathImg;

  /// borderRadius
  final BorderRadiusGeometry? borderRadius;

  /// Ширина
  final double? width;

  /// Высота
  final double? height;

  /// Тип заполнения для изображения
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final errorImage = Preloader(size: width, isCoins: true);

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: (pathImg.isEmpty)
          ? errorImage
          : CachedNetworkImage(
              imageUrl: pathImg,
              width: width,
              height: height,
              fit: fit ?? BoxFit.cover,
              placeholder: (_, __) => errorImage,
              errorWidget: (context, url, error) {
                InAppLogger.instance.logInfoMessage(
                  'ImgNetwork imageErrorBuilder',
                  'unreachable pathImg: $pathImg',
                );
                return errorImage;
              },
            ),
    );
  }
}
