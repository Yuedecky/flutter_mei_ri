import 'permission_item_type.dart';

class PermissionItem {
  final String title;
  final String subtitle;
  final PermissionItemType type;

  PermissionItem(this.type,{this.title, this.subtitle,});
}
