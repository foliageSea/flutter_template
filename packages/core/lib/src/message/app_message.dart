import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

abstract class AppMessageAble {
  Future<void> showToast(String message);
  Future<void> show({String? message});
  Future<void> dismiss();
  Future<void> showError(String message);
  TransitionBuilder init({
    TransitionBuilder? builder,
  });
}

class AppMessage implements AppMessageAble {
  static AppMessage? _appMessage;

  AppMessage._();

  factory AppMessage() {
    _appMessage ??= AppMessage._();
    return _appMessage!;
  }

  @override
  Future<void> showToast(String message) {
    return EasyLoading.showToast(message);
  }

  @override
  Future<void> show({String? message}) {
    return EasyLoading.show(status: message);
  }

  @override
  Future<void> dismiss() {
    return EasyLoading.dismiss();
  }

  @override
  Future<void> showError(String message) {
    return EasyLoading.showError(message);
  }

  @override
  TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return EasyLoading.init(builder: builder);
  }
}
