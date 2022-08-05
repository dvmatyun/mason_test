import 'package:{{name.snakeCase()}}/core/structs/usecase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

export 'package:{{name.snakeCase()}}/core/structs/usecase.dart' show NoParams;

class GetFirebaseToken implements UseCase<String?, NoParams> {
  late final FirebaseMessaging _firebaseMessaging;

  GetFirebaseToken({FirebaseMessaging? firebaseMessaging})
      : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  @override
  Future<String?> call(NoParams params) async {
    try {
      return _firebaseMessaging.getToken();
    } catch (e) {
      return null;
    }
  }
}
