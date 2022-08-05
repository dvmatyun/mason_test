import 'package:flutter_mason/core/theme/theme.dart';
import 'package:flutter/material.dart';

/// Draws a list with dashed line going through all list item marks
class MarkedProgressList extends StatefulWidget {
  final List<MarkedProgressListItem> items;
  final CrossAxisAlignment alignment;
  final double itemsSpacing;

  const MarkedProgressList({
    Key? key,
    required this.items,
    this.alignment = CrossAxisAlignment.start,
    this.itemsSpacing = 0,
  }) : super(key: key);

  @override
  State<MarkedProgressList> createState() => _MarkedProgressListState();
}

class _MarkedProgressListState extends State<MarkedProgressList> {
  late GlobalKey containerKey;
  late List<GlobalKey> itemKeys;

  @override
  void initState() {
    containerKey = GlobalKey();
    itemKeys = List.generate(widget.items.length, (_) => GlobalKey());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: containerKey,
      painter: MarkedListPainter(
        listMarkerItems: widget.items,
        listMarkerKeys: itemKeys,
        containerKey: containerKey,
      ),
      child: ListView.builder(
        itemCount: widget.items.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: index > 0 ? widget.itemsSpacing : 0),
            child: Row(
              crossAxisAlignment: widget.alignment,
              children: [
                SizedBox(
                  key: itemKeys[index],
                  child: widget.items[index].markerWidget,
                ),
                const SizedBox(width: 8),
                Flexible(child: widget.items[index].child),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MarkedProgressListItem {
  final Widget child;
  final Widget markerWidget;

  /// The visual appearance of the line that will connect current list item with the next one
  final ProgressLineType lineType;

  MarkedProgressListItem({
    required this.child,
    required this.markerWidget,
    this.lineType = ProgressLineType.dashed,
  });
}

enum ProgressLineType {
  dashed,
  bold,
}

/// Draws a dashed line through every [listMarkerKeys] inside the [containerKey]'s render box
class MarkedListPainter extends CustomPainter {
  final GlobalKey containerKey;
  final List<GlobalKey> listMarkerKeys;
  final List<MarkedProgressListItem> listMarkerItems;

  MarkedListPainter({
    required this.listMarkerKeys,
    required this.containerKey,
    required this.listMarkerItems,
  }) : assert(listMarkerKeys.length == listMarkerItems.length);

  Paint get dashPaint => Paint()
    ..color = AppTheme.colors.body
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  Paint get boldLinePaint => Paint()
    ..color = AppTheme.colors.body
    ..strokeWidth = 4
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    for (var index = 0; index < listMarkerKeys.length - 1; index++) {
      final lineType = listMarkerItems[index].lineType;

      final currentIndicatorOffset = _getIndicatorOffset(index);
      final currentIndicatorSize = _getIndicatorSize(index);
      final nextIndicatorOffset = _getIndicatorOffset(index + 1);
      final nextIndicatorSize = _getIndicatorSize(index + 1);

      final lineFrom = Offset(
        currentIndicatorOffset.dx + currentIndicatorSize.width / 2,
        currentIndicatorOffset.dy + currentIndicatorSize.height,
      );
      final lineTo = Offset(nextIndicatorOffset.dx + nextIndicatorSize.width / 2, nextIndicatorOffset.dy);
      final path = Path();

      switch (lineType) {
        case ProgressLineType.dashed:
          _addDashedLine(path, lineFrom, lineTo);
          canvas.drawPath(path, dashPaint);
          break;
        case ProgressLineType.bold:
          _addBoldLine(path, lineFrom, lineTo);
          canvas.drawPath(path, boldLinePaint);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void _addDashedLine(Path path, Offset from, Offset to) {
    const dashLength = 2.0, dashMargin = 4;
    final totalDistance = (to - from).distance;
    var passedDistance = 0.0;
    while (passedDistance < totalDistance) {
      final fromNew = Offset.lerp(from, to, passedDistance / totalDistance)!;
      passedDistance += dashLength;
      final toNew = Offset.lerp(from, to, passedDistance / totalDistance)!;
      path
        ..moveTo(fromNew.dx, fromNew.dy)
        ..lineTo(toNew.dx, toNew.dy);
      passedDistance += dashMargin;
    }
  }

  void _addBoldLine(Path path, Offset from, Offset to) {
    path
      ..moveTo(from.dx, from.dy)
      ..lineTo(to.dx, to.dy);
  }

  Offset _getIndicatorOffset(int indicatorIndex) {
    final container = containerKey.currentContext!.findRenderObject();
    final indicatorRenderBox = listMarkerKeys[indicatorIndex].currentContext!.findRenderObject() as RenderBox;
    final indicatorOffset = indicatorRenderBox.localToGlobal(Offset.zero, ancestor: container);
    return indicatorOffset;
  }

  Size _getIndicatorSize(int indicatorIndex) {
    final size = listMarkerKeys[indicatorIndex].currentContext!.size;
    return size!;
  }
}
