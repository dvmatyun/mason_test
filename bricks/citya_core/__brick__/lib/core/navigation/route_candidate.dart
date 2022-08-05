import 'package:flutter/widgets.dart';

/// Defines an option to compete for navigation on to its route
/// used by [RoutePicker]
/// [needsRoute] detects if routing is necessary
/// if true, then [getRoute] will be proclaimed as the winner route
abstract class RouteCandidate {
  Future<bool> needsRoute();
  Future<PageRoute> getRoute();
}
