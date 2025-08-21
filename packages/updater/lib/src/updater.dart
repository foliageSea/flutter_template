import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:updater/src/impl/updater_android.dart';

import 'pages/updater_page.dart';

class UpdaterData {
  String currentVersion;
  String latestVersion;
  String downloadUrl;

  UpdaterData(this.currentVersion, this.latestVersion, this.downloadUrl);
}

abstract class Updater {
  UpdaterPageController controller = UpdaterPageController();
  bool updateStatus = false;

  CancelToken? cancelToken;

  Future<dynamic> startUpdate(BuildContext context, UpdaterData data);

  Future<dynamic> downloadUpdate(UpdaterData data);

  Future<bool> installUpdate();

  static Updater getInstance() {
    if (Platform.isAndroid) {
      return UpdaterAndroid();
    }
    return UpdaterAndroid();
  }
}

extension UpdaterExtension on Updater {
  bool compareVersion(String currentVersion, String latestVersion) {
    return Version.parse(latestVersion) > Version.parse(currentVersion);
  }

  Future<T?> toUpdaterPage<T>(BuildContext context, UpdaterData data) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (context) => UpdaterPage(
          data: data,
        ),
      ),
    );
  }

  Future<String?> getDownloadPath() async {
    var list = await getExternalCacheDirectories();
    if (list == null || list.isEmpty) {
      return null;
    }
    return list.first.path;
  }
}

class UpdaterPageController {
  final ValueNotifier<double> progress = ValueNotifier(0);
  final ValueNotifier<String> message = ValueNotifier("");
  final ValueNotifier<bool> finish = ValueNotifier(false);

  void updateProgress(double value) {
    progress.value = value;
  }

  void updateMessage(String value) {
    message.value = value;
  }

  void updateFinish(bool value) {
    finish.value = value;
  }

  void reset() {
    progress.value = 0;
    message.value = "";
    finish.value = false;
  }
}
