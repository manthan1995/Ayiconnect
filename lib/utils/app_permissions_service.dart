import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class AppPermissionsService {
  // Check photos permission...
  static Future<bool> get isGalleryPermissionGranted async {
    _isPermissionGranted(Platform.isIOS
        ? await Permission.photos.status
        : await Permission.storage.status);

    return _isPermissionGranted(
      Platform.isIOS
          ? await Permission.photos.request()
          : await Permission.storage.request(),
    );
  }

  // Check camera permission...
  static Future<bool> get checkCameraPermission async {
    _isPermissionGranted(await Permission.camera.status);
    return _isPermissionGranted(
      Platform.isIOS
          ? await Permission.camera.request()
          : await Permission.storage.request(),
    );
  }

  // Check location permission
  static Future<bool> get getLocationPermission async {
    _isPermissionGranted(await Permission.location.status);
    return _isPermissionGranted(
      await Permission.location.request(),
    );
  }

  static bool _isPermissionGranted(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.limited:
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }
}
