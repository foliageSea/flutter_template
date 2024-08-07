import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 全局统一的 showToast
Future<void> showToast(String msg) {
  return SmartDialog.showToast(msg);
}

