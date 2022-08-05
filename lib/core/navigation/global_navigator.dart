import 'package:flutter/widgets.dart';

typedef RoutePredicate = bool Function(Route<dynamic>);

/// Gives the ability to use navigation api from flutter without [BuildContext]
/// Main purpose - use inside presentation layer (bloc) without passing context from UI
/// Singleton - always returns the same instance. Reference as `GlobalNavigator()`
class GlobalNavigator {
  static GlobalNavigator? _instance;

  factory GlobalNavigator({GlobalKey<NavigatorState>? key}) {
    _instance ??= GlobalNavigator._(key: key ?? GlobalKey<NavigatorState>());

    return _instance!;
  }

  GlobalNavigator._({required GlobalKey<NavigatorState> key}) : _navigationKey = key;

  final GlobalKey<NavigatorState> _navigationKey;

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  Future<T?> push<T extends Object?>(Route<T> route) async {
    return navigationKey.currentState?.push<T>(route);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Route<T> route, {
    RoutePredicate? predicate,
  }) async {
    return navigationKey.currentState?.pushAndRemoveUntil<T>(
      route,
      predicate ?? (_) => false,
    );
  }

  Future<bool?> maybePop<T extends Object?>([T? result]) async {
    return navigationKey.currentState?.maybePop<T>(result);
  }

  bool canPop() => navigationKey.currentState!.canPop();

  void goBack<T extends Object?>({T? result}) {
    navigationKey.currentState?.pop<T>(result);
  }

  void popUntil(String route) {
    navigationKey.currentState?.popUntil(ModalRoute.withName(route));
  }

  RouteSettings? pageSettings(BuildContext context) {
    return ModalRoute.of<RouteSettings>(context)?.settings;
  }
}
