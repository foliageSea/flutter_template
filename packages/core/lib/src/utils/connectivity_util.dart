import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  static ConnectivityUtil? _connectivityUtil;

  ConnectivityUtil._();

  factory ConnectivityUtil() {
    _connectivityUtil ??= ConnectivityUtil._();
    return _connectivityUtil!;
  }

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void listen(ConnectivityUtilCallback? cb) {
    _subscription = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> connectivityResult) {
        if (connectivityResult.contains(ConnectivityResult.none)) {
          cb?.call(false);
          return;
        }
        cb?.call(true);
      },
    );
  }

  void cancel() {
    _subscription?.cancel();
  }
}

typedef ConnectivityUtilCallback = void Function(bool isConnected);
