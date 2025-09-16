import 'package:e_commerce/features/home/data/models/product_model.dart';

abstract class ProductByShopRepo {
  Future<List<ProductModel>> getProductByShop(String userCode);
}
