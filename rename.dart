import 'dart:developer';
import 'dart:io';
import 'package:pubspec_yaml/pubspec_yaml.dart';

void main() {
  // 读取 pubspec.yaml 文件
  final pubspecYaml = File('pubspec.yaml').readAsStringSync().toPubspecYaml();

  // 获取当前的包名
  var currentName = pubspecYaml.name;
  log('当前包名: $currentName');

  // 提示用户输入新的包名
  stdout.write('请输入新的包名: ');
  var newName = stdin.readLineSync();

  var libDirectory = Directory('lib');
  if (libDirectory.existsSync()) {
    processDirectory(
      directory: libDirectory,
      currentName: currentName,
      newName: newName,
    );
    changePubspecName(pubspecYaml, newName);
    print('修改完成');
  } else {
    print('lib 目录不存在');
  }
}

// 递归处理 lib 及其子目录下的所有.dart 文件
void processDirectory({
  required Directory directory,
  required String currentName,
  String? newName,
}) {
  var dartFiles = directory
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'));
  for (var file in dartFiles) {
    var content = file.readAsStringSync();
    if (content.contains('package:$currentName')) {
      var newContent =
          content.replaceAll('package:$currentName', 'package:$newName');
      file.writeAsStringSync(newContent);
      print('修改文件: ${file.path}');
    }
  }

  var subDirectories = directory.listSync().whereType<Directory>();
  for (var subDir in subDirectories) {
    processDirectory(
        directory: subDir, currentName: currentName, newName: newName);
  }
}

void changePubspecName(PubspecYaml pubspecYaml, String? newName) {
  pubspecYaml.customFields['name'] = newName;
  File('pubspec.yaml').writeAsStringSync(pubspecYaml.toYamlString());
}
