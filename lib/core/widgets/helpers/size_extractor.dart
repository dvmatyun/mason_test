library core_widget_size_extractor;

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

typedef OnWidgetSizeChange = void Function(Size size);

/// This widget measures child's [Size] and passing it to [onChange] callback
class SizeExtractor extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const SizeExtractor({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  SizeExtractorState createState() => SizeExtractorState();
}

class SizeExtractorState extends State<SizeExtractor> {
  final widgetKey = GlobalKey();
  Size? oldSize;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(_postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  void _postFrameCallback(Duration timeStamp) {
    final context = widgetKey.currentContext;
    final box = context?.findRenderObject() as RenderBox;
    if (!box.hasSize) return;

    final newSize = box.size;
    if (newSize != oldSize) {
      oldSize = newSize;
      widget.onChange(newSize);
    }
  }
}
