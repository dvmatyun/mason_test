import 'package:{{name.snakeCase()}}/core/logic/common_math/location.dart';
import 'package:equatable/equatable.dart';

/// Class representing highlighted polygon area on the map
class AreaInfo extends Equatable {
  final String areaName;
  final List<Location> points;
  final double width;

  const AreaInfo({required this.points, required this.areaName, this.width = 0.0});

  AreaInfo.named({
    required this.points,
    String? areaName,
    this.width = 0.0,
  }) : areaName = areaName ?? points.map((e) => e.longitude.toString() + e.latitude.toString()).join(';');

  @override
  List<Object?> get props => [areaName, points, width];
}
