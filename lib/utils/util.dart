import 'package:dio/dio.dart';

Future<bool> checkServerConnection(String url) async {
  try {
    Dio dio = Dio();
    Response response = await dio.head(url);
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
