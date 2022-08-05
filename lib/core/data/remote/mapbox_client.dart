import 'package:flutter_mason/core/data/remote/mapbox_routes.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MapboxClient {
  /// TODO: use secret manager to access
  static const publicToken =
      'pk.eyJ1IjoiY2l0eWFtb2JpbGl0eSIsImEiOiJja3lhMGlpdWswMHprMndxbHZrNm81c2Q3In0.TQ_gB0fJnrSX_mc7xpb7gg';

  final Dio _dioClient = Dio();

  Dio get client => _dioClient;

  BaseOptions get _options => BaseOptions(
        baseUrl: MapboxRoutes.baseUrl,
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
