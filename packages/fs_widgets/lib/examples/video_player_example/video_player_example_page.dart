import 'package:flutter/material.dart';
import 'package:fs_widgets/fs_widgets/fs_widgets.dart';

class VideoPlayerExamplePage extends StatefulWidget {
  const VideoPlayerExamplePage({super.key});

  @override
  State<VideoPlayerExamplePage> createState() => _VideoPlayerExamplePageState();
}

class _VideoPlayerExamplePageState extends State<VideoPlayerExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('视频播放'),
      ),
      body: _build(),
    );
  }

  FsVideoPlayer _build() {
    return FsVideoPlayer(
      src: FsVideoPlayerFileAssetsSrc('assets/medias/bee.mp4'),
      onPlayOver: () {
        debugPrint('视频播放结束');
      },
    );
  }
}
