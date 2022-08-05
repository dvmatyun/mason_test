import 'package:{{name.snakeCase()}}/core/errors/errors.dart';
import 'package:{{name.snakeCase()}}/core/navigation/global_navigator.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/repositories/auth_repository.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/usecases/get_refreshed_credentials.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/usecases/log_out.dart';
import 'package:dio/dio.dart';

class AuthorizedInterceptor extends QueuedInterceptor {
  final AuthRepository _authRepository;
  final LogOut _logOut;
  final GetRefreshedCredentials _getRefreshedCredentials;
  final Dio _dio;

  AuthorizedInterceptor({
    required AuthRepository authRepository,
    required LogOut logOut,
    required GetRefreshedCredentials getRefreshedCredentials,
    required Dio dio,
  })  : _authRepository = authRepository,
        _logOut = logOut,
        _dio = dio,
        _getRefreshedCredentials = getRefreshedCredentials;

  /// Each request should get validated auth credentials and insert token from there into the header
  /// If credentials unreachable due to their absence or inability to refresh token for any reason,
  /// request should fail with ServerError and redirect user to log in screen
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (await _maybeAddFreshTokenToOptions(options)) {
      return handler.next(options);
    }

    await _logOutAndNavigate();
    return handler.reject(ServerError(
      options,
      response: Response(
        requestOptions: options,
        statusCode: 401,
        statusMessage: 'Failed to refresh token before performing the request',
      ),
    ));
  }

  @override

  /// If request has been performed with valid credentials but response has different information,
  /// we still need to clear auth credentials and navigate to LogIn page
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    /// repeat the request with updated  credentials
    final options = err.requestOptions;
    if (await _maybeAddFreshTokenToOptions(options)) {
      final response = await _dio.fetch(options);
      return handler.resolve(response);
    }

    await _logOutAndNavigate();
    return handler.reject(err);
  }

  Future _logOutAndNavigate() async {
    final authDataResult = await _authRepository.getCurrentCredentials();
    final hasAuthData = authDataResult.isSuccess() && authDataResult.successResult() != null;

    if (hasAuthData) {
      final logoutResult = await _logOut(const LogOutParams());
      if (logoutResult.isSuccess()) {
        ///TODO: navigate to Welcome Screen: GlobalNavigator().pushAndRemoveUntil(EnterPhoneScreen.getRoute());
      }
    }
  }

  /// Gets fresh token and adds it to the passed [options]
  /// [true] if token is OK. [false] when no token added
  Future<bool> _maybeAddFreshTokenToOptions(RequestOptions options) async {
    final authDataResult = await _getRefreshedCredentials(const NoParams());
    if (authDataResult.isSuccess()) {
      options.headers.addAll({"Authorization": 'Bearer ${authDataResult.successResult().token}'});
      return true;
    }

    return false;
  }
}
