import 'package:flutter/material.dart';
import 'package:flutter_template/fs_widgets/video_player/fs_video_player_controller.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:get/get.dart';

class FsVideoPlayerControlsOverlay extends StatefulWidget {
  final String videoUrl;
  final Widget playerSurface;

  const FsVideoPlayerControlsOverlay({
    super.key,
    required this.videoUrl,
    required this.playerSurface,
  });

  @override
  State<FsVideoPlayerControlsOverlay> createState() =>
      _FsVideoPlayerControlsOverlayState();
}

class _FsVideoPlayerControlsOverlayState
    extends State<FsVideoPlayerControlsOverlay> with WidgetsBindingObserver {
  late FsVideoPlayerController controller;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    controller = Get.put(FsVideoPlayerController(
      videoUrl: widget.videoUrl,
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    controller.playerTimer?.cancel();

    super.dispose();
  }

  Widget get loadingWidget {
    return controller.loading.value
        ? const Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container();
  }

  Widget get gestureWidget {
    return GestureDetector(
      onTap: () async {
        controller.handleTap();
        try {
          controller.volume.value = await FlutterVolumeController.getVolume() ??
              controller.volume.value;
          controller.volume.refresh();
        } catch (_) {}
      },
      onDoubleTap: () async {
        if (!controller.showControls.value) {
          controller.handleTap();
        }

        if (controller.playing.value) {
          controller.pause();
        } else {
          controller.play();
        }
      },
      onLongPress: () {
        controller.showPlaySpeed.value = true;
        controller.showPlaySpeed.refresh();

        controller.setPlaybackSpeed(controller.playerSpeed.value * 2.5);
      },
      onLongPressEnd: (_) {
        controller.showPlaySpeed.value = false;
        controller.showPlaySpeed.refresh();
        controller.setPlaybackSpeed(controller.playerSpeed.value / 2.5);
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: ClipRect(
            child: Container(
              color: Colors.black,
              child: SizedBox(
                height: controller.fullScreen.value
                    ? (MediaQuery.of(context).size.height)
                    : (MediaQuery.of(context).size.width * 9.0 / (16.0)),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: widget.playerSurface,
                    ),
                    loadingWidget,
                    gestureWidget,
                    Positioned.fill(
                      left: 16,
                      top: 25,
                      right: 15,
                      bottom: 15,
                      child: GetPlatform.isDesktop
                          ? Container()
                          : GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                controller.onHorizontalDragUpdate(
                                  context,
                                  details,
                                );
                              },
                              onHorizontalDragEnd: (details) {
                                controller.onHorizontalDragEnd(details);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
