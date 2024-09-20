import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/yaml.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

mixin StorageMixin {
  Future preview(BuildContext context) async {
    final source = toString();
    var codeController = CodeController(
      text: source,
      language: yaml,
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('查看'),
          content: SizedBox(
            width: 500,
            height: 400,
            child: CodeTheme(
              data: const CodeThemeData(styles: monokaiSublimeTheme),
              child: CodeField(
                controller: codeController,
                readOnly: true,
                textStyle: const TextStyle(fontFamily: 'Consolas'),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  var result = await showOkCancelAlertDialog(
                      context: context, title: '询问', message: '是否清空?');

                  if (result == OkCancelResult.ok) {
                    clearPrefBox();
                    Get.back();
                  }
                },
                child: const Text('清空'))
          ],
        );
      },
    );
  }

  void clearPrefBox();
}
