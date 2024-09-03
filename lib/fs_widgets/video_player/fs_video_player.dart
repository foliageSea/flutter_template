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
  final VideoPlayerController controller;

  const _ControlsOverlay({required this.controller, this.onClick});

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
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: IconButton(
            onPressed: () {
              if (controller.value.position.inSeconds > 5) {
                controller.seekTo(
                    Duration(seconds: controller.value.position.inSeconds - 5));
              } else {
                controller.seekTo(const Duration(seconds: 0));
              }
            },
            icon: const Icon(
              Icons.replay_5,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: IconButton(
            onPressed: () {
              controller.seekTo(
                  Duration(seconds: controller.value.position.inSeconds + 5));
            },
            icon: const Icon(
              Icons.forward_5,
              color: Colors.white,
            ),
          ),
        ),
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
