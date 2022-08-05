class RoutingError implements Exception {
  final String lastRouteCandidateDetails;

  RoutingError(this.lastRouteCandidateDetails);

  @override
  String toString() => 'RoutePicker failed to pick a route. Last candidate: $lastRouteCandidateDetails';
}
