import 'package:flutter/material.dart';
import '../bean/category_item.dart';
import '../http/request.dart' as http;
import '../config/http_config.dart' as config;

class CategoryItemScroll extends StatefulWidget {
  CategoryItemScroll({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryItemScrollState();
  }
}

class CategoryItemScrollState extends State<CategoryItemScroll> {
  List<CategoryItem> items;
  CategoryItem checked;

  @override
  void initState() {
    super.initState();
    items = new List();
    const body = {
      "homeProdType": 0,
      "lastProductIndex": 0,
      "categoryVersion": "",
      "pageType": 0,
      "recommendLastIndex": 0,
      "secondGroupId": "",
      "isHome": 0,
      "categoryCode": "hdxiexiaofu"
    };
    const header = {
      "userLng": "121.63499",
      "addressCode": "310115",
      "stationCode": "MRYX|mryx_zjzpx",
      "screenWidth": "1080",
      "session": "android0.100670670282450141564787825728",
      "screenHeight": "1920",
      "deliveryType": "1",
      "accessToken":
          "a1FIYXlTY3NCSEVPMDI4ekJlNHlYM2sxdkF4dUVHcTZwcWxBdFU0d3B5Qnl2TGdkVUlFZ0Y0akEyQ0FJeUVSaA==",
      "version": "9.4.0",
      "platform": "android",
      "userLat": "31.18506",
      "currentLat": "31.18506",
      "smDeviceId":
          "20190803071708c436092d1e05862d33e0341b2a66955901b6d4a3b6c45d45",
      "androidChannelValue": "xiaomi",
      "imei": "c536040143b8e1ebfbcdc37b903f6fbd",
      "tdk":
          "eyJvcyI6ImFuZHJvaWQiLCJ2ZXJzaW9uIjoiMy4xLjkiLCJwYWNrYWdlcyI6ImNuLm1pc3NmcmVzaC5hcHBsaWNhdGlvbiomOS40LjAiLCJwcm9maWxlX3RpbWUiOjIxOTgsImludGVydmFsX3RpbWUiOjc4MTQ4LCJ0b2tlbl9pZCI6InVYUnZEeExcLytOMFJ5MnR4QVRzRjFtdTE0TDNCRXVFeHk1ZjVqNzZheVFiZ2pEK0dpQ0MyMXJOeXcwbGJib25hZnFLUm4xZEJ3WE1jeWhVb3RzQmpoUT09In0=",
      "currentLng": "121.63499",
      "sourceDeviceId": "865441035038124",
      "android_id": "87be3c54dfc6d9f1",
      "devtk": "",
      "bigWarehouse": "MRYXSHW"
    };
    http.HttpRequest(config.HttpConfig.MeiRiBaseUrl)
        .post("as/home/category/classifyProductInfo", body, headers: header)
        .then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Container(
          child: Text(item.name),
          alignment: AlignmentDirectional.center,
        );
      }).toList(),
    );
  }
}
