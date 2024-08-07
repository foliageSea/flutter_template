import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

typedef CheckServerStatusCallBack = void Function(String msg);

class NetworkHelper {
  /// 检查服务器状态
  static Future<bool> checkServerStatus(
    String url, [
    CheckServerStatusCallBack? cb,
  ]) async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      // 处理网络连接异常
      cb?.call('网络连接异常');
      return false;
    } on TimeoutException catch (_) {
      // 处理超时异常
      cb?.call('请求超时');
      return false;
    } catch (e) {
      // 处理其他未知异常
      cb?.call('检测服务器状态时发生错误: $e');
      return false;
    }
  }

  static Future<ConnectivityResult> checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return ConnectivityResult.mobile;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return ConnectivityResult.wifi;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return ConnectivityResult.ethernet;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return ConnectivityResult.other;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      return ConnectivityResult.none;
    }
    return ConnectivityResult.none;
  }
}
