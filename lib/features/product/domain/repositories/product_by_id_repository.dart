import 'package:e_commerce/features/home/data/models/product_model.dart';

abstract class ProductByIdRepository {
  Future<ProductModel> getProductById(int id);
}
