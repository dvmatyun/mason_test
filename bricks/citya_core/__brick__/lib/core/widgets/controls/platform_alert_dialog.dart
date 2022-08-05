import 'dart:io';

import 'package:{{name.snakeCase()}}/core/widgets/helpers/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Platform-aware dialog that uses default native platform appearance
/// can be shown by calling .show(context) method from instanced widget object
/// Example: ``` final result = await PlatformAlertDialog(..).show(context); ```
class PlatformAlertDialog extends PlatformWidget {
  const PlatformAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    this.cancelText,
    required this.confirmText,
  }) : super(key: key);

  final String title;
  final String content;
  final String? cancelText;
  final String confirmText;

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _actions(context, cancelText?.toUpperCase(), confirmText.toUpperCase()),
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _actions(context, cancelText, confirmText),
    );
  }

  List<Widget> _actions(BuildContext context, String? cancelText, String confirmText) {
    var actions = <Widget>[];
    if (cancelText != null) {
      actions.add(PlatformAlertDialogAction(
        child: Text(cancelText),
        onPressed: () => _dismiss(context, false),
      ));
    }
    actions.add(PlatformAlertDialogAction(
      child: Text(confirmText),
      onPressed: () => _dismiss(context, true),
    ));
    return actions;
  }

  Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: !Platform.isIOS,
      builder: (context) => this,
    );

    return result ?? false;
  }

  void _dismiss(BuildContext context, bool value) {
    Navigator.of(context, rootNavigator: true).pop(value);
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  const PlatformAlertDialogAction({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      onPressed: onPressed,
      child: child,
    );
  }
}
