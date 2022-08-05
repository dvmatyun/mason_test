import 'package:flutter_mason/core/logic/common_math/line.dart';
import 'package:flutter_mason/core/logic/common_math/point_int.dart';
import 'package:flutter_mason/core/logic/common_math/area_info.dart';

class PolygonInt {
  final List<PointInt> polygonPoints;
  final AreaInfo sourceArea;

  PolygonInt(this.sourceArea)
      : polygonPoints = sourceArea.points.map((e) => PointInt.fromLocation(e)).toList(growable: false);

  /// Check if point is inside the polygon
  Future<bool> isPointInPolygon(PointInt userIntPoint) async {
    // Point can only be inside 3 or more points area:
    if (polygonPoints.length < 3) {
      return false;
    }

    final intersections = <PointInt>[];
    for (int i = 0; i < polygonPoints.length; i++) {
      int j = (i + 1) >= polygonPoints.length ? 0 : (i + 1);
      final line = Line(pointA: polygonPoints[i], pointB: polygonPoints[j]);

      final intersection = line.crossPointWithDiagonalRay(userIntPoint);

      if (intersection != null && !intersections.any((e) => e == intersection)) {
        //counting only intersections to one side (in this case - to the right):
        final dx = intersection.x - userIntPoint.x;
        if (dx > 0) {
          intersections.add(intersection);
        }
      }
      await Future.delayed(const Duration());
    }

    if (intersections.length % 2 == 1 && intersections.isNotEmpty) {
      return true;
    }

    return false;
  }
}
