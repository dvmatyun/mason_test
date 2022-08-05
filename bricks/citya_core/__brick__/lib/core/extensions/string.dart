import 'package:{{name.snakeCase()}}/core/validation/regexp.dart';

extension StringUtils on String {
  String removeAllExceptNumbers() {
    return replaceAll(RegExpPatterns.nonDigitsRegExp, '');
  }

  String capitalizeFirst() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${length > 1 ? substring(1) : ''}";
  }
}
