import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  Future<bool> requestSavePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        return true;
      } else {
        return await _requestPermission(Permission.storage);
      }
    } else {
      var status = await Permission.photosAddOnly.status;
      if (status.isGranted) return true;
      return await _requestPermission(Permission.photos);
    }
  }

  Future<bool> requestCameraPermission() async {
    return await _requestPermission(Permission.camera);
  }

  Future<bool> _requestPermission(Permission permission) async {
    var status = await permission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await permission.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return false;
  }

  Future<bool> requestNotificationPermission() async {
    return await _requestPermission(Permission.notification);
  }

  Future<bool> requestPhotoPermission() async {
    Permission permission;

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        permission = Permission.photos;
      } else {
        permission = Permission.storage;
      }
    } else {
      permission = Permission.photos;
    }
    return await _requestPermission(permission);
  }
}
