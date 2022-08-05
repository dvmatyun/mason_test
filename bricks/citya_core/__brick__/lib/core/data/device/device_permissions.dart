import 'package:permission_handler/permission_handler.dart';

abstract class DevicePermissions {
  Future<bool> isLocationPermissionGranted();
  Future<bool> requestLocationPermission();
}

class DevicePermissionsImpl implements DevicePermissions {
  @override
  Future<bool> isLocationPermissionGranted() {
    return Permission.locationWhenInUse.isGranted;
  }

  @override
  Future<bool> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status == PermissionStatus.granted;
  }
}
