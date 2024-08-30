import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/fs_widgets/video_player/fs_video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:photo_view/photo_view.dart';

///
/// 媒体预览工具类
///
/// [介绍]
/// 支持预览Url和文件流格式的图片或视频
///
/// [作者] foliage
///
/// [日期] 2024年7月18日
///
/// [依赖]
/// flutter pub add path_provider photo_view path
///
class FsPreviewMediaHelper {
  FsPreviewMediaHelper._();

  static Future previewImage(
    NavigatorState navigator, {
    required FsMediaInput input,
  }) async {
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => _PreviewImageWidget(
          input: input,
        ),
      ),
    );
  }

  static Future previewVideo(
    NavigatorState navigator, {
    required FsMediaInput input,
  }) async {
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => _PreviewVideoWidget(
          input: input,
        ),
      ),
    );
  }

  static Widget createImageWidget(FsMediaInput input) {
    Widget image = Container(
      color: Colors.transparent,
      child: const Icon(Icons.image_not_supported),
    );
    if (input is FsUrlMediaInput) {
      image = Image.network(
        (input).url,
        fit: BoxFit.contain,
        isAntiAlias: true,
        loadingBuilder: _loadingBuilder,
        errorBuilder: _errorBuilder(),
      );
    } else if (input is FsBytesMediaInput) {
      image = Image.memory(
        (input).bytes,
        fit: BoxFit.contain,
        isAntiAlias: true,
        errorBuilder: _errorBuilder(),
      );
    }
    return image;
  }

  static ImageErrorWidgetBuilder? _errorBuilder() {
    return (context, error, stackTrace) {
      return Container(
        color: Colors.transparent,
        child: const Icon(Icons.image_not_supported),
      );
    };
  }

  static Widget _loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }
}

abstract class FsMediaInput {
  const FsMediaInput();
}

class FsUrlMediaInput extends FsMediaInput {
  final String url;
  const FsUrlMediaInput(this.url);
}

class FsBytesMediaInput extends FsMediaInput {
  final Uint8List bytes;
  const FsBytesMediaInput(this.bytes);
}

class _PreviewImageWidget extends StatefulWidget {
  final FsMediaInput input;

  const _PreviewImageWidget({required this.input});

  @override
  State<_PreviewImageWidget> createState() => _PreviewImageWidgetState();
}

class _PreviewImageWidgetState extends State<_PreviewImageWidget> {
  final ctrl = PhotoViewController();
  int doubleTapCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        doubleTapCount++;
        if (doubleTapCount % 2 == 1) {
          ctrl.scale = 1.5;
        } else {
          ctrl.scale = 1.0;
        }
      },
      child: Stack(
        children: [
          Listener(
            onPointerSignal: (event) {
              if (event is PointerScrollEvent) {
                final delta = event.scrollDelta.dy;
                final scale = ctrl.scale ?? 1.0;
                final newScale = scale - delta / 1000;
                ctrl.scale = newScale.clamp(1.0, 10.0);
              }
            },
            child: PhotoView.customChild(
              controller: ctrl,
              initialScale: 1.0,
              minScale: 1.0,
              maxScale: 3.0,
              enablePanAlways: true,
              child: Container(
                color: Colors.transparent,
                child: FsPreviewMediaHelper.createImageWidget(widget.input),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "图片预览",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black45,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewVideoWidget extends StatefulWidget {
  final FsMediaInput input;

  const _PreviewVideoWidget({super.key, required this.input});

  @override
  State<_PreviewVideoWidget> createState() => _PreviewVideoWidgetState();
}

class _PreviewVideoWidgetState extends State<_PreviewVideoWidget> {
  File? tempFile;

  Future<Widget> _loadVideoInput() async {
    var input = widget.input;

    if (input is FsUrlMediaInput) {
      return _buildVideoPlay(FsVideoPlayerUrlSrc(input.url));
    } else if (input is FsBytesMediaInput) {
      var dir = await getTemporaryDirectory();
      var path = p.join(dir.path, 'temp_video');
      tempFile = await File(path).create();
      await tempFile!.writeAsBytes(input.bytes);
      return _buildVideoPlay(FsVideoPlayerFileSrc(path));
    }
    return _buildError();
  }

  Widget _buildVideoPlay(FsVideoPlayerSrc src) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FsVideoPlayer(
        src: src,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tempFile?.delete();
    super.dispose();
  }

  Widget _buildError() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "视频加载失败...",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: _loadVideoInput(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return _buildError();
            }
          },
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black45,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "视频预览",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
