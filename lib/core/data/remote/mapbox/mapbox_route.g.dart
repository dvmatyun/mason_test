// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapbox_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapboxRoute _$MapboxRouteFromJson(Map<String, dynamic> json) => MapboxRoute(
      coordinates: (JsonHelpers.readNestedValue(json, 'geometry.coordinates') as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
    );

Map<String, dynamic> _$MapboxRouteToJson(MapboxRoute instance) => <String, dynamic>{
      'geometry.coordinates': instance.coordinates,
    };
