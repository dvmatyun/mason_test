// ignore_for_file: overridden_fields

import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Put above Scaffold in the widget tree
/// Closes keyboard on tap outside of interactive areas (anywhere on the screen)
class FocusWatcher extends StatefulWidget {
  final Widget child;
  final double liftOffset;
  final Curve animationCurve;
  final Duration animationDuration;

  const FocusWatcher({
    Key? key,
    required this.child,
    this.liftOffset = 15.0,
    this.animationCurve = Curves.easeIn,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  FocusWatcherState createState() => FocusWatcherState();
}

class FocusWatcherState extends State<FocusWatcher> with SingleTickerProviderStateMixin {
  final Offset defaultOffset = const Offset(0, 0);
  double pageY = 0;
  double reverseFrom = 0;
  double textFieldBottom = 0.0;
  AnimationController? _controller;
  Animation<double>? _animation;
  RenderBox? lastRenderBox;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _animation = Tween(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: widget.animationCurve,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (c, w) {
        return Transform(
          transform: Matrix4.translationValues(
            0,
            _animation!.value,
            0,
          ),
          child: LayoutBuilder(builder: (BuildContext c, BoxConstraints viewportConstraints) {
            var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

            if (keyboardHeight > 0.0) {
              if (textFieldBottom > 0.0) {
                _moveScreen(textFieldBottom, keyboardHeight + widget.liftOffset, viewportConstraints.maxHeight);
                textFieldBottom = 0.0;
              }
            } else {
              if (pageY != 0.0) {
                _moveScreen(0, 0, 0);
                textFieldBottom = 0.0;
              }
            }
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: viewportConstraints.maxWidth,
                maxHeight: viewportConstraints.maxHeight,
              ),
              child: Listener(
                onPointerUp: (e) {
                  var rb = context.findRenderObject() as RenderBox;
                  var result = BoxHitTestResult();
                  rb.hitTest(result, position: e.position);

                  // if there any widget in the path that must ignore taps,
                  // stop it right here
                  if (result.path.any((entry) => entry.target.runtimeType == FocusWatcherIgnoreRenderBox)) {
                    return;
                  }
                  var isEditable = result.path.any((entry) =>
                      entry.target.runtimeType == RenderEditable ||
                      entry.target.runtimeType == RenderParagraph ||
                      entry.target.runtimeType == FocusWatcherForceRenderBox);

                  var currentFocus = FocusScope.of(context);
                  if (!isEditable) {
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                      lastRenderBox = null;
                    }
                  } else {
                    for (var entry in result.path) {
                      var isEditable = entry.target.runtimeType == RenderEditable ||
                          entry.target.runtimeType == RenderParagraph ||
                          entry.target.runtimeType == FocusWatcherForceRenderBox;

                      if (isEditable) {
                        var renderBox = (entry.target as RenderBox);
                        Offset offset = renderBox.localToGlobal(defaultOffset);
                        textFieldBottom = offset.dy + renderBox.size.height - pageY;
                        if (lastRenderBox != renderBox) {
                          setState(() {});
                          lastRenderBox = renderBox;
                        }
                      }
                    }
                  }
                },
                child: widget.child,
              ),
            );
          }),
        );
      },
    );
  }

  void _moveScreen(
    double textFieldBottom,
    double keyboardHeight,
    double screenHeight,
  ) {
    double newPageY = 0.0;

    if (keyboardHeight > 0.0) {
      newPageY = min(0, (screenHeight - textFieldBottom) - keyboardHeight);
      //print("DIST TO PASS ${newPageY}");
    }

    Future.delayed(const Duration(milliseconds: 15), () {
      setState(() {
        if (pageY != newPageY) {
          _animation = Tween(
            begin: pageY,
            end: newPageY,
          ).animate(
            CurvedAnimation(
              parent: _controller!,
              curve: widget.animationCurve,
            ),
          );
          _controller!.forward(
            from: 0,
          );
        }

        pageY = newPageY;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class IgnoreFocusWatcher extends SingleChildRenderObjectWidget {
  const IgnoreFocusWatcher({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  @override
  FocusWatcherIgnoreRenderBox createRenderObject(
    BuildContext context,
  ) {
    return FocusWatcherIgnoreRenderBox();
  }
}

// if you want to force focus on some widget, wrap it with this one
class ForceFocusWatcher extends SingleChildRenderObjectWidget {
  const ForceFocusWatcher({required Widget child, Key? key}) : super(child: child, key: key);

  @override
  FocusWatcherForceRenderBox createRenderObject(BuildContext context) {
    return FocusWatcherForceRenderBox();
  }
}

class FocusWatcherIgnoreRenderBox extends RenderPointerListener {}

class FocusWatcherForceRenderBox extends RenderPointerListener {}
