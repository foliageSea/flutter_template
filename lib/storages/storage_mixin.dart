import 'package:flutter/material.dart';
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
        return _buildDialog(context, codeController);
      },
    );
  }

  Widget _buildDialog(BuildContext context, CodeController codeController) {
    var width = MediaQuery.of(context).size.width * 0.8;
    var height = MediaQuery.of(context).size.height * 0.8;

    return AlertDialog(
      title: const Text('查看'),
      content: SizedBox(
        width: width,
        height: height,
        child: CodeTheme(
          data: const CodeThemeData(styles: monokaiSublimeTheme),
          child: CodeField(
            controller: codeController,
            readOnly: true,
            textStyle: const TextStyle(fontFamily: 'Consolas'),
          ),
        ),
      ),
    );
  }

  void clearPrefBox();
}
