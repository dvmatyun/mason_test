/// Flutter-friendly validator for fields
/// Returns [null] when the field passes the validation
/// Returns error [String] on failure
abstract class Validator<T> {
  String? validate(T? field);
}
