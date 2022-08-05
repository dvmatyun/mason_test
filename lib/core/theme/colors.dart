import 'package:flutter/material.dart';

import 'convention.dart';
import 'palettes/color_palette.dart';

/// semantically separated colors that are referencing [AppPalette] as the source for colors
/// used directly inside the widgets
class AppColors {
  final ColorPalette palette;

  AppColors({required this.palette});

  // ~*~ single colors ~*~
  Color get backgroundMain => palette.pick(AppColor.background);

  Color get backgroundShadowed => const Color(0xffFAFAFA);

  Color get backgroundInverted => palette.pick(AppColor.body);

  Color get backgroundModal => palette.pick(AppColor.body).withOpacity(0.8);

  Color get backgroundAccent => palette.pick(AppColor.primaryActive);

  Color get body => palette.pick(AppColor.body);

  Color get transparent => const Color(0x00ffffff);

  Color get shadow => backgroundInverted.withOpacity(0.25);

  Color get divider => backgroundInverted.withOpacity(0.15);

  Color get backgroundTransparent => backgroundMain.withOpacity(0.9);

  // ~*~ Semantic colors ~*~
  Color get statusActive => palette.pick(AppColor.primaryActive);

  Color get statusInProgress => palette.pick(AppColor.accent);

  Color get statusDisabled => palette.pick(AppColor.outline);

  Color get statusError => palette.pick(AppColor.negativeLight);

  Color get activeButtonStrong => palette.pick(AppColor.primaryActive);

  Color get inactiveButtonStrong => palette.pick(AppColor.primaryInactive);

  Color get buttonWeak => const Color(0xffEFEFEF);

  Color get borderOutline => palette.pick(AppColor.outline);

  Color get componentsFillColor => palette.pick(AppColor.primaryInactive);

  Color get componentsFillColorDarker => palette.pick(AppColor.outline);

  Color get focus => palette.pick(AppColor.primaryActive);

  Color get negative => palette.pick(AppColor.negative);

  Color get gradientStart => const Color(0xff41AFC9);

  Color get gradientEnd => palette.pick(AppColor.primaryActive);

  /// Unique colors that do not have representative in the palette
  Color get dropOffBadgeBackground => const Color(0xffF6F3E4);

  Color get dropOffBadgeText => const Color(0xff7D6F21);
}
