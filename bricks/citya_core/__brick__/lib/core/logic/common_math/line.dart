import 'package:{{name.snakeCase()}}/core/logic/common_math/point_int.dart';

class Line {
  final PointInt pointA;
  final PointInt pointB;

  const Line({required this.pointA, required this.pointB});

  /// Method used to find if and where line is crossing the diagonal ray
  /// sourceRayPoint: source point of ray (Xr,Yr)
  /// ray is diagonal, so its equation is: y = x - Xr + Yr;
  PointInt? crossPointWithDiagonalRay(PointInt sourceRayPoint) {
    bool isParallel = ((pointA.x - pointB.x) == (pointA.y - pointB.y));
    if (isParallel) {
      return null;
    }

    final rp = sourceRayPoint;

    // Cross points:
    final divider = pointB.y - pointA.y - pointB.x + pointA.x;
    final x = ((rp.x - rp.y) * (pointA.x - pointB.x) + pointA.x * pointB.y - pointB.x * pointA.y) ~/ divider;
    final y = x - rp.x + rp.y;

    final xIsInBounds = (x >= pointA.x && x <= pointB.x) || (x >= pointB.x && x <= pointA.x);
    final yIsInBounds = (y >= pointA.y && y <= pointB.y) || (y >= pointB.y && y <= pointA.y);

    if (xIsInBounds && yIsInBounds) {
      return PointInt(x, y);
    }

    return null;
  }
}
