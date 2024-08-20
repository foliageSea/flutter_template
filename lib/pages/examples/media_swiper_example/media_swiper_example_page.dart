import 'package:flutter/material.dart';
import 'package:flutter_template/fs_widgets/fs_media_preview.dart';

class MediaSwiperExamplePage extends StatefulWidget {
  const MediaSwiperExamplePage({super.key});

  @override
  State<MediaSwiperExamplePage> createState() => _MediaSwiperExamplePageState();
}

class _MediaSwiperExamplePageState extends State<MediaSwiperExamplePage> {
  List<String> mediaUrls = <String>[
    'https://foliagesea.github.io/blog/assets/image-20240221223245869-J1aPcQmq.png',
    'https://foliagesea.github.io/blog/assets/image-20240221223245869-J1aPcQmq.png',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return FSMediaPreview(mediaUrls: mediaUrls);
  }
}
