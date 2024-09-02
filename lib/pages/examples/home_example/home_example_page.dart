import 'package:flutter/material.dart';
import 'package:flutter_template/pages/examples/pluto_grid_example/pluto_grid_example_page.dart';
import 'package:flutter_template/pages/examples/scaffold_example/scaffold_example.dart';
import 'package:get/get.dart';

class HomeExamplePage extends StatefulWidget {
  const HomeExamplePage({super.key});

  @override
  State<HomeExamplePage> createState() => _HomeExamplePageState();
}

class _HomeExamplePageState extends State<HomeExamplePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldExample(
      title: '示例',
      body: ListView(
        children: [
          ListTile(
            title: const Text('PlutoGridExamplePage'),
            onTap: () {
              Get.to(() => const PlutoGridExamplePage());
            },
          )
        ],
      ),
    );
  }
}
