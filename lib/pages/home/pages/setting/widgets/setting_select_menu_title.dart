import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

enum Theme { system, light, dark }

class SettingSelectMenuTitle extends StatefulWidget with FTileMixin {
  const SettingSelectMenuTitle({super.key});

  @override
  State<SettingSelectMenuTitle> createState() => _SettingSelectMenuTitleState();
}

class _SettingSelectMenuTitleState extends State<SettingSelectMenuTitle> {
  final controller = FRadioSelectGroupController(value: Theme.system);

  void handleChange() {
    var theme = controller.values.firstOrNull;

    print(theme);
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(handleChange);
  }

  @override
  void dispose() {
    super.dispose();

    controller.removeListener(handleChange);
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FSelectMenuTile(
      groupController: controller,
      autoHide: true,
      validator: (value) => value == null ? '请选择主题模式' : null,
      prefixIcon: FIcon(FAssets.icons.bell),
      title: const Text('主题'),
      details: ListenableBuilder(
        listenable: controller,
        builder: (context, _) => Text(
          switch (controller.values.firstOrNull) {
            Theme.system => '根据系统',
            Theme.light => '亮色',
            Theme.dark => '暗色',
            null => '未知',
          },
        ),
      ),
      menu: [
        FSelectTile(title: const Text('根据系统'), value: Theme.system),
        FSelectTile(title: const Text('亮色'), value: Theme.light),
        FSelectTile(title: const Text('暗色'), value: Theme.dark),
      ],
    );
  }
}
