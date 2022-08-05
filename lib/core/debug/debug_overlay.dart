import 'package:flutter_mason/core/widgets/controls/drag_bar.dart';
import 'package:flutter_mason/core/widgets/helpers/size_extractor.dart';
import 'package:flutter/material.dart';

import 'debug_overlay_appearance.dart';

/// Debug popup window with floating button to open it up
class DebugViewOverlay extends StatefulWidget {
  static const double dragBarHeight = 50.0;

  final Widget? childrenQuickAccess;
  final Widget? childBeneath;
  final DebugOverlayAppearance appearance;

  const DebugViewOverlay({
    Key? key,

    /// list of widgets that will be visible on debug menu opened
    this.childrenQuickAccess,

    /// widget that positioned under [childrenQuickAccess] and hidden under the scroll initially
    this.childBeneath,

    /// set of appearance configurations
    this.appearance = DebugOverlayAppearance.defaultAppearance,
  }) : super(key: key);

  @override
  DebugViewOverlayState createState() => DebugViewOverlayState();
}

class DebugViewOverlayState extends State<DebugViewOverlay> with SingleTickerProviderStateMixin {
  /// animation that opens or closes the debug window
  late AnimationController _appearAnimation;
  final Duration _appearAnimationDuration = const Duration(milliseconds: 500);

  /// percentage of animation that will be taken to cross-fade the size
  final double _sizeTransitionPart = 0.5;

  /// we need to pre-build overlay content just to be aware of it's size
  /// after we got [_overlayBaseHeight] we set this to [true]
  bool _hasBuiltOnce = false;
  bool _isInvisible = false;

  double _maxHeight = 0;
  double _overlayHeight = 0;
  double _overlayBaseHeight = 0;
  BuildContext? _mediaQueryContext;

  double get buttonHeight => widget.appearance.minimizedHeight;

  double get dragBarHeight => DebugViewOverlay.dragBarHeight;

  Animation<double> get _contentAppear => CurvedAnimation(
        parent: _appearAnimation,
        curve: Interval(1 - _sizeTransitionPart, 1),
      );

  Animation<double> get _contentBounce => Tween(begin: 0.93, end: 1.0).animate(
        CurvedAnimation(
          parent: _contentAppear,
          reverseCurve: Curves.easeInCirc,
          curve: Curves.easeInOutCirc,
        ),
      );

