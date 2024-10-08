// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class BaiduTranslationApi {
  static const appid = "";
  static const key = "";
  static const salt = "";
}

final languages = ['zhCN', 'enUS'];

final toMap = {
  'zhCN': 'zh',
  'enUS': 'en',
};

const skipLan = 'zhCN';

final dio = Dio();

void main() async {
  final directory = Directory('./lib');
  final files = directory.listSync(recursive: true);
  final translations = <String, String>{};

  for (var file in files) {
    if (file is File && file.path.endsWith('.dart')) {
      final content = await file.readAsString();
      _extractTranslations(content, translations);
    }
  }

  for (var lan in languages) {
    _generateDartFile(translations, lan);
  }
}

void _extractTranslations(String content, Map<String, String> translations) {
  final regex = RegExp("(['\"])(.*?)\\1\\.tr");
  final matches = regex.allMatches(content);

  for (var match in matches) {
    final key = match.group(2)!.trim();
    translations[key] = key;
  }
}

void _generateDartFile(Map<String, String> translations, String lan) async {
  final buffer = StringBuffer();
  buffer.writeln('final Map<String, String> $lan = {');

  for (var key in translations.keys) {
    if (lan == skipLan) {
      buffer.writeln("  '$key': '${translations[key]}',");
    } else {
      var to = await _translation(key, toMap[lan]!);
      if (to != null) {
        buffer.writeln("  '$key': '$to',");
      }
    }
  }

  buffer.writeln('};');

  Directory outDir = Directory('./out');

  // 递归创建文件夹 (如果不存在)
  outDir.create(recursive: true).then((Directory directory) {
    print("文件夹已创建: ${directory.path}");

    final outputFile = File('./out/$lan.dart'); // 输出文件名
    outputFile.writeAsStringSync(buffer.toString());

    print('✅ 翻译文件已生成: ${outputFile.path}');
  }).catchError((e) {
    print("创建文件夹时出错: $e");
  });
}

Future<String?> _translation(String value, String to) async {
  String? result;

  try {
    var params = {
      "q": value,
      "from": "zh",
      "to": to,
      "appid": BaiduTranslationApi.appid,
      "salt": BaiduTranslationApi.salt,
      "sign": "",
    };

    var sign =
        "${params['appid']}${params['q']}${params['salt']}${BaiduTranslationApi.key}";

    var bytes = utf8.encode(sign);
    var digest = md5.convert(bytes);
    params["sign"] = digest.toString();

    var resp = await dio.get(
        'https://fanyi-api.baidu.com/api/trans/vip/translate',
        queryParameters: params);

    if (resp.statusCode == HttpStatus.ok) {
      result = resp.data['trans_result'][0]['dst'];
      print('✔️ 翻译: $value -> $result');
    } else {
      print('❌ 翻译: $value 失败 ${resp.statusMessage}');
    }
  } catch (e) {
    print('🚫 翻译: $value 出错 $e');
  }

  return result;
}
