import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_template/extensions/list_widget_extension.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/router/router.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text('登录'),
      ),
      children: [
        InfoLabel(
          label: '账号',
          child: const TextBox(
            placeholder: '请输入账号',
          ),
        ),
        InfoLabel(
          label: '密码',
          child: const PasswordBox(
            placeholder: '请输入密码',
          ),
        ),
        SizedBox(
          height: 40,
          child: FilledButton(
            onPressed: () {
              Global.setToken('Test');
              context.go(Routes.home);
            },
            child: const Text('登录'),
          ),
        )
      ].insertSizedBoxBetween(height: 8),
    );
  }
}
