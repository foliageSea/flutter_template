import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';

class StaticFileService {
  final String _webPath;

  StaticFileService(this._webPath);

  Future<Response> handler(Request request) async {
    final segments = request.url.pathSegments;
    final filePath = p.join(_webPath, segments.join('/'));
    final file = File(filePath);

    if (!file.existsSync()) {
      // 如果文件不存在，返回index.html用于SPA路由
      final indexFile = File(p.join(_webPath, 'index.html'));
      if (indexFile.existsSync()) {
        return _serveFile(indexFile);
      }
      return Response.notFound('File not found');
    }

    return _serveFile(file);
  }

  Response _serveFile(File file) {
    final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    return Response.ok(
      file.readAsBytesSync(),
      headers: {
        'content-type': mimeType,
        'cache-control': 'public, max-age=3600',
      },
    );
  }
}