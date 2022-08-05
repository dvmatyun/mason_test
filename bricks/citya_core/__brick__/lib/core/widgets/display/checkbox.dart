import 'package:{{name.snakeCase()}}/app/resources/svg_assets.dart';
import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:{{name.snakeCase()}}/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class OkCheckbox extends StatelessWidget {
  final bool isChecked;

  const OkCheckbox({required this.isChecked, super.key});

  @override
  Widget build(BuildContext context) {
    if (isChecked) {
      return Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppTheme.colors.backgroundAccent,
        ),
        child: Center(
          child: SvgImage(
            SvgAsset.okSign,
            color: AppTheme.colors.backgroundMain,
            height: 13,
          ),
        ),
      );
    }
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.colors.backgroundAccent, width: 2),
      ),
    );
  }
}
