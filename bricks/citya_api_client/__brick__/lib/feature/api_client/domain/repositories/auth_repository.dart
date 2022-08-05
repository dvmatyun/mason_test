import 'package:{{name.snakeCase()}}/core/structs/result.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_credentials.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_errors.dart';

abstract class AuthRepository {
  Future<Result<void, AuthError>> requestSmsCode(String phoneNumber);

  Future<Result<AuthCredentials, AuthError>> applySmsCode({
    required String phoneNumber,
    required String code,
  });

  Future<Result<void, AuthError>> logOut();

  Future<Result<AuthCredentials?, AuthError>> getCurrentCredentials();

  Future<Result<AuthCredentials, AuthError>> refreshToken(String refreshToken);
}
