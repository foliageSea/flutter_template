import 'package:dio/dio.dart';
import 'package:flutter_template/interceptors/dio_auth_interceptor.dart';
import 'package:flutter_template/interceptors/dio_error_interceptor.dart';
import 'package:get/get.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioService extends GetxService {
  static DioService get to => Get.find();

  final Dio _dio = Dio();

  Dio get dio => _dio;

  // 连接超时时间
  static const Duration connectTimeout = Duration(seconds: 10);

  // 响应超时时间 5 min
  static const Duration receiveTimeout = Duration(seconds: 30);

  Future<DioService> init() async {
    _dio.options
      ..connectTimeout = connectTimeout
      ..receiveTimeout = receiveTimeout;

    _dio.interceptors.add(DioErrorInterceptor());
    _dio.interceptors.add(DioAuthInterceptor());

    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );

    return this;
  }
}
