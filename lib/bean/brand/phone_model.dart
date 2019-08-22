import 'dart:convert' show jsonEncode;

class PhoneModel {
  int screenWidth;

  int screenHeight;

  String platform;

  String version;

  PhoneModel(
      {this.screenHeight, this.screenWidth, this.platform, this.version});

  Map<String, dynamic> toJson() => {
        'screenWidth': this.screenWidth,
        'screenHeight': this.screenHeight,
        'platform': this.platform,
        'version': this.version
      };
}
