import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/storages/user_storage.dart';
import 'package:get/get.dart';

class DioAuthInterceptor extends Interceptor {
  DioAuthInterceptor();

  @override
  void onRequest(options, handler) {
    final token = Get.find<UserStorage>().token.val;
    final refreshToken = Get.find<UserStorage>().refreshToken.val;
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
    final tokenRW = Get.find<UserStorage>().token;
    final refreshTokenRW = Get.find<UserStorage>().refreshToken;
    late Map<String, dynamic> data;
    if (response.data.runtimeType == String) {
      data = jsonDecode(response.data);
    } else {
      data = response.data;
    }

    if (data['code'] == 401) {
      Get.find<UserStorage>().clearToken();
      talker.warning("登录失效，请重新登录");
      // onErrorMessage?.call('登录失效，请重新登录');
      handler.next(response);
      return;
    }

    final accessToken = response.headers['access-token'];
    final xAccessToken = response.headers['x-access-token'];
    if (accessToken != null &&
        accessToken.isNotEmpty &&
        xAccessToken != null &&
        xAccessToken.isNotEmpty) {
      tokenRW.val = accessToken.first;
      refreshTokenRW.val = xAccessToken.first;
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
}
