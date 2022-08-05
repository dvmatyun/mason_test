import 'package:{{name.snakeCase()}}/core/structs/dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStringDto implements Dto<String> {
  final Future<SharedPreferences> _sharedPreferencesFuture;
  final String _key;

  String get key => _key;

  SharedPreferencesStringDto({required String key, SharedPreferences? sharedPreferences})
      : _key = key,
        _sharedPreferencesFuture =
            sharedPreferences == null ? SharedPreferences.getInstance() : Future.value(sharedPreferences);

  @override
  Future<String?> get() async {
    final sp = await _sharedPreferencesFuture;
    if (sp.containsKey(key)) return sp.getString(key);
    return null;
  }

  @override
  Future save(String? value) async {
    final sp = await _sharedPreferencesFuture;
    if (value == null) return sp.remove(key);
    return sp.setString(key, value);
  }
}

class SharedPreferencesBoolDto implements Dto<bool> {
  final Future<SharedPreferences> _sharedPreferencesFuture;
  final String _key;

  String get key => _key;

  SharedPreferencesBoolDto({required String key, SharedPreferences? sharedPreferences})
      : _key = key,
        _sharedPreferencesFuture =
            sharedPreferences == null ? SharedPreferences.getInstance() : Future.value(sharedPreferences);

  @override
  Future<bool?> get() async {
    final sp = await _sharedPreferencesFuture;
    if (sp.containsKey(key)) return sp.getBool(key);
    return null;
  }

  @override
  Future save(bool? value) async {
    final sp = await _sharedPreferencesFuture;
    if (value == null) return sp.remove(key);
    return sp.setBool(key, value);
  }
}
