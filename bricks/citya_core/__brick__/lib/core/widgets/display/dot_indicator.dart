import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.count,
    required this.active,
  }) : super(key: key);

  final int count;

  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int index = 0; index < count; index++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: AnimatedContainer(
              key: ValueKey(index),
              duration: const Duration(
                milliseconds: 200,
              ),
              margin: index != active ? const EdgeInsets.all(2.0) : EdgeInsets.zero,
              height: index == active ? 10.0 : 8.0,
              width: index == active ? 10.0 : 8.0,
              decoration: BoxDecoration(
                color: index == active ? AppTheme.colors.backgroundAccent : AppTheme.colors.statusDisabled,
                borderRadius: BorderRadius.all(Radius.circular(index == active ? 5 : 4)),
              ),
            ),
          ),
      ],
    );
  }
}
