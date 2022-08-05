import 'package:{{name.snakeCase()}}/core/data/remote/mapbox/mapbox_profile.dart';
import 'package:{{name.snakeCase()}}/core/logic/common_math/location.dart';

class MapboxDirectionsParam {
  final List<Location> coordinates;
  final MapboxProfile profile;

  const MapboxDirectionsParam({
    required this.profile,
    required this.coordinates,
  });
}
