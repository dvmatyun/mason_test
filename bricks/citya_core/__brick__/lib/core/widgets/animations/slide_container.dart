import 'package:flutter/material.dart';

/// Runs the slide animation whenever [slide] parameter is changed
/// animation starts from [initialPosition] and goes towards [slideDirection] when [slide] switched to true
class ToggleableSlide extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final AnimationStatusListener? onStatusChanged;
  final Offset slideDirection;
  final Offset initialPosition;

  /// animation goes forward when changed to [true] and backward when [false]
  final bool slide;

  const ToggleableSlide({
    Key? key,
    this.duration = const Duration(milliseconds: 300),
    this.initialPosition = Offset.zero,
    this.onStatusChanged,
    required this.child,
    required this.slideDirection,
    required this.slide,
  }) : super(key: key);

  @override
  ToggleableSlideState createState() => ToggleableSlideState();
}

class ToggleableSlideState extends State<ToggleableSlide> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.addStatusListener(_onStatusChanged);
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ToggleableSlide oldWidget) {
    if (widget.slide != oldWidget.slide) {
      widget.slide ? _controller.forward() : _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  Animation<Offset> get _position =>
      Tween<Offset>(begin: widget.initialPosition, end: widget.slideDirection).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _position,
      child: widget.child,
    );
  }

  void _onStatusChanged(AnimationStatus status) {
    widget.onStatusChanged?.call(status);
  }
}
