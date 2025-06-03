import 'package:drift/drift.dart';

class ServerEntity extends Table {
  @override
  String get tableName => 'server';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get url => text()();
  IntColumn get type => integer()();
  TextColumn get username => text()();
  TextColumn get password => text()();
}
