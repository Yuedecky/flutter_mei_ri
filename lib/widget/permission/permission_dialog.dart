import 'package:flutter/material.dart';
import '../leading_row.dart';
import '../../bean/permission/permission_item.dart';

class PermissionDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PermissionDialogState();
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
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Text(
            '需要开启以下权限',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '为了您能更正常的使用每日优鲜需要开启以下权限',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            softWrap: true,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: permissions.map<LeadingRow>((item) {
              return LeadingRow.fromItem(
                item.type,
                item.title,
                item.subtitle,
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
