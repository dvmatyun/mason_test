import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Allows to pass gestures between  [Stack] widgets
class TransparentPointer extends SingleChildRenderObjectWidget {
  const TransparentPointer({
    Key? key,
    this.transparent = true,
    this.opaqueHeightOffset,
    Widget? child,
  }) : super(key: key, child: child);

  final bool transparent;

  /// dy position below which gestures will hit the test regardless of transparency
  final double? opaqueHeightOffset;

  @override
  RenderTransparentPointer createRenderObject(BuildContext context) {
    return RenderTransparentPointer(transparent: transparent, opaqueHeightOffset: opaqueHeightOffset);
  }

  @override
  void updateRenderObject(BuildContext context, RenderTransparentPointer renderObject) {
    renderObject.transparent = transparent;
    renderObject.opaqueHeightOffset = opaqueHeightOffset;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<bool>('transparent', transparent));
    properties.add(DiagnosticsProperty<double?>('opaqueHeightOffset', opaqueHeightOffset));
    super.debugFillProperties(properties);
  }
}

class RenderTransparentPointer extends RenderProxyBox {
  RenderTransparentPointer({
    RenderBox? child,
    bool transparent = true,
    double? opaqueHeightOffset,
  })  : _transparent = transparent,
        _opaqueHeightOffset = opaqueHeightOffset,
        super(child);

  bool get transparent => _transparent;
  double? get opaqueHeightOffset => _opaqueHeightOffset;
  bool _transparent;
  double? _opaqueHeightOffset;

  set transparent(bool value) {
    if (value == _transparent) return;
    _transparent = value;
  }

  set opaqueHeightOffset(double? value) {
    if (value == _opaqueHeightOffset) return;
    _opaqueHeightOffset = value;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    // forward hits to our child:
    final hit = super.hitTest(result, position: position);
    final isInOpaqueArea = _opaqueHeightOffset != null && position.dy > _opaqueHeightOffset!;
    // but report to our parent that we are hit when either `transparent` is false or we hit an opaque area
    return hit && (!transparent || isInOpaqueArea);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<bool>('transparent', transparent));
    properties.add(DiagnosticsProperty<double?>('opaqueHeightOffset', opaqueHeightOffset));
    super.debugFillProperties(properties);
  }
}
