import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'entity/server_entity.dart';

part 'db.g.dart';

@DriftDatabase(tables: [ServerEntity])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  static Future<String> getDatabaseDirectory() async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }
}
