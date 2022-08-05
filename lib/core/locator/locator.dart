import 'package:flutter_mason/app/environment/app_type.dart';
import 'package:flutter_mason/app/environment/configuration.dart';
import 'package:flutter_mason/core/locator/core/registrant.dart';
import 'package:flutter_mason/core/locator/locator_registrant.dart';
import 'package:get_it/get_it.dart';

/// Dependency injection container reference
final locator = GetIt.instance;

/// Basically, the entry point of all app's dependencies
/// Here we inject all implementations of business logic abstractions
Future initLocator(AppConfiguration appConfiguration) async {
  locator.registerSingleton(appConfiguration);

  final registrants = appConfiguration.appType == AppType.passenger ? _passengerRegistrants : _driverRegistrants;

  for (var registrant in registrants) {
    await registrant.register();
  }
}

List<LocatorRegistrant> get _passengerRegistrants => [
      CoreLocatorRegistrant(),
    ];

List<LocatorRegistrant> get _driverRegistrants => [
      CoreLocatorRegistrant(),
    ];
