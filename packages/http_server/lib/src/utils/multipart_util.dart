import 'dart:io';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:mime/mime.dart';
import 'package:shelf_multipart/shelf_multipart.dart';
import 'package:shelf_plus/shelf_plus.dart';

import '../exceptions/business_exception.dart';
import 'common_util.dart';

class MultipartUtil {
  static const List<String> _imageMimeTypes = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/webp',
    'image/bmp',
  ];

  static const List<String> _videoMimeTypes = ['video/mp4'];

  static bool isImage(String mimeType) => _imageMimeTypes.contains(mimeType);
  static bool isVideo(String mimeType) => _videoMimeTypes.contains(mimeType);

  static Future<Map<String, dynamic>> loadMultipart(
    Request request, {
    int maxFileSize = 10 * 1024 * 1024, // 10MB
    List<String> allowedExtensions = const [],
  }) async {
    final Map<String, dynamic> result = {};
    final List<FormDataFile> files = [];
    final List<FormDataField> fields = [];

    if (request.multipart() case var multipart?) {
      await for (final part in multipart.parts) {
        final headers = part.headers;
        final contentDisposition = headers['content-disposition'] ?? '';
        final contentType = headers['content-type'] ?? '';

        if (contentType == 'text/plain') {
          final value = await part.readString();
          final field = _extractFieldName(contentDisposition);
          fields.add(FormDataField(field: field, value: value));
        }

        if (_imageMimeTypes.firstWhereOrNull((e) => e == contentType) != null) {
          final field = _extractFieldName(contentDisposition);
          final fileName = _extractFileName(contentDisposition);
          final value = await part.readBytes();
          files.add(
            FormDataFile(
              fileName: fileName,
              bytes: value,
              contentType: contentType,
              size: value.length,
              field: field,
            ),
          );
        }
      }

      for (var e in files) {
        if (e.size > maxFileSize) {
          throw BusinessException.badRequest(
            '文件[${e.fileName}]大小超过${formatFileSize(maxFileSize)}',
          );
        }
      }

      result['fields'] = fields;
      result['files'] = files;

      return result;
    } else {
      throw BusinessException.badRequest('请上传文件');
    }
  }

  static String _extractFileName(String contentDisposition) {
    final regExp = RegExp(r'filename="([^"]+)"');
    final match = regExp.firstMatch(contentDisposition);
    return match?.group(1)?.replaceAll('"', '').trim() ?? 'unnamed_file';
  }

  static String _extractFieldName(String contentDisposition) {
    final regExp = RegExp(r'name="?([^";\r\n"]*)"?', caseSensitive: false);
    final match = regExp.firstMatch(contentDisposition);
    return match?.group(1) ?? 'field';
  }

  static String _getFileExtension(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }

  static String? getMimeType(String fileName) {
    return lookupMimeType(fileName);
  }

  static Future<File> saveToDisk(FormDataFile file, String directory) async {
    final dir = Directory(directory);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${file.fileName}';
    final filePath = '${dir.path}/$fileName';
    final savedFile = File(filePath);
    await savedFile.writeAsBytes(file.bytes);

    return savedFile;
  }

  static Future<List<File>> saveMultipleToDisk(
    List<FormDataFile> files,
    String directory,
  ) async {
    final savedFiles = <File>[];
    for (final file in files) {
      final savedFile = await saveToDisk(file, directory);
      savedFiles.add(savedFile);
    }
    return savedFiles;
  }
}

class FormDataFile {
  final String fileName;
  final Uint8List bytes;
  final String contentType;
  final int size;
  final String field;

  const FormDataFile({
    required this.fileName,
    required this.bytes,
    required this.contentType,
    required this.size,
    required this.field,
  });

  bool get isImage => MultipartUtil.isImage(contentType);
  bool get isVideo => MultipartUtil.isVideo(contentType);
  String get extension => fileName.split('.').last.toLowerCase();
}

class FormDataField {
  final String field;
  final String value;

  const FormDataField({required this.field, required this.value});
}
