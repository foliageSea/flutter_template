import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/hero.dart';

class MediaSwiperExamplePage extends StatefulWidget {
  const MediaSwiperExamplePage({super.key});

  @override
  State<MediaSwiperExamplePage> createState() => _MediaSwiperExamplePageState();
}

class _MediaSwiperExamplePageState extends State<MediaSwiperExamplePage> {
  List<String> images = <String>[
    'https://photo.tuchong.com/14649482/f/601672690.jpg',
    'https://photo.tuchong.com/14649482/f/601672690.jpg',
    // 'https://photo.tuchong.com/17325605/f/641585173.jpg',
    // 'https://photo.tuchong.com/3541468/f/256561232.jpg',
    // 'https://photo.tuchong.com/16709139/f/278778447.jpg',
    // 'This is an video',
    // 'https://photo.tuchong.com/5040418/f/43305517.jpg',
    // 'https://photo.tuchong.com/3019649/f/302699092.jpg'
  ];

  String url = 'https://photo.tuchong.com/14649482/f/601672690.jpg';

  late ExtendedPageController controller;

  int initialPage = 0;

  @override
  void initState() {
    super.initState();
    initialPage = images.indexOf(url);
    controller = ExtendedPageController(
      initialPage: initialPage,
      pageSpacing: 0,
      shouldIgnorePointerWhenScrolling: true,
    );
  }

  void next() {
    initialPage = ++initialPage % images.length;
    controller.animateToPage(initialPage,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  void previous() {
    initialPage = --initialPage % images.length;
    controller.animateToPage(initialPage,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('媒体轮播'),
      ),
      body: ExtendedImageGesturePageView.builder(
        controller: controller,
        itemCount: images.length,
        onPageChanged: (int page) {},
        itemBuilder: (BuildContext context, int index) {
          final String url = images[index];
          return ExtendedImage.network(
            url,
            enableSlideOutPage: false,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (ExtendedImageState state) {
              return GestureConfig(
                //you must set inPageView true if you want to use ExtendedImageGesturePageView
                inPageView: true,
                initialScale: 1.0,
                maxScale: 5.0,
                animationMaxScale: 6.0,
                initialAlignment: InitialAlignment.center,
              );
            },
          );
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              previous();
            },
            icon: const Icon(Icons.navigate_before_sharp),
          ),
          IconButton(
            onPressed: () {
              next();
            },
            icon: const Icon(Icons.navigate_next_sharp),
          )
        ],
      ),
    );
  }
}
