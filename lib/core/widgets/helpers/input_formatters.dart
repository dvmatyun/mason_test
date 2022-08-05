import 'dart:math';

import 'package:flutter_mason/core/validation/regexp.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class InputFormatters {
  InputFormatters._();

  static TextInputFormatter getPhoneFormatter() {
    return MaskedInputFormatter('000 000 000');
  }

  static TextInputFormatter getNumbersFormatter() {
    return FilteringTextInputFormatter.deny(RegExpPatterns.nonDigitsRegExp);
  }
}

extension FormatExtension on TextInputFormatter {
  String format(String text) {
    return formatAsValue(text).text;
  }

  TextEditingValue formatAsValue(String text, [TextEditingValue oldValue = const TextEditingValue()]) {
    final reverseSelection = oldValue.text.length - max(0, oldValue.selection.end);
    final selection = (text.length - reverseSelection).clamp(0, text.length).floor();

    return formatEditUpdate(
      oldValue,
      TextEditingValue(
        text: text,
        selection: TextSelection(
          baseOffset: selection,
          extentOffset: selection,
        ),
      ),
    );
  }
}
