import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/storages/user_storage.dart';
import 'package:flutter_template/utils/common.dart';
import 'package:get/get.dart' as get_package;

typedef DioResponseInterceptorFunc = Function(
  Response response,
  ResponseInterceptorHandler handler,
);

class DioAuthInterceptor extends Interceptor {
  DioAuthInterceptor();

  static final get = get_package.Get;

  static Map<int, DioResponseInterceptorFunc> handlers = {
    401: (response, handler) {
      get.find<UserStorage>().clearToken();
      LOGGER.warning("登录失效，请重新登录");
      showToast("登录失效，请重新登录");
    }
  };

  @override
  void onRequest(options, handler) {
    final token = get.find<UserStorage>().token.val;
    final refreshToken = get.find<UserStorage>().refreshToken.val;
    options.headers.addAll(
      {
        'Authorization': _handleToken(token),
        'X-Authorization': _handleToken(refreshToken),
        'source-client': 'app',
      }..removeWhere((key, value) => value == null),
    );
    handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    late Map<String, dynamic> data;
    if (response.data is String) {
      data = jsonDecode(response.data);
    } else {
      data = response.data;
    }

    var code = data['code'];
    handlers[code]?.call(response, handler);

    _handleCache(response);

    handler.next(response);
  }

  String? _handleToken(String token) {
    if (token.isEmpty) {
      return null;
    }
    return ['Bearer', token].join(' ');
  }

  void _handleCache(Response response) {
    final tokenRW = get.find<UserStorage>().token;
    final refreshTokenRW = get.find<UserStorage>().refreshToken;

    final accessToken = response.headers['access-token'];
    final xAccessToken = response.headers['x-access-token'];

    if (accessToken != null && accessToken.isNotEmpty) {
      tokenRW.val = accessToken.first;
    }
    if (xAccessToken != null && xAccessToken.isNotEmpty) {
      refreshTokenRW.val = xAccessToken.first;
    }
  }
}
