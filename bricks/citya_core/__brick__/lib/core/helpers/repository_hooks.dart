import 'package:{{name.snakeCase()}}/core/errors/errors.dart';
import 'package:{{name.snakeCase()}}/core/services/logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

/// Collection of wrapper functions to reduce boilerplating inside remote data source handling
class RepositoryHooks {
  RepositoryHooks._();

  /// Run [body] code block and log any unexpected error
  /// wraps that error into common [UnknownError] and passes it to the handler (if provided)
  static Future<T> withUnexpectedErrorLogging<T>(
    Future<T> Function() body, {
    Future<T> Function(Exception error)? onError,
  }) async {
    try {
      final result = await body();
      return result;
    } catch (unexpectedError, stack) {
      final wrapped = UnexpectedError(error: unexpectedError);
      if (onError == null) {
        log.e(unexpectedError.toString(), unexpectedError, stack);
        throw wrapped;
      }
      return (await onError(wrapped));
    }
  }

  /// Run [body] code block with considering all common server errors in the separate handlers
  static Future<T> withNetworkErrorsHandling<T>({
    required Future<T> Function() body,
    Future<T> Function(ServerError error)? onServerError,
    Future<T> Function(BadConnectionError error)? onBadConnectionError,
    Future<T> Function(NoDataInResponse error)? onNoDataError,
  }) async {
    try {
      final result = await body();
      return result;
    } on ServerError catch (serverError) {
      log.d('ServerError', serverError);
      if (onServerError == null) rethrow;
      return (await onServerError(serverError));
    } on BadConnectionError catch (badConnectionError, stack) {
      log.d('BadConnectionError', badConnectionError, stack);
      if (onBadConnectionError == null) rethrow;
      return (await onBadConnectionError(badConnectionError));
    } on NoDataInResponse catch (noDataError, stack) {
      log.d('NoDataInResponse', onNoDataError, stack);
      if (onNoDataError == null) rethrow;
      return (await onNoDataError(noDataError));
    } on DioError catch (dioError) {
      final serverError = ServerError.fromDioError(dioError);
      log.d('ServerError', serverError);
      if (onServerError == null) rethrow;
      return (await onServerError(serverError));
    }
  }

  /// Run [body] code block with considering all common cache errors in the separate handlers
  /// Automatically deletes corrupted data before throwing [CacheDataCorrupted]
  static Future<T> withCacheErrorsHandling<T>({
    required Future<T> Function() body,
    Future<T> Function(CacheError error)? onCacheError,
  }) async {
    try {
      final result = await body();
      return result;
    } on CacheError catch (cacheError, stack) {
      log.d('CacheError', cacheError, cacheError is CacheDataNotFound ? null : stack);
      if (cacheError is CacheDataCorrupted && Hive.isBoxOpen(cacheError.storageName)) {
        Hive.box(cacheError.storageName).delete(cacheError.corruptedKey);
      }
      if (onCacheError == null) rethrow;
      return (await onCacheError(cacheError));
    }
  }

  /// Run [body] wrapped in all handlers from above while always handling the error uniformly
  /// This approach in NOT recommended unless it is for temporary usage while there is no error distinguishing is possible
  static Future<T> withUniformErrorHandling<T>(
    Future<T> Function() body, {
    Future<T> Function(Exception error)? onError,
  }) {
    return withUnexpectedErrorLogging(
      () => withNetworkErrorsHandling(
        body: () {
          return withCacheErrorsHandling(body: body, onCacheError: onError);
        },
        onServerError: onError,
        onBadConnectionError: onError,
        onNoDataError: onError,
      ),
      onError: (Exception error) {
        final unwrappedException = (error is UnexpectedError) ? error.error : error;
        if (onError == null) throw error;
        return onError.call(unwrappedException is! Exception ? error : unwrappedException);
      },
    );
  }
}
