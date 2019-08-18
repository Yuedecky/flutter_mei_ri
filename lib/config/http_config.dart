class HttpConfig {


  static const MeiRiBaseUrl = "https://as-vip.missfresh.cn/";


  //首页左上角 ‘优鲜超市’
  static const IndexLocationTagUrl = "/v1/product/chrome/view";

  //首页上边部分 滚动banner url 和 二级banner  以及 首页 品类
  static const IndexBannerListUrl = "as/home/indexPage";

  //首页右下角 广告sheet url
  static const IndexAdvInfoUrl = "web20/system/advertInfo/";

  static const AddressSearchUrl = "web20/address/place/search?boundary=nearby(%3.5f,%3.5f)&page_index=%2d&page_size=%2d";

  //分类页面 左侧分类scroll 列表
  static const CategoryListUrl = "as/home/categoryList";

  //分类页面 右侧顶部 分类展示url
  static const CategoryClassifyUrl = "as/home/category/classifyProductInfo";

  //购物车页面 购物车列表
  static const CartCountUrl = "as/cart/count";

  //购物车页面 购物车列表
  static const CartPromotionUrl = "as/cart/addcart/promotion";

  //购物车页面 推荐喜欢列表url
  static const CartRecommendSkuListUrl = "as/item/getReSkus";

}