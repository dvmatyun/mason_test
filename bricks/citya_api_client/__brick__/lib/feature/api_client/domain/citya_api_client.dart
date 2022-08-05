import 'dart:convert';
import 'package:{{name.snakeCase()}}/app/environment/configuration.dart';
import 'package:{{name.snakeCase()}}/core/data/remote/api_routes.dart';
import 'package:{{name.snakeCase()}}/core/data/remote/data_response_deserializer.dart';
import 'package:{{name.snakeCase()}}/core/errors/errors.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/repositories/auth_repository.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/usecases/get_refreshed_credentials.dart';
import 'package:{{name.snakeCase()}}/feature/api_client/domain/usecases/log_out.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_mason/feature/api_client/interceptors/auth.dart';
import 'package:flutter_mason/core/data/remote/interceptors/bad_network.dart';

/// Wrapper around Dio client for streamlining its configuration
class CityaApiClient {
  final AppConfiguration _appConfigurations;
  final Dio _unauthorizedDioClient;
  final Dio _authorizedDioClient;

  CityaApiClient({
    required AppConfiguration appConfigurations,
    Dio? unauthorizedClient,
    Dio? authorizedClient,
  })  : _appConfigurations = appConfigurations,
        _unauthorizedDioClient = unauthorizedClient ?? Dio(),
        _authorizedDioClient = authorizedClient ?? Dio();

  BaseOptions get _options => BaseOptions(
        baseUrl: _appConfigurations.apiUrl,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
      );

  /// Non-nullable generic return type makes it impossible for mockito to mock this method
  /// as it requires to pass sample object of that [T] type as the result of mock method, which is impossible due to
  /// numerous possibilities for that type in runtime
  Future<T> request<T>(ApiRoute<T> apiRoute, {Map<String, dynamic>? data, List<String>? pathParameters}) async {
    final response = await _requestResponseData(apiRoute, data, pathParameters);
    if (apiRoute.modelType == EmptyResponse) return const EmptyResponse() as T;

    final parsedModel = DataResponseDeserializer.deserialize(response.data, apiRoute.modelFactory);
    return parsedModel;
  }

  Future<List<T>> requestList<T>(
    ApiRoute<T> apiRoute, {
    Map<String, dynamic>? data,
    List<String>? pathParameters,
  }) async {
    final response = await _requestResponseData(apiRoute, data, pathParameters);
    if (apiRoute.modelType == EmptyResponse) return [];

    final parsedModel = DataResponseDeserializer.deserializeList(response.data, apiRoute.modelFactory);
    return parsedModel;
  }

  Future<Response> _requestResponseData(
    ApiRoute apiRoute, [
    Map<String, dynamic>? data,
    List<String>? pathParameters,
  ]) async {
    final client = apiRoute.isSecure ? _authorizedDioClient : _unauthorizedDioClient;
    final response = await client.fetch(Options(method: apiRoute.method.name.toUpperCase()).compose(
      client.options,
      apiRoute.getPath(pathParameters),
      data: data,
    ));

    if (response.statusCode != 200) {
      throw ServerError(response.requestOptions);
    }

    /// Fix response to be always a Map
    if (response.data is String) {
      final jsonString = (response.data as String).isEmpty ? '{}' : response.data;
      response.data = jsonDecode(jsonString);
    }

    final error = DataResponseDeserializer.getErrorObject(response.data);
    if (error != null) throw error;
    return response;
  }

  void configureUnauthorizedApiClient() {
    _unauthorizedDioClient.options = _options;
    _unauthorizedDioClient.interceptors.addAll([
      BadNetworkErrorInterceptor(),
      PrettyDioLogger(requestBody: true),
    ]);
  }

  void configureAuthorizedClient({
    required AuthRepository authRepository,
    required LogOut logOut,
    required GetRefreshedCredentials getRefreshedCredentials,
  }) {
    _authorizedDioClient.options = _options;
    _authorizedDioClient.interceptors.addAll([
      BadNetworkErrorInterceptor(),
      PrettyDioLogger(requestBody: true),
      AuthorizedInterceptor(
        authRepository: authRepository,
        logOut: logOut,
        getRefreshedCredentials: getRefreshedCredentials,
        dio: _authorizedDioClient,
      ),
    ]);
  }
}
