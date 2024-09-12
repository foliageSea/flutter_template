import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

typedef SubmitCallBack = Future Function();

class SubmitHelper {
  static Future<bool> submit(SubmitCallBack cb, [String msg = '加载中...']) async {
    try {
      SmartDialog.showLoading(msg: msg);
      await cb();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      SmartDialog.dismiss();
    }
  }
}
