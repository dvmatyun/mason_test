enum MapboxProfile {
  drivingTraffic('driving-traffic'), // driving-traffic
  driving('driving'), // driving
  walking('walking'), // walking
  cycling('cycling'); // cycling

  final String serviceName;
  const MapboxProfile(this.serviceName);
}
