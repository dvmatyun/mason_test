import 'package:flutter/material.dart';

class AnimationUtils {
  AnimationUtils._();

  static const Duration materialPageTransitionDuration = Duration(milliseconds: 300);
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  static Widget slideFromBottomTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final slideTween = Tween(begin: const Offset(0, 1), end: Offset.zero);
    final slideAnimation = animation.drive(slideTween.chain(CurveTween(curve: Curves.easeInOut)));

    return SlideTransition(
      position: slideAnimation,
      child: child,
    );
  }
}
