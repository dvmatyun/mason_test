import 'package:{{name.snakeCase()}}/core/data/device/package_data_source.dart';
import 'package:{{name.snakeCase()}}/core/data/local/hive.dart';
import 'package:{{name.snakeCase()}}/core/services/cache_service/cache_service.dart';
import 'package:{{name.snakeCase()}}/core/services/logger/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCacheService implements CacheService {
  static const _cacheVersionKey = 'HiveCacheService.cacheVersion';
  static const _cacheDateKey = 'HiveCacheService.cacheDate';
  static const cacheDeprecationThreshold = Duration(hours: 24);

  final PackageInfoDataSource _packageInfoDataSource;
  final _openedBoxes = <String, Box>{};

  HiveCacheService({required PackageInfoDataSource packageInfoDataSource})
      : _packageInfoDataSource = packageInfoDataSource;

  Future<Box> _getOpenedBoxByKey(String key) async {
    late final Box box;
    if (_openedBoxes.containsKey(key)) {
      box = _openedBoxes[key]!;
    } else {
      box = await HiveUtils.openBoxSafely(key);
      _openedBoxes[key] = box;
    }
    return box;
  }

  @override
  Future<void> addOrReplaceValue<T>(String key, T? value) async {
    final box = await _getOpenedBoxByKey(key);
    await HiveUtils.saveValue(box, key, value);
    await HiveUtils.saveValue(box, _cacheDateKey, DateTime.now().toIso8601String());
    try {
      final appVersion = await _packageInfoDataSource.getAppVersion();
      await HiveUtils.saveValue(box, _cacheVersionKey, appVersion);
    } catch (e) {
      log.e('Couldn\'t cache app version for box $key: ${e.toString()}');
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    final exists = await Hive.boxExists(key);
    return exists;
  }

  @override
  Future<T?> getValue<T>(String key, {bool discardDeprecated = false}) async {
    if (!await containsKey(key)) {
      return null;
    }

    final box = await _getOpenedBoxByKey(key);
    if (box.isEmpty || !box.containsKey(key)) {
      return null;
    }

    if (discardDeprecated && (await _isBoxDeprecated(box))) {
      return null;
    }

    return HiveUtils.readValueOf<T>(box, key);
  }

  @override
  Future<List<T>?> getList<T>(String key, {bool discardDeprecated = false}) async {
    if (!await containsKey(key)) {
      return null;
    }

    final box = await _getOpenedBoxByKey(key);
    if (box.isEmpty || !box.containsKey(key)) {
      return null;
    }

    if (discardDeprecated && (await _isBoxDeprecated(box))) {
      return null;
    }

    final data = HiveUtils.readValueOf<List>(box, key);
    return data.cast<T>();
  }

  Future<bool> _isBoxDeprecated(Box box) async {
    if (!(box.containsKey(_cacheVersionKey) && box.containsKey(_cacheDateKey))) return true;

    try {
      /// Deprecation by time
      final cachedAt = DateTime.parse(HiveUtils.readValueOf<String>(box, _cacheDateKey));
      final isDeprecatedByTime = DateTime.now().isAfter(cachedAt.add(cacheDeprecationThreshold));
      if (isDeprecatedByTime) return true;

      /// Deprecation by app version
      final appVersion = await _packageInfoDataSource.getAppVersion();
      final cacheVersion = HiveUtils.readValueOf<String>(box, _cacheVersionKey);
      return appVersion != cacheVersion;
    } catch (e) {
      log.e('Couldn\'t check cache deprecation status for box ${box.name}: ${e.toString()}');
      return true;
    }
  }
}
