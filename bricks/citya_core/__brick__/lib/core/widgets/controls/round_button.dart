import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:{{name.snakeCase()}}/core/widgets/animations/animation_utils.dart';
import 'package:{{name.snakeCase()}}/core/widgets/helpers/styling_configurations.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? size;
  final Color? backgroundColor;
  final bool disabled;
  final double elevation;
  final Widget child;

  const RoundButton({
    Key? key,
    this.onPressed,
    this.size,
    this.backgroundColor,
    this.disabled = false,
    this.elevation = 10,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        style: StyleConfiguration.textButtonStyle.copyWith(
          shape: MaterialStateProperty.all(const CircleBorder()),
          shadowColor: MaterialStateProperty.all(AppTheme.colors.shadow),
          backgroundColor: MaterialStateProperty.all(backgroundColor ?? AppTheme.colors.backgroundMain),
          elevation: MaterialStateProperty.all(elevation),
        ),
        child: AnimatedOpacity(
          duration: AnimationUtils.defaultAnimationDuration,
          opacity: disabled ? 0.3 : 1,
          child: child,
        ),
      ),
    );
  }
}
