import 'dart:math';

import 'package:{{name.snakeCase()}}/core/theme/theme.dart';
import 'package:{{name.snakeCase()}}/core/widgets/controls/round_button.dart';
import 'package:{{name.snakeCase()}}/core/widgets/helpers/styling_configurations.dart';
import 'package:flutter/material.dart';

class CountSelector extends StatefulWidget {
  final int maxAmount;
  final int minAmount;
  final int step;
  final ValueChanged<int> onChanged;

  const CountSelector({
    Key? key,
    required this.maxAmount,
    required this.onChanged,
    this.minAmount = 1,
    this.step = 1,
  }) : super(key: key);

  @override
  CountSelectorState createState() => CountSelectorState();
}

class CountSelectorState extends State<CountSelector> {
  late int _selected;

  @override
  void initState() {
    _selected = widget.minAmount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            RoundButton(
              size: 44,
              onPressed: _decrease,
              backgroundColor: AppTheme.colors.buttonWeak,
              disabled: _selected == widget.minAmount,
              elevation: 0,
              child: Text(
                '–',
                textHeightBehavior: StyleConfiguration.textHeightBehavior,
                style: AppTheme.typography.h2Bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                _selected.toString(),
                style: AppTheme.typography.h2Bold,
                textHeightBehavior: StyleConfiguration.textHeightBehavior,
              ),
            ),
            RoundButton(
              size: 44,
              onPressed: _increase,
              backgroundColor: AppTheme.colors.buttonWeak,
              disabled: _selected == widget.maxAmount,
              elevation: 0,
              child: Text(
                '+',
                textHeightBehavior: StyleConfiguration.textHeightBehavior,
                style: AppTheme.typography.h2Bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _increase() {
    final newValue = min(widget.maxAmount, _selected + widget.step);
    setState(() {
      _selected = newValue;
    });
    widget.onChanged(newValue);
  }

  void _decrease() {
    final newValue = max(widget.minAmount, _selected - widget.step);
    setState(() {
      _selected = newValue;
    });
    widget.onChanged(newValue);
  }
}
