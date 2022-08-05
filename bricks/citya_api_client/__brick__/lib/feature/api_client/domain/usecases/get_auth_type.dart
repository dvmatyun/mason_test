import 'package:{{name.snakeCase()}}/core/structs/usecase.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_errors.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_type.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/repositories/auth_repository.dart';

export 'package:{{name.snakeCase()}}/core/structs/usecase.dart' show NoParams;

class GetAuthType implements UseCase<AuthType, NoParams> {
  final AuthRepository _authRepository;

  GetAuthType({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<AuthType> call(NoParams params) async {
    final credentialsResult = await _authRepository.getCurrentCredentials();
    if (credentialsResult.isError() || credentialsResult.successResult() == null) {
      throw UnauthorizedError();
    }

    return credentialsResult.successResult()!.authType;
  }
}
