import 'package:flutter/material.dart';
import '../leading_row.dart';
import '../../bean/permission/permission_item.dart';
import '../../utils/system.dart';

class PermissionDialog extends StatefulWidget {
  final List<PermissionItem> items;

  PermissionDialog({this.items});

  @override
  State<StatefulWidget> createState() {
    return _PermissionDialogState(permissions: items);
  }
}

class _PermissionDialogState extends State<PermissionDialog> {
  final List<PermissionItem> permissions;

  _PermissionDialogState({this.permissions});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: ListTile(
        title: Text('需要开启以下权限'),
        subtitle: Text(
          '为了您能更正常的使用每日优鲜需要开启以下权限',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          softWrap: true,
        ),
      ),
      titlePadding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      content: SingleChildScrollView(
        child: ListBody(
          children: permissions.map<Widget>((item) {
            return LeadingRow.fromItem(item.type, item.title, item.subtitle);
          }).toList(),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('下一步'),
          onPressed: () {
            SystemUtils.setCacheItem("model", SystemUtils.getDeviceInfo());
            Navigator.of(context).pop();
          },
        )
      ],
      elevation: 3,
    );
  }
}
