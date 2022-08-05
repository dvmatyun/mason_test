import 'package:flutter/cupertino.dart';

import 'convention.dart';
import 'theme.dart';

/// App's font configurations
/// use "${size}${fontWeight}${colorAlteration}${otherModifiers}" pattern for naming
/// [size] describes size variation following the convention of [FontSize]
/// [fontWeight] naming is described here https://docs.microsoft.com/en-us/typography/opentype/spec/os2#usweightclass
/// may be omitted if regular [FontWeight.normal] used
/// [colorAlteration] stands for color variants that differs depending on background or UI role, [FontColor]
/// 'Secondary' at the end marks the use of secondary fontFamily from theme
class AppTextStyles {
  // ~*~ normal size variations ~*~
  TextStyle get normal => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.normal,
        color: FontColor.body.color,
        fontSize: FontSize.normal.size,
        height: 17 / 13,
        decoration: TextDecoration.none,
        letterSpacing: 0.5,
      );

  TextStyle get normalBold => normal.copyWith(fontWeight: FontWeight.w700);

  TextStyle get normalBoldCta => normalBold.copyWith(color: FontColor.cta.color);

  TextStyle get normalBoldBackgrounded => normalBold.copyWith(color: FontColor.backgrounded.color);

  TextStyle get normalLight => normal.copyWith(fontWeight: FontWeight.w300);

  TextStyle get normalLightNegative => normalLight.copyWith(color: FontColor.error.color);

  TextStyle get normalLightCta => normalLight.copyWith(color: FontColor.cta.color);

  TextStyle get normalLightLinkUnderlined => normalLight.copyWith(
        decoration: TextDecoration.underline,
        color: FontColor.cta.color,
      );

  // ~*~ small size variations ~*~
  TextStyle get small => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.normal,
        color: FontColor.body.color,
        fontSize: FontSize.small.size,
        height: 16 / 11,
        decoration: TextDecoration.none,
      );

  TextStyle get smallBold => small.copyWith(fontWeight: FontWeight.w700);

  TextStyle get smallBoldBackgrounded => smallBold.copyWith(color: FontColor.backgrounded.color);

  TextStyle get smallSemibold => small.copyWith(fontWeight: FontWeight.w500);

  TextStyle get smallLight => small.copyWith(fontWeight: FontWeight.w300);

  TextStyle get smallLightNegative => smallLight.copyWith(color: FontColor.error.color);

  TextStyle get smallLightUnderlined => smallLight.copyWith(decoration: TextDecoration.underline);

  TextStyle get smallLightWeak => smallLight.copyWith(color: FontColor.weak.color);

  // ~*~ medium size variations ~*~
  TextStyle get medium => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.normal,
        color: FontColor.body.color,
        fontSize: FontSize.medium.size,
        height: 22 / 16,
        decoration: TextDecoration.none,
        letterSpacing: 0.5,
      );

  TextStyle get mediumBackgrounded => medium.copyWith(color: FontColor.backgrounded.color);

  TextStyle get mediumBold => medium.copyWith(fontWeight: FontWeight.w700);

  TextStyle get mediumBoldWeak => mediumBold.copyWith(color: FontColor.weak.color);

  TextStyle get mediumBoldAccent => mediumBold.copyWith(color: FontColor.accent.color);

  TextStyle get mediumBoldBackgrounded => mediumBackgrounded.copyWith(fontWeight: FontWeight.w700);

  TextStyle get mediumSecondary => medium.copyWith(fontFamily: AppTheme.secondaryFont.fontFamily);

  TextStyle get mediumLight => medium.copyWith(fontWeight: FontWeight.w300);

  TextStyle get mediumLightWeak => mediumLight.copyWith(color: FontColor.weak.color);

  // ~*~ big size variations ~*~
  TextStyle get big => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.normal,
        color: FontColor.body.color,
        fontSize: FontSize.big.size,
        height: 30 / 20,
        decoration: TextDecoration.none,
      );

  TextStyle get bigLight => big.copyWith(fontWeight: FontWeight.w300);

  TextStyle get bigBold => big.copyWith(fontWeight: FontWeight.w700);

  TextStyle get bigBoldSecondary => big.copyWith(
        fontWeight: FontWeight.w700,
        fontFamily: AppTheme.secondaryFont.fontFamily,
      );

  TextStyle get bigBoldBackgroundedSecondary => bigBoldSecondary.copyWith(color: FontColor.backgrounded.color);

  // ~*~ h2 size variations ~*~
  TextStyle get h2 => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.normal,
        color: FontColor.body.color,
        fontSize: FontSize.h2.size,
        height: 1,
        decoration: TextDecoration.none,
      );

  TextStyle get h2Bold => h2.copyWith(fontWeight: FontWeight.w700);

  TextStyle get h2BoldUnderlined => h2Bold.copyWith(decoration: TextDecoration.underline);

  TextStyle get h2Light => h2.copyWith(fontWeight: FontWeight.w300);

  // ~*~ h1 size variations ~*~
  TextStyle get h1 => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.normal,
        color: FontColor.body.color,
        fontSize: FontSize.h1.size,
        height: 1,
        decoration: TextDecoration.none,
      );

  TextStyle get h1LightCta => h1.copyWith(fontWeight: FontWeight.w300, color: FontColor.cta.color);
}
