import 'package:flutter/material.dart';
import 'package:flutter_template/fs_widgets/video_player/fs_video_player_controls_overlay.dart';
import 'package:flutter_template/fs_widgets/video_player/fs_video_player_src.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/fs_widgets/video_player/fs_video_player.dart';
import 'package:video_player/video_player.dart';

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
        talker.info('视频播放结束');
      },
    );
  }
}
