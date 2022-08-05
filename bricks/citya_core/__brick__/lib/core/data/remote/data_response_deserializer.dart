import 'package:{{name.snakeCase()}}/core/errors/errors.dart';

typedef JsonMap = Map<String, dynamic>;

class DataResponseDeserializer {
  static T deserialize<T>(JsonMap json, T Function(JsonMap json) fromJsonFactory) {
    final error = getErrorObject(json);
    if (error != null) throw error;
    if (!json.containsKey('data') || json.isEmpty) {
      throw NoDataInResponse('Deserializing model of type $T error: wrong data signature');
    }
    if (json['data'] is! Map) {
      return fromJsonFactory(json);
    }
    final data = json['data'];
    return fromJsonFactory(data);
  }

  static List<T> deserializeList<T>(JsonMap json, T Function(JsonMap json) fromJsonFactory) {
    final error = getErrorObject(json);
    if (error != null) throw error;
    if (!json.containsKey('data')) {
      return <T>[];
    }
    if (json['data'] is! List) {
      throw DataIntegrityError('Deserializing list of models of type $T error: wrong data signature');
    }
    final data = json['data'] as List;
    return data.map((item) => fromJsonFactory(item)).toList();
  }

  /// Gets the error field and converts it into known error object
  static Exception? getErrorObject(JsonMap json) {
    if (!json.containsKey('meta')) return null;
    final metaObject = json['meta'];
    if (!(metaObject is Map && metaObject.containsKey('errorCode'))) return null;
    final errorCode = metaObject['errorCode'];
    switch (errorCode) {
      //case "EmailIsAlreadyUsed":
      //  return EmailIsAlreadyUsedError();
      default:
        return null;
    }
  }
}
