import 'package:{{name.snakeCase()}}/core/errors/errors.dart';
import 'package:{{name.snakeCase()}}/core/structs/usecase.dart';
import 'package:equatable/equatable.dart';

/// This usecase maps all common errors from 'core' module into user-readable error messages
/// It is capable of overriding default messages through the [ErrorMessageMapperParameters]
class MapErrorToMessage implements UseCase<String, ErrorMessageMapperParameters> {
  MapErrorToMessage();

  @override
  Future<String> call(ErrorMessageMapperParameters params) {
    final exception = params.error;

    getMessageByType() {
      if (exception is ServerError) {
        return params.serverErrorMessage ?? 'TODO:';
      }

      if (exception is BadConnectionError) {
        return params.badConnectivityErrorMessage ?? 'TODO:';
      }

      if (exception is CacheError) {
        return params.cacheErrorMessage ?? 'TODO:';
      }

      return params.unexpectedErrorMessage ?? 'TODO:';
    }

    return Future.value(getMessageByType());
  }
}

class ErrorMessageMapperParameters extends Equatable {
  final Exception error;
  final String? serverErrorMessage;
  final String? badConnectivityErrorMessage;
  final String? cacheErrorMessage;
  final String? unexpectedErrorMessage;

  const ErrorMessageMapperParameters({
    required this.error,
    this.serverErrorMessage,
    this.badConnectivityErrorMessage,
    this.cacheErrorMessage,
    this.unexpectedErrorMessage,
  });

  @override
  List<Object?> get props => [
        error,
        serverErrorMessage,
        badConnectivityErrorMessage,
        cacheErrorMessage,
        unexpectedErrorMessage,
      ];
}
