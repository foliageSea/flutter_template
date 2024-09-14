import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:fs_widgets/helpers/preview_media_helper.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

typedef FsMultipartFile = dio.MultipartFile;

class FsMultipleMediaUploadController extends GetxController {
  RxBool previewMode = false.obs;
  RxList<FsMultipleMediaUploadItem> uploadItems =
      <FsMultipleMediaUploadItem>[].obs;
  final ImagePicker picker = ImagePicker();

  void _updatePreviewMode(bool val) {
    previewMode.value = val;
    previewMode.refresh();
  }

  void setUploadItems(List<FsMultipleMediaUploadItem> items) {
    uploadItems.value = [...items];
    uploadItems.refresh();
  }

  void clearMultipleMediaUploadItems() {
    uploadItems.clear();
    uploadItems.refresh();
  }

  void _onClickUploadFile(
      {required int maxCount, required double maxSize}) async {
    if (uploadItems.length >= maxCount) {
      debugPrint('文件数量已达到最大值');
      return;
    }

    final XFile? mediaFile = await picker.pickMedia();
    if (mediaFile == null) return;

    var fileType = _getFileTypeFromUrl(mediaFile.path);
    var fileSize = await mediaFile.length() / 1024 / 1024; // MB

    var fileName = p.basename(mediaFile.path);

    if (fileSize > maxSize) {
      debugPrint('文件大小不能超过${maxSize}MB');
      return;
    }

    if (fileType == FsMultipleMediaUploadFileType.other) {
      debugPrint('文件类型不支持');
      return;
    }

    var bytes = await mediaFile.readAsBytes();
    var base64 = base64Encode(bytes);

    uploadItems.add(
      FsMultipleMediaUploadItem(
        input: FsBytesMediaInput(bytes),
        fileType: fileType,
        fileName: fileName,
        base64: base64,
      ),
    );

    uploadItems.refresh();
  }

  void _removeUploadItem(int index) {
    uploadItems.removeAt(index);
    uploadItems.refresh();
  }
}

class FsMultipleMediaUpload extends StatefulWidget {
  const FsMultipleMediaUpload({
    super.key,
    this.controller,
    this.maxCount = 3,
    this.maxSize = 100.0,
    this.previewMode = false,
    this.title,
  });

  final FsMultipleMediaUploadController? controller;

  /// 文件最大上传数量
  final int maxCount;

  /// 文件最大大小(MB)
  final double maxSize;

  /// 预览模式
  final bool previewMode;

  /// 标题
  final String? title;

  @override
  State<FsMultipleMediaUpload> createState() => _FsMultipleMediaUploadState();
}

class _FsMultipleMediaUploadState extends State<FsMultipleMediaUpload> {
  late FsMultipleMediaUploadController controller;

  @override
  void initState() {
    controller =
        Get.put(widget.controller ?? FsMultipleMediaUploadController());
    controller._updatePreviewMode(widget.previewMode);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildFormLabel(String label) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) _buildFormLabel(widget.title!),
        const SizedBox(
          height: 4,
        ),
        Obx(
          () => Row(
            children: [
              if (!controller.previewMode.value)
                GestureDetector(
                  onTap: () {
                    controller._onClickUploadFile(
                        maxCount: widget.maxCount, maxSize: widget.maxSize);
                  },
                  child: Container(
                    width: 75,
                    height: 75,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      // color: Colors.black26,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1.0, color: Colors.grey),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              Expanded(
                child: controller.uploadItems.isNotEmpty
                    ? _buildFileItems()
                    : Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildFilePreview(FsMultipleMediaUploadFileType fileType,
      {required FsMediaInput input}) {
    switch (fileType) {
      case FsMultipleMediaUploadFileType.image:
        return FsPreviewMediaHelper.createImageWidget(input);
      case FsMultipleMediaUploadFileType.video:
        return const Icon(Icons.video_camera_back);
      default:
        return const Icon(Icons.file_copy);
    }
  }

  Widget _buildFileItems() {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var item = controller.uploadItems[index];

          late FsMultipleMediaUploadFileType fileType;

          if (item.input is FsUrlMediaInput) {
            fileType = _getFileTypeFromUrl((item.input as FsUrlMediaInput).url);
          } else {
            fileType = item.fileType ?? FsMultipleMediaUploadFileType.other;
          }

          return _buildFileItem(context, fileType, index, input: item.input);
        },
        itemCount: controller.uploadItems.length,
      ),
    );
  }

  GestureDetector _buildFileItem(
      BuildContext context, FsMultipleMediaUploadFileType fileType, int index,
      {required FsMediaInput input}) {
    return GestureDetector(
      onTap: () async {
        final navigator = Navigator.of(context);
        if (fileType == FsMultipleMediaUploadFileType.image) {
          FsPreviewMediaHelper.previewImage(navigator, input: input);
        } else if (fileType == FsMultipleMediaUploadFileType.video) {
          FsPreviewMediaHelper.previewVideo(navigator, input: input);
        }
      },
      child: Stack(
        children: [
          Container(
            width: 75,
            height: 75,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              // color: Colors.black26,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1.0, color: Colors.grey),
            ),
            child: _buildFilePreview(fileType, input: input),
          ),
          if (!controller.previewMode.value)
            Positioned(
              right: 8,
              top: 0,
              child: _buildDeleteButton(index),
            )
        ],
      ),
    );
  }

  GestureDetector _buildDeleteButton(int index) {
    return GestureDetector(
      onTap: () {
        controller._removeUploadItem(index);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          Icons.close,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}

class FsMultipleMediaUploadItem {
  FsMediaInput input;
  FsMultipleMediaUploadFileType? fileType;
  String? fileName;
  String? base64;

  FsMultipleMediaUploadItem({
    required this.input,
    this.fileType,
    this.fileName,
    this.base64,
  });

  Future<FsMultipartFile?> getMultipartFile() async {
    if (input is FsBytesMediaInput) {
      return FsMultipartFile.fromBytes(
        (input as FsBytesMediaInput).bytes,
        contentType: MediaType('multipart', 'form-data'),
      );
    }
    // TODO UrlMediaInput 类型处理
    return null;
  }
}

/// 获取Url的文件类型
FsMultipleMediaUploadFileType _getFileTypeFromUrl(String url) {
  var file = url.split('?')[0];

  // 获取文件路径中的扩展名
  String extension = p.extension(file);

  // 常见的图片扩展名
  List<String> imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];

  // 常见的视频扩展名
  List<String> videoExtensions = ['.mp4', '.avi', '.mkv', '.mov'];

  if (imageExtensions.contains(extension)) {
    return FsMultipleMediaUploadFileType.image;
  } else if (videoExtensions.contains(extension)) {
    return FsMultipleMediaUploadFileType.video;
  } else {
    return FsMultipleMediaUploadFileType.other;
  }
}

/// 文件类型
enum FsMultipleMediaUploadFileType {
  image,
  video,
  other,
}
