// ignore_for_file: public_member_api_docs

import 'package:flutter/services.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';

/// Обработка нажатий на кнопки с обратной связью (вибрацией) и записью в лог
class AppHaptics {
  static Future<void> lightImpact() {
    InAppLogger.instance.logInfoMessage('AppHaptics', 'lightImpact');
    return HapticFeedback.lightImpact();
  }

  static Future<void> mediumImpact() {
    InAppLogger.instance.logInfoMessage('AppHaptics', 'mediumImpact');
    return HapticFeedback.mediumImpact();
  }

  static Future<void> heavyImpact() {
    InAppLogger.instance.logInfoMessage('AppHaptics', 'heavyImpact');
    return HapticFeedback.heavyImpact();
  }

  static Future<void> selectionClick() {
    InAppLogger.instance.logInfoMessage('AppHaptics', 'selectionClick');

    return HapticFeedback.selectionClick();
  }

  static Future<void> vibrate() {
    InAppLogger.instance.logInfoMessage('AppHaptics', 'vibrate');
    return HapticFeedback.vibrate();
  }
}
