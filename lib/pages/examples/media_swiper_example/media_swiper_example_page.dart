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
  ];

  late String url;

  late ExtendedPageController controller;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    if (images.isEmpty) {
      return;
    }
    url = images.first;
    currentPage = images.indexOf(url);
    controller = ExtendedPageController(
      initialPage: currentPage,
      pageSpacing: 0,
      shouldIgnorePointerWhenScrolling: true,
    );
  }

  void next() {
    if (images.isEmpty) return;
    currentPage = ++currentPage % images.length;
    controller.animateToPage(currentPage,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  void previous() {
    if (images.isEmpty) return;
    currentPage = --currentPage % images.length;
    controller.animateToPage(currentPage,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    var pageCount = images.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('媒体轮播'),
      ),
      body: _renderPageView(images.isEmpty),
      bottomNavigationBar: _buildBottomNavigationBar(pageCount),
    );
  }

  Widget _renderPageView(bool empty) {
    return empty
        ? const Center(
            child: Text('暂无'),
          )
        : ExtendedImageGesturePageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: (int page) {
              currentPage = page;
              setState(() {});
            },
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
          );
  }

  Widget _buildBottomNavigationBar(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            previous();
          },
          icon: const Icon(Icons.navigate_before_sharp),
        ),
        Text(
          '${currentPage + 1}/$pageCount',
        ),
        IconButton(
          onPressed: () {
            next();
          },
          icon: const Icon(Icons.navigate_next_sharp),
        )
      ],
    );
  }
}
