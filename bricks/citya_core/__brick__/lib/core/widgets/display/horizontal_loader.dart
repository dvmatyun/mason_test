import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:flutter/material.dart';

class HorizontalLoader extends StatelessWidget {
  const HorizontalLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        backgroundColor: AppTheme.colors.componentsFillColor,
        color: AppTheme.colors.componentsFillColor,
        valueColor: AlwaysStoppedAnimation(AppTheme.colors.focus),
        minHeight: 8.0,
      ),
    );
  }
}
