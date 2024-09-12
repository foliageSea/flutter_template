import 'package:flutter/material.dart';
import 'package:fs_widgets/examples/adaptive_dialog_example/adaptive_dialog_example_page.dart';
import 'package:fs_widgets/examples/media_swiper_example/media_swiper_example_page.dart';
import 'package:fs_widgets/examples/pluto_grid_example/pluto_grid_example_page.dart';
import 'package:fs_widgets/examples/scaffold_example/scaffold_example.dart';
import 'package:fs_widgets/examples/video_player_example/video_player_example_page.dart';
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
          ),
          ListTile(
            title: const Text('AdaptiveDialogExamplePage'),
            onTap: () {
              Get.to(() => const AdaptiveDialogExamplePage());
            },
          ),
          ListTile(
            title: const Text('MediaSwiperExamplePage'),
            onTap: () {
              Get.to(() => const MediaSwiperExamplePage());
            },
          ),
          ListTile(
            title: const Text('VideoPlayerExamplePage'),
            onTap: () {
              Get.to(() => const VideoPlayerExamplePage());
            },
          ),
        ],
      ),
    );
  }
}
