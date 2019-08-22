import 'dart:async';
import 'package:package_info/package_info.dart';
import 'package:localstorage/localstorage.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';

class SystemUtils {

  static final LocalStorage _storage = LocalStorage("flutter_mei_ri");

  static Future<String> getAppName(){
     return PackageInfo.fromPlatform().then((value){
       return value.appName;
     });
  }

  static Future<String> getCacheItem(String key){
    return _storage.getItem(key);
  }

  static Future<void> setCacheItem(String key,dynamic value){
    return _storage.setItem(key, value);
  }


  static Future<dynamic> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      return await deviceInfo.androidInfo;
    }else if(Platform.isIOS){
      return await deviceInfo.iosInfo;
    }
  }
}