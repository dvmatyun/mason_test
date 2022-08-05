import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class StripeClient {
  /// TODO: use secret manager to access
  static const publicToken = '';

  final Dio _dioClient = Dio();

  Dio get client => _dioClient;

  BaseOptions get _options => BaseOptions(
        baseUrl: 'TODO:',
        connectTimeout: 5000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
      );

  void configureMapboxClient() {
    _dioClient.options = _options;
    _dioClient.interceptors.addAll([
      PrettyDioLogger(requestBody: true),
    ]);
  }
}
