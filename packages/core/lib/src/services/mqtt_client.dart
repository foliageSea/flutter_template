import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:typed_data/typed_data.dart' as typed;

abstract class MqttClientAble {
  void init(MqttClientOption option);

  void setWillTopic(String willTopic);

  void setWillPayload(typed.Uint8Buffer willPayload);

  Future<MqttConnectionStatus?> connect();

  void disconnect();

  MqttSubscription? subscribe(String topic, MqttQos qosLevel);

  bool getConnectionStatus();
}

class MqttClient implements MqttClientAble {
  static MqttClient? _mqttClient;

  MqttClient._();

  factory MqttClient() {
    _mqttClient ??= MqttClient._();
    return _mqttClient!;
  }

  late MqttServerClient _client;
  late MqttConnectMessage _connectMessage;
  late MqttClientOption _option;

  @override
  void init(MqttClientOption option) {
    _option = option;
    _client = _createClient(option);
    _connectMessage = _createConnectMessage(option);
    _client.connectionMessage = _connectMessage;
  }

  MqttServerClient _createClient(MqttClientOption option) {
    MqttServerClient client = MqttServerClient.withPort(
      option.server,
      option.clientIdentifier,
      option.port,
      maxConnectionAttempts: option.maxConnectionAttempts,
    );
    client.secure = option.secure;
    client.autoReconnect = option.autoReconnect;
    client.keepAlivePeriod = option.keepAlivePeriod;
    client.onConnected = option.onConnected;
    client.onDisconnected = option.onDisconnected;
    return client;
  }

  MqttConnectMessage _createConnectMessage(MqttClientOption option) {
    MqttConnectMessage connectMessage = MqttConnectMessage()
        .withWillRetain()
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    return connectMessage;
  }

  @override
  void setWillTopic(String willTopic) {
    _connectMessage.withWillTopic(willTopic);
  }

  @override
  void setWillPayload(typed.Uint8Buffer willPayload) {
    _connectMessage.withWillPayload(willPayload);
  }

  @override
  Future<MqttConnectionStatus?> connect() {
    return _client.connect(_option.username, _option.password);
  }

  @override
  void disconnect() {
    _client.disconnect();
  }

  @override
  MqttSubscription? subscribe(String topic, MqttQos qosLevel) {
    return _client.subscribe(topic, qosLevel);
  }

  void listen() {
    _client.updates.listen(
      (List<MqttReceivedMessage<MqttMessage>> list) {
        if (list.isEmpty) {
          return;
        }
        String? topic = list.first.topic;
        MqttPublishMessage item = list.first.payload as MqttPublishMessage;
        typed.Uint8Buffer? message = item.payload.message;
        String? pt;
        if (message != null) {
          pt = MqttUtilities.bytesToStringAsString(message);
        }
        _option.onMessage?.call(topic, pt);
      },
    );
  }

  @override
  bool getConnectionStatus() {
    return _client.connectionStatus?.state == MqttConnectionState.connected;
  }
}

class MqttClientOption {
  String server;
  String clientIdentifier;
  bool secure;
  int port;
  int maxConnectionAttempts;
  bool autoReconnect;
  int keepAlivePeriod;
  String? username;
  String? password;
  void Function()? onConnected;
  void Function()? onDisconnected;
  void Function(String? topic, String? pt)? onMessage;

  String? mqttServerUrl;

  MqttClientOption({
    required this.server,
    required this.clientIdentifier,
    this.secure = false,
    required this.port,
    this.maxConnectionAttempts = 3,
    this.autoReconnect = true,
    this.keepAlivePeriod = 10,
    this.username,
    this.password,
    this.onConnected,
    this.onDisconnected,
    this.onMessage,
  });

  static MqttClientOption fromMqttServerUrl(
    String mqttServerUrl,
    String clientIdentifier,
  ) {
    var url = Uri.parse(mqttServerUrl);
    var server = url.host;
    var port = url.port;
    var scheme = url.scheme;
    return MqttClientOption(
      server: server,
      clientIdentifier: clientIdentifier,
      port: port,
      secure: scheme == 'mqtts',
    );
  }
}
