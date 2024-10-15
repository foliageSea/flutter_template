import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/storages/user_storage.dart';
import 'package:get/get.dart';

class AuthInterceptor extends Interceptor {
  final _token = Get.find<UserStorage>().token;
  final _refreshToken = Get.find<UserStorage>().refreshToken;

  @override
  void onRequest(options, handler) {
    options.headers.addAll(
      {
        'Authorization': _handleToken(_token.val),
        'X-Authorization': _handleToken(_refreshToken.val),
        'source-client': 'app',
      }..removeWhere((key, value) => value == null),
    );

    return handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    late Map<String, dynamic> data;
    if (response.data is String) {
      data = jsonDecode(response.data);
    } else {
      data = response.data;
    }
    // 判断业务代码401
    if (data['code'] == 401) {
      Get.find<UserStorage>().clearToken();
      talker.warning("登录失效，请重新登录");
      handler.next(response);
      return;
    }

    final accessToken = response.headers['access-token'];
    final xAccessToken = response.headers['x-access-token'];
    if (_isNotEmpty(accessToken) && _isNotEmpty(xAccessToken)) {
      _token.val = accessToken!.first;
      _refreshToken.val = xAccessToken!.first;
    }
    handler.next(response);
  }

  @override
  void onError(err, handler) {
    handler.next(err);
  }

  String? _handleToken(String token) {
    if (token.isEmpty) {
      return null;
    }
    return ['Bearer', token].join(' ');
  }

  bool _isNotEmpty(List<String>? list) {
    return list != null && list.isNotEmpty;
  }
}
