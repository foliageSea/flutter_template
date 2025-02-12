import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'widgets/setting_select_menu_title.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      description: const Text('description...'),
      children: [
        FTile(
          prefixIcon: FIcon(FAssets.icons.monitorSmartphone),
          title: const Text('软件版本'),
          subtitle: const Text('1.0.0'),
          onPress: () {},
        ),
        const SettingSelectMenuTitle(),
      ],
    );
  }
}
