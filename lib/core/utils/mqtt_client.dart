import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:typed_data/typed_data.dart' as typed;

abstract class MqttClientAble {
  void init(MqttClientOption option);

  MqttServerClient createClient(MqttClientOption option);

  MqttConnectMessage createConnectMessage(MqttClientOption option);

  void setWillTopic(String willTopic);

  void setWillPayload(typed.Uint8Buffer willPayload);

  Future<MqttConnectionStatus?> connect();
}

class MqttClient implements MqttClientAble {
  static MqttClient? _mqttClient;

  MqttClient._();

  factory MqttClient() {
    _mqttClient ??= MqttClient._();
    return _mqttClient!;
  }

  late MqttServerClient client;
  late MqttConnectMessage connectMessage;
  late MqttClientOption option;

  @override
  void init(MqttClientOption option) {
    this.option = option;
    client = createClient(option);
    connectMessage = createConnectMessage(option);
    client.connect();
  }

  @override
  MqttServerClient createClient(MqttClientOption option) {
    MqttServerClient client = MqttServerClient.withPort(
      option.server,
      option.clientIdentifier,
      option.port,
      maxConnectionAttempts: option.maxConnectionAttempts,
    );
    client.secure = option.secure;
    client.autoReconnect = option.autoReconnect;
    client.keepAlivePeriod = option.keepAlivePeriod;
    return client;
  }

  @override
  MqttConnectMessage createConnectMessage(MqttClientOption option) {
    MqttConnectMessage connectMessage = MqttConnectMessage()
        .withWillRetain()
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    return connectMessage;
  }

  @override
  void setWillTopic(String willTopic) {
    connectMessage.withWillTopic(willTopic);
  }

  @override
  void setWillPayload(typed.Uint8Buffer willPayload) {
    connectMessage.withWillPayload(willPayload);
  }

  @override
  Future<MqttConnectionStatus?> connect() {
    return client.connect(option.username, option.password);
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

  // String? willTopic;
  // typed.Uint8Buffer? willPayload;

  MqttClientOption({
    required this.server,
    required this.clientIdentifier,
    this.secure = false,
    required this.port,
    this.maxConnectionAttempts = 3,
    this.autoReconnect = true,
    this.keepAlivePeriod = 10,
    // this.willTopic,
    // this.willPayload,
    this.username,
    this.password,
  });
}
