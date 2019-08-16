class PriceUnit {
  final int showStyle;

  final int color;
  final int price;

  const PriceUnit({this.showStyle, this.color, this.price});

  factory PriceUnit.fromJson(Map<String, dynamic> json) {
    print("priceUnit,$json");
      if(json != null){
        return PriceUnit(
            showStyle: json['showStyle'],
            color: json['color'],
            price: json['price']);
      }else{
        return PriceUnit();
      }
  }
}
