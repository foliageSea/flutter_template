import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/logs/log.dart';

typedef SubmitCallBack = Future Function();

class SubmitHelper {
   static Future<bool> submit(SubmitCallBack cb, [String msg = '加载中...']) async {
    try {
      SmartDialog.showLoading(msg: msg);
      await cb();
      return true;
    } catch (e, st) {
      talker.handle(e, st);
      return false;
    } finally {
      SmartDialog.dismiss();
    }
  }
}
