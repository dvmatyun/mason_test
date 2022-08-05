import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:{{name.snakeCase()}}/core/widgets/helpers/styling_configurations.dart';
import 'package:flutter/cupertino.dart';

class BasicButton extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final Color? color;
  final Widget? prefixChild;
  final Widget? postfixChild;
  final Function? onPressed;
  final bool disabled;
  final bool roundBorders;

  const BasicButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.textStyle,
    this.color,
    this.postfixChild,
    this.prefixChild,
    this.disabled = false,
    this.roundBorders = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: (color ?? AppTheme.colors.activeButtonStrong).withOpacity(disabled ? 0.2 : 1),
      borderRadius: roundBorders ? StyleConfiguration.interactiveBorderRadius : BorderRadius.zero,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      onPressed: () async {
        if (disabled || onPressed == null) return;
        var focusScope = FocusScope.of(context);

        if (focusScope.hasFocus) {
          focusScope.unfocus();
          await Future.delayed(const Duration(milliseconds: 100));
        }

        onPressed!.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefixChild != null) prefixChild!,
          Flexible(
            child: Text(
              text ?? '',
              maxLines: 1,
              softWrap: false,
              textHeightBehavior: StyleConfiguration.textHeightBehavior,
              style: textStyle ?? AppTheme.typography.mediumBackgrounded,
            ),
          ),
          if (postfixChild != null) postfixChild!,
        ],
      ),
    );
  }
}
