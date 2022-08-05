import 'package:{{name.snakeCase()}}/feature/api_client/domain/entities/auth_type.dart';
import 'package:equatable/equatable.dart';

class AuthCredentials extends Equatable {
  final String token;
  final String refreshToken;
  final AuthType authType;
  final DateTime expiresAt;

  const AuthCredentials({
    required this.token,
    required this.authType,
    required this.refreshToken,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [token, authType, refreshToken, expiresAt];

  AuthCredentials copyWith({
    String? token,
    String? refreshToken,
    AuthType? authType,
    DateTime? expiresAt,
  }) {
    return AuthCredentials(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      authType: authType ?? this.authType,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
