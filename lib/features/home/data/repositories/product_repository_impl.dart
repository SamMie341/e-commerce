import 'package:e_commerce/features/home/data/datasources/product_remote_datasource.dart';
import 'package:e_commerce/features/home/domain/entities/products_entity.dart';
import 'package:e_commerce/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> fetchAll() {
    return remoteDataSource.fetchAllProducts();
  }
}
