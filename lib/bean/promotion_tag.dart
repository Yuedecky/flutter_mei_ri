class PromotionTag {
  final int borderColor;
  final int bgColor;
  final int nameColor;

  final int endColor;
  final int startColor;
  final String name;

  PromotionTag({this.borderColor,this.bgColor,this.nameColor,this.name,this.startColor,this.endColor,});

  factory PromotionTag.fromJson(Map<String,dynamic> json){
    return PromotionTag(
      borderColor: json['borderColor'],
      bgColor: json['bgColor'],
      endColor: json['endColor'],
      startColor: json['startColor'],
      nameColor: json['nameColor'],
      name: json['name']
    );
  }

}