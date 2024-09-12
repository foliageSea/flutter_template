import 'package:flutter/material.dart';
import 'package:fs_widgets/fs_widgets/fs_widgets.dart';

class MediaSwiperExamplePage extends StatefulWidget {
  const MediaSwiperExamplePage({super.key});

  @override
  State<MediaSwiperExamplePage> createState() => _MediaSwiperExamplePageState();
}

class _MediaSwiperExamplePageState extends State<MediaSwiperExamplePage> {
  List<String> mediaUrls = <String>[
    'assets/medias/img.png',
    'assets/medias/bee.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return FsMediaPreview(mediaUrls: mediaUrls);
  }
}
