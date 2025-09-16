import 'package:e_commerce/features/home/domain/entities/products_entity.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchAll();
}
