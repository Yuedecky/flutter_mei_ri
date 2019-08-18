class VipTag {
  final int nameColor;
  final String name;

  final String bgImage;

  const VipTag({this.nameColor, this.name, this.bgImage});

  factory VipTag.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return VipTag(
          name: json['name'],
          nameColor: json['nameColor'],
          bgImage: json['bgImage']);
    } else {
      return VipTag();
    }
  }
}
