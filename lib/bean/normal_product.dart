import 'promotion_tag.dart';
import 'spu_info.dart';
import 'price_pro.dart';
import 'vip_tag.dart';

class NormalProduct {
  final String image;

  List<PromotionTag> promotionTags;

  final String cartBtnName;

  final bool emptySpuInfo;

  final bool sellOut;

  final String skuCategory;

  final int skuCategoryId;
  final int secKillLimit;

  final String brandTag;

  //副标题
  final String subtitle;

  //标题
  final String name;

  //促销相关
  final PromotionTag promotionDeliveryTag;

  final PromotionTag promotionTag;

  final VipTag vipTag;

  final SpuInfo spuInfo;

  final String sku;
  final int stock;

  final int showOrder;

  final String cartImage;
  final PricePro pricePro;

  NormalProduct({
    this.image,
    this.name,
    this.subtitle,
    this.spuInfo,
    this.showOrder,
    this.sku,
    this.vipTag,
    this.cartImage,
    this.promotionTag,
    this.stock,
    this.pricePro,
    this.brandTag,
    this.promotionDeliveryTag,
    this.promotionTags,
    this.cartBtnName,
    this.skuCategoryId,
    this.emptySpuInfo,
    this.sellOut,
    this.skuCategory,
    this.secKillLimit,
  });

  factory NormalProduct.fromJson(Map<String, dynamic> json) {
    print("NormalProduct $json");
    if (json != null) {
      return NormalProduct(
          name: json['name'],
          image: json['image'],
//        promotionTags: PromotionTag.fromJsonList(json['promotionTags']),
          sellOut: json['sell_out'],
          skuCategory: json['skuCategory'],
          emptySpuInfo: json['emptySpuInfo'],
          cartBtnName: json['cart_btn_name'],
          vipTag: VipTag.fromJson(json['vipTag']),
          promotionTag: PromotionTag.fromJson(json['promotionTag']),
          secKillLimit: json['seckill_limit'],
          skuCategoryId: json['skuCategoryId'],
          brandTag: json['brandTag'],
//        promotionDeliveryTag: PromotionTag.fromJson(json['promotionDeliveryTag']),
          subtitle: json['subtitle'],
          cartImage: json['cart_image'],
//        spuInfo: SpuInfo.fromJson(json['spuInfo']),
          showOrder: json['showOrder'],
          sku: json['sku'],
          stock: json['stock'],
          pricePro: PricePro.fromJson(json['pricePro']));
    } else {
      return null;
    }
  }
}
