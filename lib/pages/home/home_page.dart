import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Center(
        child: ObxValue(
          (data) => Switch(
            value: data.value,
            onChanged:
                data, // Rx 有一个 _callable_函数! 你可以使用 (flag) => data.value = flag,
          ),
          false.obs,
        ),
      ),
    );
  }
}
