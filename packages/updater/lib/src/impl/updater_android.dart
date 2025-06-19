import 'dart:io';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import '../updater.dart';

class UpdaterAndroid extends Updater with AppLogMixin {
  static UpdaterAndroid? _updaterAndroid;

  UpdaterAndroid._();

  factory UpdaterAndroid() {
    _updaterAndroid ??= UpdaterAndroid._();
    return _updaterAndroid!;
  }

  String? savePath;

  @override
  Future<dynamic> startUpdate(BuildContext context, UpdaterData data) async {
    if (updateStatus) {
      log("更新中, 跳过重复执行");
      return;
    }

    var currentVersion = data.currentVersion;
    var latestVersion = data.latestVersion;
    log("当前版本: $currentVersion 最新版本: $latestVersion");
    if (!compareVersion(currentVersion, latestVersion)) {
      return;
    }
    if (updateStatus) {
      return;
    }

    await toUpdaterPage(context, data);
  }

  @override
  Future<dynamic> downloadUpdate(UpdaterData data) async {
    var downloadUrl = data.downloadUrl;
    log("下载地址: $downloadUrl");
    var downloadPath = await getDownloadPath();
    if (downloadPath == null) {
      throw Exception("获取下载路径失败");
    }

    controller.updateMessage("开始下载更新包");
    savePath = p.join(downloadPath, 'update.apk');

    var tempFile = File(savePath!);
    if (await tempFile.exists()) {
      log("清理临时文件: $savePath");
      await tempFile.delete();
    }

    log("保存路径: $savePath");

    Dio dio = Dio();
    cancelToken = CancelToken();

    log("开始下载");
    await dio.download(
      downloadUrl,
      savePath,
      onReceiveProgress: _onReceiveProgress,
      deleteOnError: true,
      cancelToken: cancelToken,
    );
    log("下载完成");
    controller.updateMessage("下载完成");

    controller.updateFinish(true);
  }

  void _onReceiveProgress(int rec, int total) {
    var progress = rec / total;
    controller.updateProgress(progress);
  }

  @override
  Future<bool> installUpdate() async {
    if (savePath == null) {
      return false;
    }
    var result = await _installApk();
    return result.type == ResultType.done ? true : false;
  }

  Future<OpenResult> _installApk() async {
    log("打开安装程序: $savePath");
    return OpenFile.open(savePath!);
  }
}
