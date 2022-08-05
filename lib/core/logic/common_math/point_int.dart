import 'package:flutter_mason/core/logic/common_math/location.dart';
import 'package:equatable/equatable.dart';

class PointInt extends Equatable {
  final int x;
  final int y;

  const PointInt(this.x, this.y);

  /// 2^19 for 1 meter location precision:
  static const shiftNumber = (524288 / 4);

  PointInt.fromLocation(Location loc)
      : x = (loc.longitude * shiftNumber).toInt(),
        y = (loc.latitude * shiftNumber).toInt();

  Location toLocation() => Location(
        longitude: x.toDouble() / shiftNumber,
        latitude: y.toDouble() / shiftNumber,
      );

  @override
  List<Object?> get props => [x, y];
}
