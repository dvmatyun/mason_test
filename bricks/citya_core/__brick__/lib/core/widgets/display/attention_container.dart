import 'package:{{name.snakeCase()}}/app/resources/svg_assets.dart';
import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:{{name.snakeCase()}}/core/widgets/animations/animation_utils.dart';
import 'package:{{name.snakeCase()}}/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class AttentionContainer extends StatelessWidget {
  const AttentionContainer({required this.text, this.isShown = true, Key? key}) : super(key: key);

  final bool isShown;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AnimationUtils.defaultAnimationDuration,
      curve: Curves.easeOut,
      height: isShown ? 83 : 0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(21, 0, 14, 0),
      color: AppTheme.colors.statusError,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              // to make exclamation mark white in the center
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 8,
                  height: 15,
                  color: Colors.white,
                ),
              ),
              const SvgImage(
                SvgAsset.attention,
                width: 30,
              ),
            ],
          ),
          const SizedBox(width: 21),
          Flexible(
            child: Text(
              textAlign: TextAlign.justify,
              softWrap: true,
              style: AppTheme.typography.normal,
              text,
            ),
          )
        ],
      ),
    );
  }
}
