import 'dart:io';

import 'package:flutter_mason/core/errors/errors.dart';
import 'package:dio/dio.dart';

/// Transforms some DioErrors into well-known connectivity errors that are defined in our app
class BadNetworkErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (_isTimeoutError(err)) {
      return handler.reject(BadConnectionError(err.requestOptions));
    }

    if ((err.response?.statusCode ?? 0) > 400) {
      return handler.next(ServerError.fromDioError(err));
    }

    return handler.next(err);
  }

  bool _isTimeoutError(DioError error) {
    var isSocketException = error.type == DioErrorType.other && error.error?.runtimeType == SocketException;

    return isSocketException || error.type == DioErrorType.receiveTimeout || error.type == DioErrorType.connectTimeout;
  }
}
