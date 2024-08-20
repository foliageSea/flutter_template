import 'package:flutter/material.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/fs_widgets/fs_video_player.dart';

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
      body: FsVideoPlayer(
        videoUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        onError: (err) {
          talker.error('视频播放出错 $err');
        },
        onPlayOver: () {
          talker.info('视频播放结束');
        },
      ),
    );
  }
}
