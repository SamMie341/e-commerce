import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/data/datasource/product_remote_datasource.dart';
import 'package:e_commerce/features/product/data/model/review_model.dart';

abstract class ProductRepository {
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getProductByShop(String userCode);
  Future<List<Review>> fetchReview(int productId);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Review>> fetchReview(int productId) async {
    return await remoteDataSource.fetchReview(productId);
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    return await remoteDataSource.getProductById(id);
  }

  @override
  Future<List<ProductModel>> getProductByShop(String userCode) async {
    return await remoteDataSource.getProductByShop(userCode);
  }
}
