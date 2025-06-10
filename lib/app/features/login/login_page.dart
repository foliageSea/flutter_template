import 'package:flutter_template/app/layouts/base_layout.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(title: 'Login', child: Container());
  }
}
