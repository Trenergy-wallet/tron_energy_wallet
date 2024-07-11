// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';

/// Тут живут ссылки на все иконки и изображения, которые мы загружаем в assets
class AppIcons {
  static const String rootPath = 'assets/images';
  static const String numpadDel = '$rootPath/numpad-del.png';
  static const String shieldExclamation = '$rootPath/shield-exclamation.png';
  static const String copyIcon = '$rootPath/copy.png';
  static const String trashIcon = '$rootPath/trash.png';
  static const String coinAddIcon = '$rootPath/coin-add.png';
  static const String bellIcon = '$rootPath/bell.png';
  static const String addressBook = '$rootPath/address-book.png';
  static const String dollar = '$rootPath/dollar.png';
  static const String lock = '$rootPath/lock.png';
  static const String palette = '$rootPath/palette.png';
  static const String world = '$rootPath/world.png';
  static const String chevronRightIcon = '$rootPath/chevron-right.png';
  static const String qrScanIcon = '$rootPath/qr-scan.png';
  static const String caretDownIcon = '$rootPath/caret-down.png';
  static const String addIcon = '$rootPath/add.png';
  static const String addOutlineIcon = '$rootPath/add-outline.png';
  static const String dotsIcon = '$rootPath/dots.png';
  static const String logoMan = '$rootPath/logo-man.png';
  static const String shareIcon = '$rootPath/share.png';
  static const String connectedIcon = '$rootPath/connected.png';
  static const String userAddIcon = '$rootPath/user-add.png';
  static const String userDeleteIcon = '$rootPath/user-delete.png';
  static const String trenergyBadgeIcon = '$rootPath/trenergy-badge.png';
  static const String refreshIcon = '$rootPath/icon-refresh.png';
  static const String crossSmallIcon = '$rootPath/cross-small.png';
  static const String arrowLeftIcon = '$rootPath/arrow-left.png';
  static const String buyEnergyPic = '$rootPath/buy-energy-pic.png';
  static const String badgeStatus = '$rootPath/badge-status.png';
  static const String progressBarEnd0Icon = '$rootPath/progress-bar-end-0.png';
  static const String progressBarEnd20Icon =
      '$rootPath/progress-bar-end-20.png';
  static const String progressBarEnd50Icon =
      '$rootPath/progress-bar-end-50.png';
  static const String atomBolderIcon = '$rootPath/atom-bolder.png';

