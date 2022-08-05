import 'package:flutter/widgets.dart';

import 'route_candidate.dart';
import 'routing_error.dart';

/// Decides which route should be navigated next
/// Takes a list of possible routes as a parameter (see [RouteCandidate])
/// Route candidates will be challenged in the order given by the list parameter
class RoutePicker {
  final List<RouteCandidate> _candidates;

  RouteCandidate? _lastTested;

  RoutePicker(this._candidates) : assert(_candidates.isNotEmpty, 'Route picker cannot have empty list of candidates');

  Future<PageRoute> getNextRoute() async {
    final canGetRoute = await canPickRoute();
    if (canGetRoute) {
      return await _lastTested!.getRoute();
    }

    throw RoutingError(_candidates.last.runtimeType.toString());
  }

  Future<bool> canPickRoute() async {
    final tasks = <Future<bool>>[];

    for (var candidate in _candidates) {
      final task = candidate.needsRoute();
      tasks.add(task);
    }

    for (int i = 0; i < tasks.length; i++) {
      final needsRoute = await tasks[i];
      _lastTested = _candidates[i];
      if (needsRoute) {
        return true;
      }
    }

    return false;
  }
}
