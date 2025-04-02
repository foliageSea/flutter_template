import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageInterface {
  Future init();

  Future<void> setString(StorageKey key, String value);

  Future<String?> getString(StorageKey key);

  Future<void> remove(StorageKey key);
}

class LocalStorage implements LocalStorageInterface {
  static LocalStorage? _instance;

  LocalStorage._();

  factory LocalStorage() {
    return _instance ??= LocalStorage._();
  }

  late SharedPreferencesAsync prefs;

  @override
  Future init() async {
    prefs = SharedPreferencesAsync();
  }

  @override
  Future<String?> getString(StorageKey key) async {
    return prefs.getString(key.name);
  }

  @override
  Future<void> setString(StorageKey key, String value) {
    return prefs.setString(key.name, value);
  }

  @override
  Future<void> remove(StorageKey key) {
    return prefs.remove(key.name);
  }
}

enum StorageKey {
  token,
}
