import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fs_widgets/examples/scaffold_example/scaffold_example.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class FormBuilderExample extends StatefulWidget {
  const FormBuilderExample({super.key});

  @override
  State<FormBuilderExample> createState() => _FormBuilderExampleState();
}

class _FormBuilderExampleState extends State<FormBuilderExample> {
  final _formKey = GlobalKey<FormBuilderState>();

  Widget _buidlFormBuilderTest() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'email',
            decoration: InputDecoration(labelText: '邮箱'.tr),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'password',
            decoration: InputDecoration(labelText: '密码'.tr),
            obscureText: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('语言'.tr),
              FilledButton(
                onPressed: () {
                  Get.updateLocale(const Locale('zh', 'CN'));
                },
                child: const Text('中文'),
              ),
              FilledButton(
                onPressed: () {
                  Get.updateLocale(const Locale('en', 'US'));
                },
                child: const Text('英文'),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                _formKey.currentState?.saveAndValidate();
                debugPrint(_formKey.currentState?.value.toString());

                // _formKey.currentState?.validate();
                // debugPrint(_formKey.currentState?.instantValue.toString());
              },
              child: const Text('登录'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldExample(
      title: 'FormBuilderExample',
      body: _buidlFormBuilderTest(),
    );
  }
}
