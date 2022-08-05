import 'package:{{name.snakeCase()}}/core/structs/result.dart';
import 'package:{{name.snakeCase()}}/core/structs/usecase.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_credentials.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_errors.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class ApplySmsCode extends UseCase<Result<AuthCredentials, AuthError>, ApplySmsCodeParams> {
  final AuthRepository _authRepository;

  ApplySmsCode({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Result<AuthCredentials, AuthError>> call(ApplySmsCodeParams params) {
    return _authRepository.applySmsCode(phoneNumber: params.phoneNumber, code: params.code);
  }
}

class ApplySmsCodeParams extends Equatable {
  final String phoneNumber;
  final String code;

  const ApplySmsCodeParams({
    required this.phoneNumber,
    required this.code,
  });

  @override
  List<Object?> get props => [phoneNumber, code];
}
