import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:flutter/material.dart';

/// Draggable line for expandable elements
class DragBar extends StatelessWidget {
  static const dragBarHeight = 5.0;

  final EdgeInsets padding;
  final GestureDragUpdateCallback? onDragVertically;
  final GestureDragEndCallback? onDragEnd;
  final VoidCallback? onTap;

  const DragBar({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.onDragVertically,
    this.onDragEnd,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightTotal = dragBarHeight + padding.top + padding.bottom;

    return GestureDetector(
      key: key,
      onVerticalDragUpdate: onDragVertically,
      onVerticalDragEnd: onDragEnd,
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: heightTotal,
        alignment: Alignment.center,
        child: Container(
          width: 73,
          height: dragBarHeight,
          padding: EdgeInsets.symmetric(vertical: (heightTotal - dragBarHeight) / 2),
          decoration: BoxDecoration(
            color: AppTheme.colors.divider,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
