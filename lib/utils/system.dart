import 'dart:async';
import 'package:package_info/package_info.dart';
import 'package:localstorage/localstorage.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import '../bean/brand/phone_model.dart';

class SystemUtils {
  static final LocalStorage _storage = LocalStorage("flutter_mei_ri");

  static Future<String> getAppName() {
    return PackageInfo.fromPlatform().then((value) {
      return value.appName;
    });
  }

  static Future<String> getCacheItem(String key) {
    return _storage.getItem(key);
  }

  static Future<void> setCacheItem(String key, Object value) {
    return _storage.setItem(key, value);
  }

  static PhoneModel getDeviceInfo() {
    PhoneModel model = PhoneModel();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      Future<AndroidDeviceInfo> androidInfo = deviceInfo.androidInfo;
      androidInfo.then((val) {
        model.version = val.version.baseOS;
        model.platform = val.model;
      });
    } else if (Platform.isIOS) {
      Future<IosDeviceInfo> iosInfo = deviceInfo.iosInfo;
      iosInfo.then((val) {
        model.platform = val.name;
        model.version = val.systemVersion;
      });
    }
    return model;
  }
}
