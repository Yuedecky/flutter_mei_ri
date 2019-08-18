import 'package:flutter/material.dart';
import 'package:flutter_mei_ri/bean/category/category_item.dart';
import '../http/dio_request.dart' as request;
import '../config/http_config.dart' as config;
import '../config/storage_config.dart';
import '../utils/system_info.dart';

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
  void initState() async{
    super.initState();

    items = new List();
    final String addressCode = await SystemInfo.getItem(StorageConfig.AddressCodeKey);
    final body = {
      "common": {"addressCode": addressCode},
      "param": {}
    };

    request.HttpGo.postJson(
      config.HttpConfig.CategoryListUrl,
      body,
    ).then((value) {
      print('in category response:${value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Container(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[],
          ),
          alignment: AlignmentDirectional.center,
        );
      }).toList(),
    );
  }
}
