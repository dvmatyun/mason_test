import 'package:{{name.snakeCase()}}/core/structs/result.dart';
import 'package:{{name.snakeCase()}}/core/structs/usecase.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_credentials.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_errors.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/repositories/auth_repository.dart';

export 'package:{{name.snakeCase()}}/core/structs/usecase.dart' show NoParams;

class GetRefreshedCredentials implements UseCase<Result<AuthCredentials, AuthError>, NoParams> {
  final AuthRepository _authRepository;

  /// we don't want to send multiple requests for the refresh token simultaneously
  /// if any refresh token request is undergo process, we will wait for it to complete instead of making new one
  Future<Result<AuthCredentials, AuthError>>? _refreshTokenFuture;

  GetRefreshedCredentials({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Result<AuthCredentials, AuthError>> call(NoParams params) async {
    final currentCredentialsResult = await _authRepository.getCurrentCredentials();
    if (currentCredentialsResult.isError() || currentCredentialsResult.successResult() == null) {
      return Error(CredentialsAuthError('Can not refresh token: auth credentials are unavailable'));
    }

    final oldCredentials = currentCredentialsResult.successResult()!;
    final hasExpired = DateTime.now().isAfter(oldCredentials.expiresAt);
    if (!hasExpired) {
      return Success(oldCredentials);
    }

    try {
      _refreshTokenFuture ??= _authRepository.refreshToken(oldCredentials.refreshToken);
      final refreshResult = await _refreshTokenFuture!;
      if (refreshResult.isError()) {
        return Error(refreshResult.errorResult());
      }

      return Success(refreshResult.successResult());
    } finally {
      _refreshTokenFuture = null;
    }
  }
}
