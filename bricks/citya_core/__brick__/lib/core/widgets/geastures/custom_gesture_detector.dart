import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom gesture detector somehow doesn't ignore user taps over map
class CustomGestureDetector extends StatelessWidget {
  const CustomGestureDetector({
    required this.child,
    this.onPanDown,
    this.onPanUpdate,
    this.onPanEnd,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Function? onPanDown;
  final Function? onPanUpdate;
  final Function? onPanEnd;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        CustomPanGestureRecognizer: GestureRecognizerFactoryWithHandlers<CustomPanGestureRecognizer>(
          () => CustomPanGestureRecognizer(
            onPanDown: (e) {
              if (onPanDown != null) {
                onPanDown!(e);
              }
            },
            onPanUpdate: (e) {
              if (onPanUpdate != null) {
                onPanUpdate!(e);
              }
            },
            onPanEnd: (e) {
              if (onPanEnd != null) {
                onPanEnd!(e);
              }
            },
          ),
          (CustomPanGestureRecognizer instance) {},
        ),
      },
      child: child,
    );
  }
}

class CustomPanGestureRecognizer extends OneSequenceGestureRecognizer {
  final Function onPanDown;
  final Function onPanUpdate;
  final Function onPanEnd;

  CustomPanGestureRecognizer({
    required this.onPanDown,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  @override
  void addPointer(PointerEvent event) {
    onPanDown(event.position);
    startTrackingPointer(event.pointer);
    resolve(GestureDisposition.accepted);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      onPanUpdate(event.position);
    }
    if (event is PointerUpEvent) {
      onPanEnd(event.position);
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'customPan';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
