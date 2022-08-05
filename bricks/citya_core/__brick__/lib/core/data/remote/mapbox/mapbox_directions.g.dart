// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapbox_directions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapboxDirections _$MapboxDirectionsFromJson(Map<String, dynamic> json) => MapboxDirections(
      routes: (json['routes'] as List<dynamic>).map((e) => MapboxRoute.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$MapboxDirectionsToJson(MapboxDirections instance) => <String, dynamic>{
      'routes': instance.routes.map((e) => e.toJson()).toList(),
    };
