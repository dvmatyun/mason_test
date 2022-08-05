/// Errors that we EXPECT to receive within auth domain flow
abstract class AuthError implements Exception {}

class InvalidPhoneNumberError implements AuthError {
  final String message;

  InvalidPhoneNumberError(this.message);
}

class CodeSendingBlockedError implements AuthError {}

class CodeDoesNotMatchError implements AuthError {}

class AuthServiceUnavailableError implements AuthError {}

class UnauthorizedError implements AuthError {}

class CanNotRegisterDriverError implements AuthError {}

class CredentialsAuthError implements AuthError {
  final String? message;

  CredentialsAuthError([this.message]);
}
