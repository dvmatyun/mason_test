import 'dart:ui';

import 'package:flutter/material.dart';

import '../convention.dart';
import 'color_palette.dart';

class LightPalette extends ColorPalette {
  @override
  Map<AppColor, Color> get paletteColors => const {
        AppColor.primaryActive: Color(0xff606DE6),
        AppColor.primaryInactive: Color(0xFFE9EBFC),
        AppColor.accent: Color(0xffFFF0C5),
        AppColor.accentDark: Color(0xff9E5F00),
        AppColor.negative: Color(0xffD03160),
        AppColor.negativeDark: Color(0xff9C2548),
        AppColor.negativeLight: Color(0xffFAEAEF),
        AppColor.body: Color(0xff000000),
        AppColor.outline: Color(0xff616B70),
        AppColor.background: Color(0xffFFFFFF),
      };

  @override
  Palette get type => Palette.light;
}
