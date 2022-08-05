import 'package:{{name.snakeCase()}}/core/structs/result.dart';
import 'package:{{name.snakeCase()}}/core/structs/usecase.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_errors.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LogOut implements UseCase<Result<void, AuthError>, LogOutParams> {
  final AuthRepository _authRepository;
  final FirebaseMessaging _firebaseMessaging;

  LogOut({
    required AuthRepository authRepository,
    FirebaseMessaging? firebaseMessaging,
  })  : _authRepository = authRepository,
        _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  @override
  Future<Result<void, AuthError>> call(LogOutParams params) async {
    final result = await _authRepository.logOut();
    if (result.isSuccess()) {
      await _firebaseMessaging.deleteToken();
    }
    return result;
  }
}

class LogOutParams extends Equatable {
  const LogOutParams();

  @override
  List<Object?> get props => [];
}
