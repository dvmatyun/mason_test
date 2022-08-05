import 'package:flutter_mason/core/data/device/device_permissions.dart';
import 'package:flutter_mason/core/structs/usecase.dart';
import 'package:equatable/equatable.dart';

class CheckLocationPermission implements UseCase<bool, CheckLocationPermissionParams> {
  final DevicePermissions _devicePermissions;

  CheckLocationPermission({required DevicePermissions devicePermissions}) : _devicePermissions = devicePermissions;

  @override
  Future<bool> call(CheckLocationPermissionParams params) async {
    final hasPermission = (params.shouldRequestIfMissing)
        ? await _devicePermissions.requestLocationPermission()
        : await _devicePermissions.isLocationPermissionGranted();
    return hasPermission;
  }
}

class CheckLocationPermissionParams extends Equatable {
  final bool shouldRequestIfMissing;

  const CheckLocationPermissionParams({required this.shouldRequestIfMissing});

  @override
  List<Object?> get props => [shouldRequestIfMissing];
}