  static Widget logo({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return img(
      '$rootPath/logo.png',
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }

  static Widget walletMan({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return img(
      '$rootPath/wallet-man.png',
      width: width ?? 260,
      height: height ?? 285,
      color: color,
      fit: fit,
    );
  }

  static Widget lock1() {
    return icon(
      '$rootPath/lock-1.png',
      width: 80,
      height: 54,
    );
  }

  static Widget lock2() {
    return icon(
      '$rootPath/lock-2.png',
      width: 48,
      height: 67,
    );
  }

  static Widget lockError() {
    return icon(
      '$rootPath/lock-error.png',
      width: 80,
      height: 94,
    );
  }

  static Widget lockGood() {
    return icon(
      '$rootPath/lock-good.png',
      width: 92,
      height: 94,
    );
  }

  static Widget blastError() {
    return img(
      '$rootPath/blast-error.png',
      width: 280,
      height: 160,
      fit: BoxFit.contain,
    );
  }

  static Widget blastGood() {
    return img(
      '$rootPath/blast-good.png',
      width: 280,
      height: 160,
    );
  }

  static Widget pinStar({Color? color}) {
    return icon(
      '$rootPath/pin-star.png',
      width: 25,
      height: 32,
      color: color,
    );
  }

  static Widget pinStarFull({Color? color}) {
    return icon(
      '$rootPath/pin-star-full.png',
      width: 25,
      height: 32,
      color: color,
    );
  }

  static Widget copy({
    double? width,
    double? height,
    Color? color,
  }) {
    return icon(
      copyIcon,
      width: width ?? 12,
      height: height ?? 12,
      color: color,
    );
  }

  static Widget trash({
    double? width,
    double? height,
    Color? color,
  }) {
    return icon(
      trashIcon,
      width: width ?? 16,
      height: height ?? 16,
      color: color,
    );
  }

  static Widget arrowLeft({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return icon(
      arrowLeftIcon,
      width: width ?? 16,
      height: height ?? 16,
      color: color,
      fit: fit,
    );
  }

  static Widget arrowRight({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return icon(
      '$rootPath/arrow-right.png',
      width: width ?? 16,
      height: height ?? 16,
      color: color,
      fit: fit,
    );
  }

  static Widget chevronUp({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return icon(
      '$rootPath/chevron-up.png',
      width: width ?? 16,
      height: height ?? 16,
      color: color,
      fit: fit,
    );
  }

  static Widget chevronRight({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return icon(
      '$rootPath/chevron-right.png',
      width: width ?? 16,
      height: height ?? 16,
      color: color,
      fit: fit,
    );
  }

  static Widget rulesEmoji({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return img(
      '$rootPath/rules-emoji.png',
      width: 152,
      height: 148,
      color: color,
      fit: fit,
    );
  }

  static Widget accountEmoji({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return img(
      '$rootPath/account-emoji.png',
      width: width ?? screenWidth,
      height: height ?? 136,
      color: color,
      fit: fit,
    );
  }

  static Widget bell({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return icon(
      '$rootPath/bell.png',
      width: width ?? 16,
      height: height ?? 16,
      color: color,
      fit: fit,
    );
  }

  static Widget caretDown({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return icon(
      '$rootPath/caret-down.png',
      width: width ?? 16,
      height: height ?? 16,
      color: color,
      fit: fit,
    );
  }

  static Widget coinAdd({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return icon(
      coinAddIcon,
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }

  static Widget dots({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return icon(
      dotsIcon,
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }

  static Widget sendUp({
    double? width,
    double? height,
  }) {
    return img(
      '$rootPath/up.png',
      width: width ?? 40,
      height: height ?? 40,
    );
  }

  static Widget receiveDown({
    double? width,
    double? height,
  }) {
    return icon(
      '$rootPath/down.png',
      width: width ?? 40,
      height: height ?? 40,
    );
  }

  static Widget crossSmall({
    double? width,
    double? height,
  }) {
    return icon(
      crossSmallIcon,
      width: width,
      height: height,
    );
  }

  static Widget add({
    double? width,
    double? height,
  }) {
    return icon(
      '$rootPath/add.png',
      width: width,
      height: height,
    );
  }

  static Widget addOutline({
    double? width,
    double? height,
    Color? color,
  }) {
    return icon(
      '$rootPath/add-outline.png',
      width: width,
      height: height,
      color: color,
    );
  }

  static Widget search({
    double? width,
    double? height,
  }) {
    return icon(
      '$rootPath/search.png',
      width: width,
      height: height,
    );
  }

  static Widget crossCircle({
    double? width,
    double? height,
  }) {
    return icon(
      '$rootPath/cross-circle.png',
      width: width,
      height: height,
    );
  }

  static Widget logoIcon({
    double? width,
    double? height,
  }) {
    return icon(
      '$rootPath/trenergy_logo.png',
      width: width,
      height: height,
    );
  }

  static Widget cloudDownload({
    double? width,
    double? height,
  }) {
    return icon(
      '$rootPath/cloud-download.png',
      width: width,
      height: height,
    );
  }

  static Widget progressBarEnd0({
    double? width,
    double? height,
    Color? color,
  }) {
    return icon(
      progressBarEnd0Icon,
      width: width ?? 12,
      height: height,
      color: color,
    );
  }

  static Widget progressBarEnd20({
    double? width,
    double? height,
    Color? color,
  }) {
    return icon(
      progressBarEnd20Icon,
      width: width ?? 12,
      height: height,
      color: color,
    );
  }

  static Widget progressBarEnd50({
    double? width,
    double? height,
    Color? color,
  }) {
    return icon(
      progressBarEnd50Icon,
      width: width ?? 12,
      height: height,
      color: color,
    );
  }

  static Widget qrScan({
    double? width,
    double? height,
    Color? color,
  }) {
    return icon(
      '$rootPath/qr-scan.png',
      width: width ?? 16,
      height: height ?? 16,
      color: color,
    );
  }

  static Widget atomBolder({
    double? width,
    double? height,
    Color? color,
  }) {
    return icon(
      atomBolderIcon,
      width: width,
      height: height,
      color: color,
    );
  }

  static Widget buyEnergyImg({
    double? width,
    double? height,
  }) {
    return img(
      buyEnergyPic,
      width: width ?? 393,
      height: height ?? 160,
    );
  }

  static Widget blank() {
    return img(
      '$rootPath/blank.png',
      width: 104,
      height: 100,
    );
  }

  static Widget img(
    String path, {
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      color: color,
      fit: fit,
      // Этот фильтр обеспечивает лучшее качество, чем high при downscale
      // и лучшее качество, чем low при upscale
      filterQuality: FilterQuality.medium,
    );
  }

  static Widget icon(
    String path, {
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return Image.asset(
      path,
      width: width ?? Consts.iconSize,
      height: height ?? Consts.iconSize,
      color: color,
      fit: fit,
      // Этот фильтр обеспечивает лучшее качество, чем high при downscale
      // и лучшее качество, чем low при upscale
      filterQuality: FilterQuality.medium,
    );
  }
}
