import 'package:hive_flutter/hive_flutter.dart';

class HiveCacheHelper {
  static late Box _box;
  static Future<void> init(String boxName) async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  static Future<void> saveData<T>(String key, T value) async {
    await _box.put(key, value);
  }

  static T? getData<T>(String key) {
    if (!_box.isOpen) {
      throw Exception("HiveCacheHelper not initialized. Call init() first.");
    }
    return _box.get(key) as T?;
  }

  static List<T> getListData<T>(String key) {
    if (!_box.isOpen) {
      throw Exception("HiveCacheHelper not initialized. Call init() first.");
    }

    final value = _box.get(key);
    if (value == null) return <T>[];
    if (value is List<T>) return List<T>.from(value);
    if (value is List) {
      try {
        return value.cast<T>();
      } catch (_) {
        return <T>[];
      }
    }

    if (value is T) {
      final migrated = <T>[value];
      _box.put(key, migrated);
      return migrated;
    }

    return <T>[];
  }

  static Future<void> removeData(String key) async {
    await _box.delete(key);
  }

  static Future<void> clearData() async {
    await _box.clear();
  }

  static bool containsKey(String key) {
    return _box.containsKey(key);
  }
}
