import 'package:{{name.snakeCase()}}/app/resources/svg_assets.dart';
import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:{{name.snakeCase()}}/core/widgets/helpers/styling_configurations.dart';
import 'package:{{name.snakeCase()}}/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class ListViewButton extends StatelessWidget {
  final SvgAsset svgIconAsset;
  final String title;
  final String? description;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  final bool showDivider;

  const ListViewButton({
    Key? key,
    required this.svgIconAsset,
    required this.title,
    this.description,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: StyleConfiguration.textButtonStyle.copyWith(
        padding: MaterialStateProperty.all(EdgeInsets.only(left: padding.left, right: padding.right)),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
            child: SvgImage(svgIconAsset, width: 17, color: AppTheme.colors.borderOutline),
          ),
          const SizedBox(width: 27),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.typography.normalLight,
                  ),
                  if (description != null)
                    Text(
                      description!,
                      style: AppTheme.typography.smallLight,
                    ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: padding.bottom - 1),
                    height: 1,
                    color: AppTheme.colors.divider,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
