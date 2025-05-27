import 'dart:convert';

import 'package:core/core.dart';
import 'package:signalr_netcore/iretry_policy.dart';
import 'package:signalr_netcore/json_hub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';

abstract class SignalrClientAble {
  void init(SignalrClientOption option);

  Future<void>? start();

  Future<void> stop();

  bool getConnectionState();

  Future<Object?> invoke(String methodName, {List<Object>? args});

  void on(String methodName, MethodInvocationFunc newMethod);
}

class SignalrClient with AppLogMixin implements SignalrClientAble {
  static SignalrClient? _signalrClient;

  SignalrClient._();

  factory SignalrClient() {
    _signalrClient ??= SignalrClient._();
    return _signalrClient!;
  }

  late HttpConnectionOptions _httpConnectionOptions;
  late String _url;
  late HubConnection _hubConnection;

  @override
  void init(SignalrClientOption option) {
    _httpConnectionOptions = HttpConnectionOptions(
      accessTokenFactory: () async {
        return option.token;
      },
      skipNegotiation: option.skipNegotiation,
      transport: HttpTransportType.WebSockets,
      requestTimeout: option.requestTimeout,
    );
    _url = "${option.url}?${option.key}=${jsonEncode(option.data)}";
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          _url,
          options: _httpConnectionOptions,
        )
        .withHubProtocol(JsonHubProtocol())
        .withAutomaticReconnect(reconnectPolicy: AlwaysRetryPolicy())
        .build();

    _hubConnection.onclose(({Exception? error}) async {
      option.onClose?.call(error: error);
    });
  }

  @override
  Future<void>? start() {
    return _hubConnection.start();
  }

  @override
  Future<void> stop() {
    return _hubConnection.stop();
  }

  @override
  bool getConnectionState() {
    return _hubConnection.state == HubConnectionState.Connected;
  }

  @override
  Future<Object?> invoke(String methodName, {List<Object>? args}) {
    return _hubConnection.invoke(methodName, args: args);
  }

  @override
  void on(String methodName, MethodInvocationFunc newMethod) {
    _hubConnection.on(methodName, newMethod);
  }
}

class SignalrClientOption {
  String url;
  String key;
  String token;
  Map<String, dynamic> data = {};
  int requestTimeout;
  bool skipNegotiation;
  Function({Exception? error})? onClose;

  SignalrClientOption({
    required this.url,
    required this.key,
    required this.token,
    required this.data,
    this.requestTimeout = 2000,
    this.skipNegotiation = true,
    this.onClose,
  });
}

class AlwaysRetryPolicy implements IRetryPolicy {
  @override
  int? nextRetryDelayInMilliseconds(RetryContext retryContext) {
    return 10 * 1000;
  }
}
