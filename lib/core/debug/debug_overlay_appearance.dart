import 'package:flutter/material.dart';

class DebugOverlayAppearance {
  static const defaultAppearance = DebugOverlayAppearance._constant(
    minimizedHeight: 35.0,
    minimizedWidth: 100.0,
    screenPosition: Alignment.bottomRight,
    backgroundColor: Colors.blue,
    shadow: BoxShadow(
      color: Colors.black26,
      blurRadius: 3.0,
      spreadRadius: 2.0,
    ),
    minimizedContent: Text(
      'DEBUG',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );

  const DebugOverlayAppearance._constant({
    required this.minimizedWidth,
    required this.minimizedHeight,
    required this.backgroundColor,
    required this.minimizedContent,
    required this.screenPosition,
    required this.shadow,
  });

  final double minimizedWidth;
  final double minimizedHeight;
  final Color backgroundColor;
  final Widget minimizedContent;
  final Alignment screenPosition;
  final BoxShadow shadow;

  DebugOverlayAppearance({
    double? minimizedWidth,
    double? minimizedHeight,
    Color? backgroundColor,
    Widget? minimizedContent,
    Alignment? screenPosition,
    BoxShadow? shadow,
  })  : minimizedWidth = minimizedWidth ?? defaultAppearance.minimizedWidth,
        minimizedHeight = minimizedHeight ?? defaultAppearance.minimizedHeight,
        backgroundColor = backgroundColor ?? defaultAppearance.backgroundColor,
        minimizedContent = minimizedContent ?? defaultAppearance.minimizedContent,
        shadow = shadow ?? defaultAppearance.shadow,
        screenPosition = screenPosition ?? defaultAppearance.screenPosition;
}
