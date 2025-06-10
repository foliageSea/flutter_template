import 'package:core/core.dart';
import 'package:flutter_template/app/layouts/base_layout.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OobePage extends StatefulWidget {
  const OobePage({super.key});

  @override
  State<OobePage> createState() => _OobePageState();
}

class _OobePageState extends State<OobePage> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Oobe',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              child: const Text('登录'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
