import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'pages/setting/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final headers = [
    const FHeader(title: Text('Home')),
    const FHeader(title: Text('Setting')),
  ];

  get contents {
    return [
      _buildHomePage(),
      const SettingPage(),
    ];
  }

  Column _buildHomePage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Home Placeholder'),
      ],
    );
  }

  int index = 0;

  var list = [
    FBottomNavigationBarItem(
      icon: FIcon(FAssets.icons.house),
      label: const Text('Home'),
    ),
    FBottomNavigationBarItem(
      icon: FIcon(FAssets.icons.settings),
      label: const Text('Setting'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: headers[index],
      content: contents[index],
      footer: FBottomNavigationBar(
        index: index,
        onChange: (index) => setState(() => this.index = index),
        children: list,
      ),
    );
  }
}
