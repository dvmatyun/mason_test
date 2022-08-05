import 'package:{{name.snakeCase()}}/core/structs/usecase.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class IsAuthorized implements UseCase<bool, IsAuthorizedParams> {
  final AuthRepository _authRepository;

  IsAuthorized({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<bool> call(IsAuthorizedParams params) async {
    final authCredentialsResult = await _authRepository.getCurrentCredentials();
    if (authCredentialsResult.isSuccess() && authCredentialsResult.successResult() != null) {
      return true;
    }

    return false;
  }
}

class IsAuthorizedParams extends Equatable {
  @override
  List<Object?> get props => [];
}
