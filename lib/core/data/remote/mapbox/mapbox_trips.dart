import 'package:flutter_mason/core/data/remote/mapbox/mapbox_route.dart';
import 'package:flutter_mason/core/logic/common_math/location.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapbox_trips.g.dart';

@JsonSerializable(explicitToJson: true)
class MapboxTrips extends Equatable {
  final List<MapboxRoute> trips;

  const MapboxTrips({required this.trips});

  factory MapboxTrips.fromJson(Map<String, dynamic> json) => _$MapboxTripsFromJson(json);

  Map<String, dynamic> toJson() => _$MapboxTripsToJson(this);

  @override
  List<Object?> get props => [trips];
}

extension MapboxTripsExtension on MapboxTrips {
  List<Location> getFirstRoutePoints() {
    if (trips.isEmpty) {
      return <Location>[];
    }

    return trips[0]
        .coordinates
        .map((e) => Location(
              latitude: e[1],
              longitude: e[0],
            ))
        .toList(growable: false);
  }
}
