import 'package:{{name.snakeCase()}}/app/resources/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final SvgAsset svgAsset;
  final Color? color;
  final double? width;
  final double? height;

  const SvgImage(
    this.svgAsset, {
    Key? key,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgAsset.path,
      color: color,
      width: width,
      height: height,
    );
  }
}
