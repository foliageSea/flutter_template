import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class CSVLocalizationLoader {
  static Future<Map<String, Map<String, String>>> loadTranslations() async {
    final csvData = await rootBundle.loadString('assets/locales/locales.csv');
    final csvList = const CsvToListConverter().convert(csvData);

    final header = csvList[0].map((e) => e.toString()).toList();
    final result = <String, Map<String, String>>{};

    for (int i = 1; i < csvList.length; i++) {
      final row = csvList[i];
      final key = row[0].toString();

      for (int j = 1; j < row.length; j++) {
        final langCode = header[j];
        final value = row[j].toString();

        if (langCode.isNotEmpty && value.isNotEmpty) {
          result.putIfAbsent(langCode, () => {});
          result[langCode]![key] = value;
        }
      }
    }

    return result;
  }
}
