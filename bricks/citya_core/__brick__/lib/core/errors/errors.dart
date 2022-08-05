import 'package:dio/dio.dart';

part 'cache_errors.dart';
part 'network_errors.dart';

class UnexpectedError implements Exception {
  final String? message;
  final Object error;

  const UnexpectedError({required this.error, this.message});

  @override
  String toString() {
    return 'UnexpectedError of type ${error.runtimeType}: ${message ?? error.toString()}';
  }
}

class DataIntegrityError implements Exception {
  final String message;

  DataIntegrityError(this.message);

  @override
  String toString() {
    return 'DataIntegrityError: $message';
  }
}
