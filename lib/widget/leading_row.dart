import 'package:flutter/material.dart';
import '../bean/permission/permission_item_type.dart';


class LeadingRow extends StatelessWidget {

  final String image;
  final String title;
  final String subtitle;


  LeadingRow({ this.image, this.title, this.subtitle});


  factory LeadingRow.fromItem(PermissionItemType type,String title,String subtitle){
    switch(type){
      case PermissionItemType.Device:
        return LeadingRow(image:"images/permission/device.png",title:title,subtitle: subtitle);
      case PermissionItemType.Position:
        return LeadingRow(image:"images/permission/position.png",title:title,subtitle:subtitle);
      case PermissionItemType.Storage:
        return LeadingRow(image:"images/permission/storage.png",title:title,subtitle:subtitle);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(this.image),
        ),
        title: Text(this.title),
        subtitle: Text(this.subtitle),
      ),
    );
  }
}
