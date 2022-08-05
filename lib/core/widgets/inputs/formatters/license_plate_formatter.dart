import 'package:flutter_mason/core/validation/regexp.dart';
import 'package:flutter/services.dart';

class LicensePlateInputFormatter extends TextInputFormatter {
  static const licensePlateLength = 10;

  final TextInputFormatter _filteringFormatter = FilteringTextInputFormatter.allow(RegExpPatterns.licensePlateRegExp);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var uppercaseTextNew = newValue.text.toUpperCase();
    if (uppercaseTextNew.length > licensePlateLength) {
      return oldValue;
    }

    final updatedEditingValue = TextEditingValue(text: uppercaseTextNew, selection: newValue.selection);
    final filteredEditingValue = _filteringFormatter.formatEditUpdate(oldValue, updatedEditingValue);
    return filteredEditingValue;
  }
}
