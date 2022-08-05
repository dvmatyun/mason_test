import 'package:flutter_mason/core/data/local/internal_hive_metadata.dart';
import 'package:flutter_mason/core/errors/errors.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveUtils {
  static const _metadataBoxKey = 'metadata';
  static const version = '01';

  /// Inits the Hive, register all of its type adapters
  /// and opens all the boxes so that they can be accessed synchronously without any  issues
  static Future initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(InternalHiveMetadataAdapter()); //typeId: 1

    await _resetDataIfVersionMismatch();
  }

  static Future _resetDataIfVersionMismatch() async {
    final exists = await Hive.boxExists(_metadataBoxKey);
    bool shouldReset = false;
    if (exists) {
      final box = await openBoxSafely(_metadataBoxKey);
      final value = readValueOf<InternalHiveMetadata>(box, _metadataBoxKey);
      if (value.version != version) {
        shouldReset = true;
      }
    } else {
      shouldReset = true;
    }

    if (shouldReset) {
      //await Hive.deleteBoxFromDisk(DevMapDetailsDataSource.areaInfoModelsDevKey);
      final newBox = await openBoxSafely(_metadataBoxKey);
      saveValue(newBox, _metadataBoxKey, InternalHiveMetadata(version: version));
    }
  }

  static Future resetAllData() async {
    return Hive.deleteFromDisk();
  }

  /// Gets the list of type [T] out of the passed box
  /// Handles all ongoing cache errors
  static List<T> readListOf<T>(Box box, dynamic key) {
    if (!box.isOpen) {
      throw CacheStorageUnavailable(box.name);
    }

    if (box.isEmpty || !box.containsKey(key)) {
      throw CacheDataNotFound(box.name, key.toString());
    }

    final boxValue = box.get(key);
    if (boxValue is! List) {
      throw CacheDataCorrupted(box.name, key.toString());
    }

    try {
      return boxValue.cast<T>();
    } catch (_) {
      throw CacheDataCorrupted(box.name, key.toString());
    }
  }

  /// Gets the value of type [T] out of the passed box
  /// Handles all ongoing cache errors
  static T readValueOf<T>(Box box, dynamic key) {
    if (!box.isOpen) {
      throw CacheStorageUnavailable(box.name);
    }

    if (box.isEmpty || !box.containsKey(key)) {
      throw CacheDataNotFound(box.name, key.toString());
    }

    final boxValue = box.get(key);

    if (boxValue is! T) {
      throw CacheDataCorrupted(box.name, key.toString());
    }

    try {
      return boxValue;
    } catch (_) {
      throw CacheDataCorrupted(box.name, key.toString());
    }
  }

  static Future<Box> openBoxSafely(String boxKey, {Box? box}) async {
    if (box != null) {
      return box;
    }
    try {
      final openedBox = await Hive.openBox(boxKey);
      return openedBox;
    } catch (_) {
      await Hive.deleteBoxFromDisk(boxKey);
      final openedBox = await Hive.openBox(boxKey);
      return openedBox;
    }
  }

  static Future saveValue<T>(Box box, dynamic key, T? value) async {
    if (!box.isOpen) {
      throw CacheStorageUnavailable(box.name);
    }

    return box.put(key, value);
  }
}
