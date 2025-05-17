import 'package:dio/dio.dart';
import 'package:flutter_template/core/mixins/app_log_mixin.dart';
import 'package:flutter_template/core/storage/storage.dart';
import 'package:flutter_template/core/storage/storage_keys.dart';

class DioAuthInterceptor extends Interceptor with AppLogMixin {
  StorageAble? storage;

  DioAuthInterceptor({this.storage});

  @override
  void onRequest(options, handler) {
    addAuthHeader(options);
    handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    cacheAuthHeader(response);
    handleServiceError(response);
    handler.next(response);
  }

  void addAuthHeader(RequestOptions options) {
    if (storage == null) {
      return;
    }
    var token = storage!.get(StorageKeys.token);
    var refreshToken = storage!.get(StorageKeys.refreshToken);
    options.headers['Authorization'] = _handleToken(token);
    options.headers['X-Authorization'] = _handleToken(refreshToken);
  }

  void cacheAuthHeader(Response response) {
    if (storage == null) {
      return;
    }

    var accessToken = response.headers['access-token'];
    if (_validateHeader(accessToken)) {
      storage!.set(StorageKeys.token, accessToken!.first);
    }
    var xAccessToken = response.headers['x-access-token'];
    if (_validateHeader(xAccessToken)) {
      storage!.set(StorageKeys.refreshToken, xAccessToken!.first);
    }

    var data = response.data as Map<String, dynamic>;
    var code = data['code'] as int;
    if (code == 401) {
      storage!.remove(StorageKeys.token);
      storage!.remove(StorageKeys.refreshToken);
    }
  }

  void handleServiceError(Response response) {
    var data = response.data as Map<String, dynamic>;
    var code = data['code'] as int;
    var success = data['success'] as bool;
    if (success) {
      return;
    }
    if (code == 500) {
      log(data['message']);
      throw DioException(
        requestOptions: response.requestOptions,
        type: DioExceptionType.badResponse,
        message: data['message'],
      );
    } else if (code == 400 || code == 1001) {
      log(data['message']);
      throw DioException(
        requestOptions: response.requestOptions,
        type: DioExceptionType.badResponse,
        message: data['message'],
      );
    } else {
      log(data['message']);
    }
  }

  String? _handleToken(String? token) {
    if (token == null || token.isEmpty) {
      return null;
    }
    return ['Bearer', token].join(' ');
  }

  bool _validateHeader(List<String>? header) {
    return header != null &&
        header.isNotEmpty &&
        header.first != 'invalid_token';
  }
}
