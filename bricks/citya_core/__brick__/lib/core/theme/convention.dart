import 'dart:ui';

import 'theme.dart';

enum FontSize {
  small(11),
  normal(13),
  medium(16),
  big(20),
  h1(48),
  h2(24);

  final double _size;

  double get size => _size * AppTheme.fontScaleFactor;

  const FontSize(this._size);
}

enum FontColor {
  body(AppColor.body),
  backgrounded(AppColor.background),
  error(AppColor.negativeDark),
  cta(AppColor.primaryActive),
  weak(AppColor.outline),
  accent(AppColor.accentDark);

  final AppColor _appColor;

  Color get color => _appColor.color;

  const FontColor(this._appColor);
}

enum AppColor {
  primaryActive,
  primaryInactive,
  accent,
  accentDark,
  negative,
  negativeDark,
  negativeLight,
  outline,
  body,
  background;

  Color get color => AppTheme.palette.pick(this);
}
