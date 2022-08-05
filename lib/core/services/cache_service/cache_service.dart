abstract class CacheService {
  Future<bool> containsKey(String key);

  Future<T?> getValue<T>(String key, {bool discardDeprecated});

  Future<List<T>?> getList<T>(String key, {bool discardDeprecated});

  Future<void> addOrReplaceValue<T>(String key, T? value);
}
