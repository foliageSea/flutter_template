import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef FsVideoPlayerOnError = void Function(String? error);

class FsVideoPlayer extends StatefulWidget {
  const FsVideoPlayer({
    super.key,
    required this.src,
    this.onPlayOver,
    this.onError,
    this.onClick,
  });

  final FsVideoPlayerSrc src;
  final Function()? onPlayOver;
  final FsVideoPlayerOnError? onError;
  final Function? onClick;

  @override
  State<FsVideoPlayer> createState() => _FsVideoPlayerState();
}

class _FsVideoPlayerState extends State<FsVideoPlayer> {
  late VideoPlayerController _controller;

  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    if (widget.src is FsVideoPlayerFileSrc) {
      _controller = VideoPlayerController.file(
          File((widget.src as FsVideoPlayerFileSrc).path));
    } else {
      _controller = VideoPlayerController.networkUrl(
          Uri.parse((widget.src as FsVideoPlayerUrlSrc).url));
    }

    _controller.addListener(_handleListener);

    _controller.setLooping(false);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
  }

  void _handleListener() {
    /// 播放结束
    final duration = _controller.value.duration;
    final position = _controller.value.position;
    if (duration != const Duration(seconds: 0)) {
      if (position == duration) {
        _controller.seekTo(const Duration(seconds: 0));
        widget.onPlayOver?.call();
      }
    }

    /// 播放错误
    final hasError = _controller.value.hasError;
    final errorDescription = _controller.value.errorDescription;
    if (hasError) {
      widget.onError?.call(errorDescription);
    }

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_handleListener);
    _controller.dispose();
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(AsyncSnapshot<void> snapshot) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        SizedBox(
          height: 8,
        ),
        Text('视频播放器加载出错了'),
      ],
    ));
  }

  Widget _buildVideo() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        VideoPlayer(_controller),
        _ControlsOverlay(
          controller: _controller,
          onClick: widget.onClick,
        ),
        VideoProgressIndicator(_controller, allowScrubbing: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        late Widget child;
        if (snapshot.connectionState == ConnectionState.waiting) {
          child = _buildLoading();
        } else if (snapshot.hasError) {
          child = _buildError(snapshot);
        } else {
          child = _buildVideo();
        }
        return Center(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: child,
          ),
        );
      },
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final Function? onClick;

  const _ControlsOverlay({required this.controller, this.onClick});

  // static const List<Duration> _exampleCaptionOffsets = <Duration>[
  //   Duration(seconds: -10),
  //   Duration(seconds: -3),
  //   Duration(seconds: -1, milliseconds: -500),
  //   Duration(milliseconds: -250),
  //   Duration.zero,
  //   Duration(milliseconds: 250),
  //   Duration(seconds: 1, milliseconds: 500),
  //   Duration(seconds: 3),
  //   Duration(seconds: 10),
  // ];
  // static const List<double> _examplePlaybackRates = <double>[
  //   0.25,
  //   0.5,
  //   1.0,
  //   1.5,
  //   2.0,
  //   3.0,
  //   5.0,
  //   10.0,
  // ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onDoubleTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
          onTap: () {
            onClick?.call();
          },
        ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: PopupMenuButton<Duration>(
        //     initialValue: controller.value.captionOffset,
        //     tooltip: 'Caption Offset',
        //     onSelected: (Duration delay) {
        //       controller.setCaptionOffset(delay);
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return <PopupMenuItem<Duration>>[
        //         for (final Duration offsetDuration in _exampleCaptionOffsets)
        //           PopupMenuItem<Duration>(
        //             value: offsetDuration,
        //             child: Text('${offsetDuration.inMilliseconds}ms'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
        //     ),
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: PopupMenuButton<double>(
        //     initialValue: controller.value.playbackSpeed,
        //     tooltip: 'Playback speed',
        //     onSelected: (double speed) {
        //       controller.setPlaybackSpeed(speed);
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return <PopupMenuItem<double>>[
        //         for (final double speed in _examplePlaybackRates)
        //           PopupMenuItem<double>(
        //             value: speed,
        //             child: Text('${speed}x'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.playbackSpeed}x'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

abstract class FsVideoPlayerSrc {
  FsVideoPlayerSrc();
}

class FsVideoPlayerUrlSrc implements FsVideoPlayerSrc {
  final String url;
  FsVideoPlayerUrlSrc(this.url);
}

class FsVideoPlayerFileSrc implements FsVideoPlayerSrc {
  final String path;
  FsVideoPlayerFileSrc(this.path);
}
