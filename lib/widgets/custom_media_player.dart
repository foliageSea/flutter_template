import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/helpers/file_helper.dart';
import 'package:flutter_template/widgets/custom_video_player.dart';
import 'package:get/get.dart';

class CustomMediaPlayer extends StatefulWidget {
  const CustomMediaPlayer({
    super.key,
    this.appTitle = '媒体轮播',
    this.interval = 5,
    required this.mediaUrls,
  });

  final String? appTitle;
  final List<String> mediaUrls;
  final int? interval;

  @override
  State<CustomMediaPlayer> createState() => _CustomMediaPlayerState();
}

class _CustomMediaPlayerState extends State<CustomMediaPlayer> {
  List<String> mediaUrls = <String>[];

  late String url;

  late ExtendedPageController controller;

  RxInt currentPage = 0.obs;

  RxBool autoPlay = false.obs;

  Timer? timer;

  RxInt count = 5.obs;

  Rx<FileHelperFileType> fileType = FileHelperFileType.image.obs;

  RxBool fullScreen = false.obs;

  void updateParams() {
    count.value = widget.interval!;
    mediaUrls = widget.mediaUrls;
  }

  @override
  void initState() {
    super.initState();
    updateParams();
    if (mediaUrls.isEmpty) {
      return;
    }
    url = mediaUrls.first;

    currentPage.value = mediaUrls.indexOf(url);
    controller = ExtendedPageController(
      initialPage: currentPage.value,
      pageSpacing: 0,
      shouldIgnorePointerWhenScrolling: true,
    );

    ever(autoPlay, (value) {
      if (value) {
        if (fileType.value == FileHelperFileType.video) {
          next();
        }
        timer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            countDown(() => next());
          },
        );
      } else {
        timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void countDown(Function? cb) {
    if (fileType.value == FileHelperFileType.video) {
      return;
    }
    if (count.value > 0) {
      count.value--;
      count.refresh();
    } else {
      cb?.call();
      count.value = 5;
      count.refresh();
    }
  }

  void resetCount() {
    count.value = widget.interval!;
    count.refresh();
  }

  void next() {
    if (mediaUrls.isEmpty) return;
    resetCount();
    currentPage.value = ++currentPage.value % mediaUrls.length;
    controller.animateToPage(currentPage.value,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
    currentPage.refresh();
  }

  void previous() {
    if (mediaUrls.isEmpty) return;
    resetCount();
    currentPage.value = --currentPage.value % mediaUrls.length;
    controller.animateToPage(currentPage.value,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
    currentPage.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var pageCount = mediaUrls.length;

    return Obx(
      () => Scaffold(
        appBar: fullScreen.value
            ? null
            : AppBar(
                title: Text(widget.appTitle!),
              ),
        body: GestureDetector(
            onTap: () {
              fullScreen.value = !fullScreen.value;
              fullScreen.refresh();
            },
            child: _renderPageView(mediaUrls.isEmpty)),
        bottomNavigationBar:
            fullScreen.value ? null : _buildBottomNavigationBar(pageCount),
      ),
    );
  }

  Widget _renderPageView(bool empty) {
    return empty
        ? const Center(
            child: Text('暂无'),
          )
        : ExtendedImageGesturePageView.builder(
            controller: controller,
            itemCount: mediaUrls.length,
            onPageChanged: (int page) {
              currentPage.value = page;
              currentPage.refresh();
            },
            itemBuilder: _buildPageViewItem,
          );
  }

  Widget _buildPageViewItem(BuildContext context, int index) {
    final String url = mediaUrls[index];
    var ext = FileHelper.parseUrlFileType(url);
    fileType.value = ext;

    if (ext == FileHelperFileType.image) {
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
    }

    if (ext == FileHelperFileType.video) {
      return CustomVideoPlayer(
        videoUrl: url,
        onClick: () {
          fullScreen.value = !fullScreen.value;
          fullScreen.refresh();
        },
        onPlayOver: () {
          if (autoPlay.value) {
            next();
          }
        },
        onError: (err) {
          if (autoPlay.value) {
            next();
          }
        },
      );
    }

    return const Center(
      child: Text('未知文件类型'),
    );
  }

  Widget _buildBottomNavigationBar(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(
          () => Text(
            '${currentPage.value + 1}/$pageCount (${count.value}s)',
          ),
        ),
        IconButton(
          onPressed: () {
            previous();
          },
          icon: const Icon(Icons.navigate_before_sharp),
        ),
        Obx(
          () => IconButton(
            onPressed: () {
              autoPlay.value = !autoPlay.value;
            },
            icon: autoPlay.value
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
          ),
        ),
        IconButton(
          onPressed: () {
            next();
          },
          icon: const Icon(Icons.navigate_next_sharp),
        ),
      ],
    );
  }
}