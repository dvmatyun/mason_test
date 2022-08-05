import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:flutter/material.dart';

/// Contains pre-defined configuration objects for common flutter widgets
/// Many widgets has certain config objects like Decorations, Borders, EdgeInsets erc.
/// To avoid duplicating among different widgets of the same type, here we define shared configs
class StyleConfiguration {
  StyleConfiguration._();

  static TextHeightBehavior get textHeightBehavior => const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      );

  static BorderRadius get interactiveBorderRadius => BorderRadius.circular(24.0);
  static BorderRadius get inputBorderRadius => BorderRadius.circular(4.0);

  static EdgeInsets get screenEdgePadding => const EdgeInsets.all(24);

  static ButtonStyle get textButtonStyle => ButtonStyle(
        textStyle: MaterialStateProperty.all(AppTheme.typography.smallBold),
        foregroundColor: MaterialStateProperty.all(AppTheme.colors.body),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(const Size(32, 32)),
        visualDensity: VisualDensity.comfortable,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
      );

  static ButtonStyle get outlinedButtonStyle => ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 0)),
        maximumSize: MaterialStateProperty.all(const Size(double.infinity, double.infinity)),
        side: MaterialStateProperty.all(BorderSide(color: AppTheme.colors.gradientStart)),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(36)))),
        visualDensity: VisualDensity.comfortable,
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 17)),
      );
}
