import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_keys.dart';

abstract class StorageAble {
  Future<void> init();

  Future<void> loadCache();

  String? get(StorageKeys key);

  Future<void> set(StorageKeys key, String value);

  Future<void> remove(StorageKeys key);
}

class Storage with AppLogMixin implements StorageAble {
  static Storage? _storage;

  Storage._();

  factory Storage() {
    _storage ??= Storage._();
    return _storage!;
  }

  late SharedPreferencesAsync _prefs;

  final Map<StorageKeys, String?> _cache = {};

  @override
  Future<void> init() async {
    _prefs = SharedPreferencesAsync();
    await loadCache();
  }

  @override
  Future<void> loadCache() async {
    for (var key in StorageKeys.values) {
      _cache[key] = await _prefs.getString(key.name);
    }
    log('加载缓存完成');
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
}
