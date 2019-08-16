import 'normal_product.dart';
class CategoryGroup {
  final int cellType;
  final String secondGroupName;
  final String secondGroupId;
  final NormalProduct normalProducts;
  final String skuFromSource;
  bool selected = false;

  CategoryGroup({this.cellType,this.secondGroupName,this.secondGroupId,this.normalProducts,this.skuFromSource});



  factory CategoryGroup.fromJson(Map<String, dynamic> json) {
    print("json:$json");
    return CategoryGroup(
        cellType: json['cellType'],
        secondGroupName: json['secondGroupName'],
        secondGroupId: json['secondGrouId'],
        normalProducts: NormalProduct.fromJson(json['normalProducts']),
        skuFromSource: json['manual']
    );
  }
}


