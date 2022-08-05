import 'dart:async';

import 'package:{{name.snakeCase()}}/core/controllers/listenable/event_controller.dart';
import 'package:{{name.snakeCase()}}/core/data/device/device_permissions.dart';
import 'package:{{name.snakeCase()}}/core/logic/common_math/location.dart';
import 'package:location/location.dart' as location_service;

abstract class LocationDataSource {
  EventController<Location> get locationController;

  Future<Location> getCurrentLocation();
}

class LocationDataSourceImpl implements LocationDataSource {
  static const locationRequestInterval = 700;

  final EventController<Location> _controller;
  final location_service.Location _locationService;
  final DevicePermissions _devicePermissions;

  StreamSubscription? locationSub;
  bool _isInitialized = false;

  LocationDataSourceImpl({
    EventController<Location>? locationController,
    location_service.Location? locationService,
    DevicePermissions? devicePermissions,
  })  : _controller = locationController ?? EventController(notifyOnNewListener: true),
        _locationService = locationService ?? location_service.Location(),
        _devicePermissions = devicePermissions ?? DevicePermissionsImpl();

  Future<bool> _checkPermissionsAndInit() async {
    if (_isInitialized) {
      return true;
    }
    final enabled = await _locationService.serviceEnabled();
    final hasPermission = await _devicePermissions.isLocationPermissionGranted();
    if (!(hasPermission || enabled)) {
      throw Exception('Unable to get current location, hasPermission: $hasPermission, locationEnabled: $enabled');
    }
    if (!_isInitialized) {
      _isInitialized = true;
      await locationSub?.cancel();
      await _locationService.changeSettings(
          accuracy: location_service.LocationAccuracy.high, interval: locationRequestInterval);
      locationSub = _locationService.onLocationChanged.listen(_onLocationReceived);
    }
    return true;
  }

  @override
  Future<Location> getCurrentLocation() async {
    await _checkPermissionsAndInit();

    /// Location services on IOS have a strange bug of retrieving location FOREVER on first attempt
    /// It works better when given extra attempts, so we try this before referring controller for the result
    location_service.LocationData? locationData;
    for (var attempts = 0; attempts < 5; attempts++) {
      locationData = await Future.any<location_service.LocationData?>([
        _locationService.getLocation(),
        Future.delayed(const Duration(milliseconds: locationRequestInterval)), // prevents from waiting forever
      ]);
      if (locationData != null) {
        _onLocationReceived(locationData);
        break;
      }
    }

    if (locationData == null && _controller.lastValue == null) {
      throw Exception('Unable to get current location');
    }

    return _controller.lastValue!;
  }

  @override
  EventController<Location> get locationController => _controller;

  void _onLocationReceived(location_service.LocationData locationData) {
    if (locationData.latitude == null || locationData.longitude == null) return;
    final location = Location(latitude: locationData.latitude!, longitude: locationData.longitude!);
    _controller.addEvent(location);
  }
}
