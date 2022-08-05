import 'package:flutter/material.dart';

typedef NotifierBuilder<T extends ChangeNotifier> = Widget Function(BuildContext context, T notifier);

/// Wrapper around [ChangeNotifier] to rebuild dependent widget tree every time it changes
/// Serves as the alternative to the 'provider' package to avoid importing it
class ChangeNotifierBuilder<T extends ChangeNotifier> extends StatelessWidget {
  final T changeNotifier;
  final NotifierBuilder<T> builder;

  const ChangeNotifierBuilder({
    Key? key,
    required this.changeNotifier,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// It uses [AnimatedBuilder] since it is flutter's native way to listen [Listenable] classes
    return AnimatedBuilder(
      animation: changeNotifier,
      builder: (context, child) {
        return builder(context, changeNotifier);
      },
    );
  }
}

/// Can be used to stub notifier
class EmptyNotifier extends ChangeNotifier {}
