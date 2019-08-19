import 'package:flutter/material.dart';
import '../main.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../bean/permission/permission_item.dart';
import '../../widget/permission/permission_dialog.dart';
import '../../bean/permission/permission_item_type.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  bool isStartHomePage = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
    countDown();
  }

  /// 检查是否设置访问权限
  void checkPermission() async {
    List<PermissionItem> permissions = new List();
    PermissionStatus locationStatus = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (locationStatus.value == PermissionStatus.denied.value) {
      permissions.add(PermissionItem(PermissionItemType.Position,
          title: "定位信息", subtitle: "用于获取商品在当前位置可购买库存"));
    }
    PermissionStatus deviceStatus = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (deviceStatus.value == PermissionStatus.denied.value) {
      permissions.add(PermissionItem(PermissionItemType.Storage,
          title: '存储空间', subtitle: "用于缓存商品图片等信息"));
    }

    if (permissions.length > 0) {
      showDialog(context: context,child: PermissionDialog());
    }
  }

  void countDown() {
    //设置倒计时三秒后执行跳转方法
    var duration = Duration(seconds: 3);
    new Future.delayed(duration, goToHomePage);
  }

  void goToHomePage() {
    //如果页面还未跳转过则跳转页面
    if (!isStartHomePage) {
      //跳转主页 且销毁当前页面
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainPage()),
          (Route<dynamic> rout) => false);
      isStartHomePage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Image.asset(
          "images/splash.jpg",
          fit: BoxFit.cover,
        ));
  }
}
