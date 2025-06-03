import 'package:core/core.dart';

mixin AppMessageMixin {
  Future<void> showToast(String message) => AppMessage().showToast(message);
  Future<void> show({String? message}) => AppMessage().show(message: message);
  Future<void> dismiss() => AppMessage().dismiss();
  Future<void> showError(String message) => AppMessage().showError(message);
}
