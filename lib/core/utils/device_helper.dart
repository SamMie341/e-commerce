import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceHelper {
  static Future<Map<String, String>> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceModel = 'Unknown';
    String platformName = Platform.operatingSystem;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceModel = iosInfo.utsname.machine;
      }
    } catch (e) {
      print('Error getting device info: $e');
    }

    return {
      'platform': platformName,
      'model': deviceModel,
    };
  }
}
