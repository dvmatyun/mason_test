import 'package:flutter_mason/core/structs/result.dart';
import 'package:flutter_mason/core/structs/usecase.dart';
import 'package:flutter_mason/feature/api_client/domain/entities/auth_errors.dart';
import 'package:flutter_mason/feature/api_client/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class RequestSmsCode extends UseCase<Result<void, AuthError>, RequestSmsCodeParams> {
  final AuthRepository _authRepository;

  RequestSmsCode({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Result<void, AuthError>> call(RequestSmsCodeParams params) {
    return _authRepository.requestSmsCode(params.phoneNumber);
  }
}

class RequestSmsCodeParams extends Equatable {
  final String phoneNumber;

  const RequestSmsCodeParams(this.phoneNumber);

  @override
  List<Object?> get props => [];
}
