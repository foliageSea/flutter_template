import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fs_widgets/examples/scaffold_example/scaffold_example.dart';
import 'package:icons_plus/icons_plus.dart';

class AdaptiveDialogExamplePage extends StatefulWidget {
  const AdaptiveDialogExamplePage({super.key});

  @override
  State<AdaptiveDialogExamplePage> createState() =>
      _AdaptiveDialogExamplePageState();
}

class _AdaptiveDialogExamplePageState extends State<AdaptiveDialogExamplePage> {
  String? checkVal(String? value) {
    if (value == null || value.isEmpty) {
      return '不能为空';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldExample(
      title: 'AdaptiveDialogExamplePage',
      body: _build(),
    );
  }

  _build() {
    return Center(
      child: FilledButton.icon(
        onPressed: () async {
          var res = await showTextInputDialog(
            context: context,
            title: '登录',
            textFields: [
              DialogTextField(
                hintText: '请输入QQ号',
                validator: checkVal,
                keyboardType: TextInputType.number,
              ),
              DialogTextField(
                hintText: '请输入密码',
                validator: checkVal,
                obscureText: true,
              ),
            ],
          );
          print(res);
        },
        icon: const Icon(
          AntDesign.qq_circle_fill,
          size: 14,
        ),
        label: const Text('QQ'),
      ),
    );
  }
}
