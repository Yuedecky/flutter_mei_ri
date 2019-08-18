import 'dart:async';
import 'package:package_info/package_info.dart';
import 'package:localstorage/localstorage.dart';

class SystemInfo {

  static final LocalStorage _storage = LocalStorage("flutter_mei_ri");

  static Future<String> getAppName(){
     return PackageInfo.fromPlatform().then((value){
       return value.appName;
     });
  }

  static Future<String> getItem(String key){
    return _storage.getItem(key);
  }

}