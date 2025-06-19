import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageAble extends CommonInitialize {
  Future<void> loadCache();

  String? get(StorageKeys key);

  Future<void> set(StorageKeys key, String value);

  Future<void> remove(StorageKeys key);
}

class Storage implements StorageAble {
  static Storage? _storage;

  Storage._();

  factory Storage() {
    _storage ??= Storage._();
    return _storage!;
  }

  late SharedPreferencesAsync _prefs;

  final Map<StorageKeys, String?> _cache = {};

  @override
  Future init() async {
    _prefs = SharedPreferencesAsync();
    await loadCache();
  }

  @override
  Future<void> loadCache() async {
    for (var key in StorageKeys.values) {
      _cache[key] = await _prefs.getString(key.name);
    }
  }

  @override
  String? get(StorageKeys key) {
    return _cache[key];
  }

  @override
  Future<void> set(StorageKeys key, String value) async {
    _cache[key] = value;
    await _prefs.setString(key.name, value);
  }

  @override
  Future<void> remove(StorageKeys key) async {
    await _prefs.remove(key.name);
    _cache.remove(key);
  }

  @override
  String getOutput() {
    return 'Storage 初始化完成';
  }
}

extension StringOrNullParse on String? {
  int parseInt({int defaultValue = 0}) {
    if (this == null) {
      return defaultValue;
    }
    return int.tryParse(this!) ?? defaultValue;
  }

  bool parseBool({bool defaultValue = false}) {
    if (this == null) {
      return defaultValue;
    }
    return bool.tryParse(this!) ?? defaultValue;
  }

  String parseString({String defaultValue = ''}) {
    if (this == null) {
      return defaultValue;
    }
    return this!;
  }
}
