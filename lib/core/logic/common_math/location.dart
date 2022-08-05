import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double latitude;
  final double longitude;

  const Location({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];

  @override
  String toString() {
    return '[$latitude,$longitude]';
  }

  Location operator +(Location b) => Location(latitude: latitude + b.latitude, longitude: longitude + b.longitude);
  Location operator -(Location b) => Location(latitude: latitude - b.latitude, longitude: longitude - b.longitude);
  Location operator *(double t) => Location(latitude: latitude * t, longitude: longitude * t);
}

extension LocationExtension on Location {
  static const double _locationTolerance = 0.0001;

  double findLocationDelta(Location other) {
    return (longitude - other.longitude).abs() + (latitude - other.latitude).abs();
  }

  bool isNear(Location other) {
    final diff = findLocationDelta(other);
    if (diff < _locationTolerance) {
      return true;
    }
    return false;
  }
}
