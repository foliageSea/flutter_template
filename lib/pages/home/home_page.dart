import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/states/theme.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          _buildThemeButton(),
        ],
      ),
    );
  }

  IconButton _buildThemeButton() {
    var theme = ref.watch(themeProvider);
    var iconData =
        theme == ThemeMode.light ? Icons.light_mode : Icons.dark_mode;
    return IconButton(
      onPressed: () {
        ref.read(themeProvider.notifier).toggle();
      },
      icon: Icon(iconData),
    );
  }
}
