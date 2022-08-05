import 'package:{{name.snakeCase()}}/core/data/remote/mapbox/mapbox_route.dart';
import 'package:{{name.snakeCase()}}/core/logic/common_math/location.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapbox_directions.g.dart';

@JsonSerializable(explicitToJson: true)
class MapboxDirections extends Equatable {
  final List<MapboxRoute> routes;

  const MapboxDirections({required this.routes});

  factory MapboxDirections.fromJson(Map<String, dynamic> json) => _$MapboxDirectionsFromJson(json);

  Map<String, dynamic> toJson() => _$MapboxDirectionsToJson(this);

  @override
  List<Object?> get props => [routes];
}

extension MapboxDirectionsExtension on MapboxDirections {
  List<Location> getFirstRoutePoints() {
    if (routes.isEmpty) {
      return <Location>[];
    }

    return routes[0]
        .coordinates
        .map((e) => Location(
              latitude: e[1],
              longitude: e[0],
            ))
        .toList(growable: false);
  }
}
