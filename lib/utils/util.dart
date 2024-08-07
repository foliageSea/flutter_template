import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

Future<bool> checkServerConnection(String url) async {
  try {
    final stopwatch = Stopwatch()..start();
    Dio dio = Dio(
      BaseOptions(
        sendTimeout: const Duration(seconds: 1),
        receiveTimeout: const Duration(seconds: 1),
      ),
    );
    Response response = await dio.get(
      url,
    );
    stopwatch.stop();
    print(
        'Function execution time: ${stopwatch.elapsedMilliseconds} milliseconds');
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

Future<ConnectivityResult> checkConnectivity() async {
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
