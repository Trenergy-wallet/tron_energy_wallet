import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';

/// Провайдер наличия интернет соединения
/// true - есть соединение
final class InternetController extends StateNotifier<bool> {
  // ignore: public_member_api_docs
  InternetController() : super(false) {
    init();
  }

  // ignore: public_member_api_docs
  static final provider =
      StateNotifierProvider<InternetController, bool>((ref) {
    return InternetController();
  });

  final _logger = InAppLogger.instance;

  final Connectivity _connectivity = Connectivity();

  late final StreamSubscription<List<ConnectivityResult>> _connectivitySub;

  void _setConnectionStatus(List<ConnectivityResult> res) {
    state = res.contains(ConnectivityResult.none);
    _logger.logInfoMessage(
      'InternetController.onConnectivityChange',
      'New connection status : $res',
    );
  }

  Future<void> _initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      _logger.logInfoMessage('initConnectivity', 'Error: $e');
    }
    _setConnectionStatus(result);
  }

  void _onConnectivityChange(List<ConnectivityResult> res) =>
      _setConnectionStatus(res);

  // ignore: public_member_api_docs
  void init() {
    _initConnectivity();

    _connectivitySub =
        _connectivity.onConnectivityChanged.listen(_onConnectivityChange);
  }

  @override
  void dispose() {
    _connectivitySub.cancel();
    super.dispose();
  }
}
