// ignore_for_file: avoid_print

import 'dart:io';
import 'package:pubspec_yaml/pubspec_yaml.dart';

void main() {
  // 读取 pubspec.yaml 文件
  final pubspec = File('pubspec.yaml').readAsStringSync().toPubspecYaml();

  // 获取当前的包名
  var currentName = pubspec.name;
  print('当前包名: $currentName');

  // 提示用户输入新的包名
  stdout.write('请输入新的包名: ');
  var changeName = stdin.readLineSync();

  var dir = Directory('lib');
  if (dir.existsSync()) {
    processDirectory(
      dir: dir,
      currentName: currentName,
      changeName: changeName,
    );
    changePubspecName(pubspec, changeName);
    print('修改完成, 回车后退出');
    stdin.readLineSync();
  } else {
    print('lib 目录不存在, 回车后退出');
    stdin.readLineSync();
  }
}

// 递归处理 lib 及其子目录下的所有.dart 文件
void processDirectory({
  required Directory dir,
  required String currentName,
  String? changeName,
}) {
  var dartFiles = dir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'));
  for (var file in dartFiles) {
    var content = file.readAsStringSync();
    if (content.contains('package:$currentName/')) {
      var newContent =
          content.replaceAll('package:$currentName/', 'package:$changeName/');
      file.writeAsStringSync(newContent);
      print('修改文件: ${file.path}');
    }
  }

  var subDirectories = dir.listSync().whereType<Directory>();
  for (var subDir in subDirectories) {
    processDirectory(
        dir: subDir, currentName: currentName, changeName: changeName);
  }
}

void changePubspecName(PubspecYaml pubspec, String? changeName) {
  pubspec.customFields['name'] = changeName;
  File('pubspec.yaml').writeAsStringSync(pubspec.toYamlString());
}