  @override
  void initState() {
    _appearAnimation = AnimationController(
      vsync: this,
      duration: _appearAnimationDuration,
    );

    /// reset overlay height on dismiss
    _appearAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _overlayHeight = _overlayBaseHeight;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _appearAnimation.stop();
    _appearAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// [WidgetsApp] needed just so we could have the access of [MediaQuery]
    return WidgetsApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      builder: (context, _) {
        _mediaQueryContext = context;
        final screenWidth = MediaQuery.of(context).size.width;

        if (_maxHeight == 0) {
          _maxHeight = MediaQuery.of(context).size.height - 75;
        }

        if (_overlayHeight == 0) _overlayHeight = _overlayBaseHeight;

        return Align(
          alignment: widget.appearance.screenPosition,
          child: Opacity(
            opacity: _isInvisible ? 0.1 : 1,
            child: AnimatedBuilder(
              animation: _appearAnimation,
              builder: (context, child) {
                /// we set size of overlay both manually and through the [AnimatedContainer]
                /// implicitly set animations are responsible for transition between open and closed states
                /// [AnimatedContainer] intended to handle dragging animation by using [_overlayHeight] and [_overlayBaseHeight]
                var widthAnimated =
                    Tween(begin: widget.appearance.minimizedWidth, end: screenWidth).animate(CurvedAnimation(
                  parent: _appearAnimation,
                  curve: Interval(0.0, _sizeTransitionPart),
                ));
                var heightAnimated = Tween(begin: buttonHeight, end: _overlayHeight).animate(
                  CurvedAnimation(
                    parent: _appearAnimation,
                    curve: Interval(0.0, _sizeTransitionPart),
                  ),
                );

                return AnimatedContainer(
                  key: const Key('debug_view_container'),
                  duration: _appearAnimationDuration,
                  curve: Curves.easeOutExpo,
                  alignment: Alignment.topCenter,
                  width: widthAnimated.value,
                  height: heightAnimated.value,
                  decoration: BoxDecoration(
                    color: widget.appearance.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: Radius.circular(10 * _appearAnimation.value),
                    ),
                    boxShadow: [widget.appearance.shadow],
                  ),
                  child: Stack(
                    children: [
                      _renderDebugButton(),
                      _renderOverlayContent(),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _renderDebugButton() {
    /// button disappear animation ends after [_sizeTransitionPart] when we had expanded the overlay to it's nominal size and no longer need the button
    /// after disappear animation is over, we no longer draw the button and replacing it with empty box
    if (_appearAnimation.value >= _sizeTransitionPart) {
      return const SizedBox();
    }

    Animation<double> buttonAnimation = CurvedAnimation(
      parent: _appearAnimation,
      curve: const Interval(0.0, 0.25),
    );

    return GestureDetector(
      key: const Key('debug_button_minimized'),
      onTap: () => _onVisibilityChange(true),
      onLongPress: _onMinimizedButtonLongPress,
      child: Opacity(
        opacity: 1 - buttonAnimation.value,
        child: Center(
          child: widget.appearance.minimizedContent,
        ),
      ),
    );
  }

  Widget _renderOverlayContent() {
    /// this avoids the rebuilding of content UI during the animation, while [_sizeTransitionPart] is not yet over
    /// or this widget simply is in minimized state
    /// need to pre-build content in order to get it's content size
    /// to make sure that it has been built before, we have [_hasBuiltOnce] flag
    if (_appearAnimation.value <= _sizeTransitionPart && _hasBuiltOnce) {
      return const SizedBox();
    }

    return Opacity(
      opacity: _contentAppear.value,
      child: ScaleTransition(
        scale: _contentBounce,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _renderDragBar(),
              Flexible(
                child: ListView(
                  padding: EdgeInsets.zero,
                  key: const Key('debug_overlay_content_list'),
                  shrinkWrap: true,
                  physics: _overlayHeight >= _maxHeight
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  children: [
                    _renderMeasurableAreaContent(),
                    _renderUnmeasurableAreaContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderDragBar() => SizedBox(
        height: dragBarHeight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// helps correctly align row items with [spaceBetween]
            Container(width: 30),
            Flexible(
              child: DragBar(
                key: const Key('debug_overlay_drag_bar'),
                onDragVertically: _onDragVertically,
                onDragEnd: _onDragEnd,
                onTap: _onDragBarTap,
              ),
            ),
            GestureDetector(
              child: Icon(
                Icons.close,
                size: 30,
                color: Colors.black54.withOpacity(0.7),
              ),
              onTap: () => _onVisibilityChange(false),
            ),
          ],
        ),
      );

  /// part of the content that initially visible when you expanding the UI
  Widget _renderMeasurableAreaContent() {
    return SizeExtractor(
      onChange: _onMeasurableAreaSizeChanged,
      child: widget.childrenQuickAccess ?? const SizedBox(),
    );
  }

  /// part of the content that is hidden under measurable area and needs to be scrolled to
  Widget _renderUnmeasurableAreaContent() {
    return Padding(
      padding: EdgeInsets.only(top: dragBarHeight),
      child: widget.childBeneath ?? const SizedBox(),
    );
  }

  void _onMinimizedButtonLongPress() {
    setState(() {
      _isInvisible = !_isInvisible;
    });
  }

  void _onVisibilityChange(bool isVisible) {
    if (_appearAnimation.isAnimating || _isInvisible) return;
    if (isVisible) {
      _appearAnimation.forward();
    } else {
      _appearAnimation.reverse();
    }
  }

  /// Triggered upon rebuilding content area
  void _onMeasurableAreaSizeChanged(Size s) {
    var excludedPaddings = dragBarHeight * 2;
    var potentialHeight = s.height + excludedPaddings;
    setState(() {
      if (!_hasBuiltOnce) {
        _hasBuiltOnce = true;
        _overlayBaseHeight = excludedPaddings;
        return;
      }

      if (potentialHeight != _overlayBaseHeight) {
        _overlayHeight = potentialHeight;
      }

      _overlayBaseHeight = potentialHeight;
    });
  }

  void _onDragVertically(DragUpdateDetails details) {
    var potentialHeight = _overlayHeight - (details.primaryDelta ?? 0);

    setState(() {
      _overlayHeight = potentialHeight.clamp(
        75.0,
        MediaQuery.of(_mediaQueryContext!).size.height,
      );
    });
  }

  void _onDragEnd(DragEndDetails details) {
    /// resets the size to it's [_overlayBaseHeight] after some delay
    if (_overlayHeight < _overlayBaseHeight) {
      Future.delayed(_appearAnimationDuration, () {
        setState(() {
          _overlayHeight = _overlayBaseHeight;
        });
      });
      _onVisibilityChange(false);
      return;
    }

    var potentialHeight = _overlayHeight - ((details.primaryVelocity ?? 0) / 40);

    setState(() {
      _overlayHeight = potentialHeight.clamp(
        _overlayBaseHeight,
        _maxHeight,
      );
    });
  }

  void _onDragBarTap() {
    if (_overlayHeight == _overlayBaseHeight) {
      _onVisibilityChange(false);
    }

    if (_overlayHeight > _overlayBaseHeight) {
      setState(() {
        _overlayHeight = _overlayBaseHeight;
      });
    }
  }
}
