import 'package:equatable/equatable.dart';

/// Callable class to define single-responsibility functionality unit
abstract class UseCase<T, Params extends Equatable> {
  Future<T> call(Params params);
}

/// Placeholder for params type
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
