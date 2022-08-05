import 'package:{{name.snakeCase()}}/core/data/remote/mapbox/mapbox_directions_param.dart';
import 'package:{{name.snakeCase()}}/core/data/remote/mapbox_client.dart';

class MapboxRoutes {
  MapboxRoutes._();

  static const baseUrl = 'https://api.mapbox.com/';

  static const geocoding = '/geocoding/v5/mapbox.places/';
  static const mapStyle = '/styles/v1/cityamobility/ckzec94ex001q14m0r7refwzp/tiles/256/{z}/{x}/{y}@2x';
  static String mapUrlTemplate = "$baseUrl${mapStyle.substring(1)}?access_token=${MapboxClient.publicToken}";

  /// Mapbox:
  static String getMapboxDirections(MapboxDirectionsParam mbDirectionsParam) {
    final coordinatesStr = _getMapboxCoordinatesString(mbDirectionsParam);
    return '${baseUrl}directions/v5/mapbox/${mbDirectionsParam.profile.name}/$coordinatesStr?geometries=geojson&access_token=${MapboxClient.publicToken}';
  }

  static String getMapboxTrips(MapboxDirectionsParam mbDirectionsParam) {
    final coordinatesStr = _getMapboxCoordinatesString(mbDirectionsParam);
    return '${baseUrl}optimized-trips/v1/mapbox/${mbDirectionsParam.profile.name}/$coordinatesStr?source=first&destination=last&roundtrip=false&geometries=geojson&access_token=${MapboxClient.publicToken}';
  }

  static String _getMapboxCoordinatesString(MapboxDirectionsParam mbDirectionsParam) {
    final coordinatesSb = StringBuffer();
    bool isNotFirst = false;
    for (final coord in mbDirectionsParam.coordinates) {
      if (isNotFirst) {
        coordinatesSb.write(';');
      }
      coordinatesSb.write('${coord.longitude},${coord.latitude}');
      isNotFirst = true;
    }
    final coordinatesStr = coordinatesSb.toString();
    return coordinatesStr;
  }
}
