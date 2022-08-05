class JsonHelpers {
  JsonHelpers._();

  /// Read json value by decomposing path using dot character
  /// Example: path value of 'object.inside.value' will read json as json[object]?[inside]?[value]
  static dynamic readNestedValue(Map<dynamic, dynamic> json, String path) {
    final domains = path.split('.');
    var currentObject = json;

    /// unwrap object from nesting
    /// returns [null] if object cannot be unwrapped
    for (int i = 0; i < domains.length - 1; i++) {
      final domain = domains[i];
      final value = currentObject[domain];

      if (value is Map) {
        currentObject = value;
      } else {
        return null;
      }
    }

    final result = currentObject[domains.last];
    return result;
  }

  /// Read json value by decomposing path by comma character
  /// Will try to unwrap the value from given json by trying to fit all the comma separated keys
  /// Example: path value of 'mainKey,fallbackKey,planCKey' will try to read json[mainKey] first,
  /// if it null, it will try json[fallbackKey], then if it fail once again it will pick json[planCKey]
  static dynamic readValueWithFallbackKeys(Map<dynamic, dynamic> json, String path) {
    final keys = path.split(',');

    for (int i = 0; i < keys.length; i++) {
      final currentKey = keys[i];
      if (json.containsKey(currentKey)) return json[currentKey];
    }

    return null;
  }
}
