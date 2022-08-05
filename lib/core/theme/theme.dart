import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'palettes/color_palette.dart';
import 'palettes/light.dart';
import 'typografy.dart';

/// Access point for all styling parameters
/// Connects together all theme parts - text styles, sizes and colors
/// Doesn't need a [BuildContext] to work, but must be listened to to reflect changes of the theme in the UI
/// Basically, a singleton object. For easier access of instance, it uses static methods
class AppTheme extends ChangeNotifier {
  /// screen width that is suggested by design layouts
  static const double _designSketchWidth = 375.0;

  static final AppTheme _instance = AppTheme._();

  factory AppTheme() => _instance;

  AppTheme._() {
    _palette = LightPalette();
    _typography = AppTextStyles();
  }

  late ColorPalette _palette;
  late AppTextStyles _typography;

  /// Public access to theme components
  static ColorPalette get palette => _instance._palette;

  static AppTextStyles get typography => _instance._typography;

  static AppColors get colors => AppColors(palette: palette);

  static TextStyle baseFont = const TextStyle(fontFamily: '.SF Pro Text');
  static TextStyle secondaryFont = const TextStyle(fontFamily: 'Poppins');
  static double fontScaleFactor = 1.0;

  void changePalette(Palette palette) {
    switch (palette) {
      case Palette.light:
        _palette = LightPalette();
        break;
    }
    notifyListeners();
  }

  /// adjust font scale factor depending on how device screen width relates to design layout
  /// helps to keep size proportions
  void adjustFontScaleFactorToFitScreen(double screenWidth) {
    fontScaleFactor = (screenWidth / _designSketchWidth).clamp(0.75, 1.25);
    notifyListeners();
  }
}
