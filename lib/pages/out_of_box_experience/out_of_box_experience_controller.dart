import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/storages/preferences_storage.dart';
import 'package:flutter_template/utils/common.dart';
import 'package:get/get.dart';
import 'package:regexpattern/regexpattern.dart';

class OutOfBoxExperienceController extends GetxController {
  final targetServer = Get.find<PreferencesStorage>().targetServer.val.obs;

  Future handleTargetServer(BuildContext context) async {
    var server = Get.find<PreferencesStorage>().targetServer.val;

    validator(String? value) {
      if (value == null || value.isEmpty) {
        return '请输入服务器地址';
      }
      if (!value.isUri()) {
        return '请输入正确的服务器地址';
      }

      return null;
    }

    final form = await showTextInputDialog(
      context: context,
      title: '请输入服务器地址',
      textFields: [
        DialogTextField(
          initialText: server,
          hintText: '请输入服务器地址',
          validator: validator,
        ),
      ],
    );

    if (form == null) {
      return;
    }

    if (form.first == server) {
      return;
    }

    Get.find<PreferencesStorage>().targetServer.val = form.first;
    targetServer.value = form.first;
    targetServer.refresh();
    showToast('配置成功');
  }
}
