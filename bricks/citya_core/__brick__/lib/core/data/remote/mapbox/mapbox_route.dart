import 'package:{{name.snakeCase()}}/core/helpers/json_helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapbox_route.g.dart';

@JsonSerializable(explicitToJson: true)
class MapboxRoute extends Equatable {
  @JsonKey(name: 'geometry.coordinates', readValue: JsonHelpers.readNestedValue)
  final List<List<double>> coordinates;

  const MapboxRoute({required this.coordinates});

  factory MapboxRoute.fromJson(Map<String, dynamic> json) => _$MapboxRouteFromJson(json);

  Map<String, dynamic> toJson() => _$MapboxRouteToJson(this);

  @override
  List<Object?> get props => [coordinates];
}
