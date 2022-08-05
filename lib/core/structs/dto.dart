/// Dto stands for 'data transfer object'
/// serves the purpose of keeping single value stored
abstract class Dto<T> {
  Future save(T? value);

  Future<T?> get();
}
