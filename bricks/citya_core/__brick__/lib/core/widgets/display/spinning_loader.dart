import 'package:{{name.snakeCase()}}/app/resources/svg_assets.dart';
import 'package:{{name.snakeCase()}}/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class SpinningLoader extends StatefulWidget {
  const SpinningLoader({Key? key}) : super(key: key);

  @override
  SpinningLoaderState createState() => SpinningLoaderState();
}

class SpinningLoaderState extends State<SpinningLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  Animation<double> get rotateAnimation => _controller.view;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RotationTransition(
          turns: rotateAnimation,
          child: child,
        );
      },
      child: const SvgImage(SvgAsset.loader),
    );
  }
}
