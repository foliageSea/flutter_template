import 'package:core/core.dart';
import 'package:flutter_template/db/services/user_service.dart';
import 'package:flutter_template/objectbox.g.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// 文档地址
/// https://docs.objectbox.io/
class AppDatabase with AppLogMixin {
  late final Store store;

  late String path;
  late GetIt getIt;

  Future init(GetIt getIt) async {
    this.getIt = getIt;
    final docsDir = await getApplicationDocumentsDirectory();
    path = p.join(docsDir.path, "db");
    store = await openStore(directory: path);
    register();
  }

  String getPath() {
    return path;
  }

  void register() {
    getIt.registerSingleton<UserService>(UserServiceImpl());
  }
}

mixin AppDatabaseMixin {
  Store get db => GetIt.I<AppDatabase>().store;
}
