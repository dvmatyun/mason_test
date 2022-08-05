// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapbox_trips.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapboxTrips _$MapboxTripsFromJson(Map<String, dynamic> json) => MapboxTrips(
      trips: (json['trips'] as List<dynamic>).map((e) => MapboxRoute.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$MapboxTripsToJson(MapboxTrips instance) => <String, dynamic>{
      'trips': instance.trips.map((e) => e.toJson()).toList(),
    };
