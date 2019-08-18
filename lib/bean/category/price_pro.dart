import 'package:flutter_mei_ri/bean/category/price_unit.dart';

class PricePro {

  final PriceUnit noVip;

  final PriceUnit vip;

  const PricePro({this.noVip,this.vip});

  factory PricePro.fromJson(Map<String,dynamic> json){
    return PricePro(
      noVip: PriceUnit.fromJson(json['noVip']),
      vip:PriceUnit.fromJson(json['vip'])
    );
  }


}