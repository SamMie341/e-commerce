import 'package:e_commerce/features/home/data/datasources/remote_datasource.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';

abstract class Repository {
  Future<List<ProductModel>> fetchAll({int page = 1, int limit = 10});

  Future<List<ProductModel>> fetchCategoryDetail(int id,
      {int page = 1, int limit = 10});
}

class RepositoryImpl implements Repository {
  final RemoteDatasource remoteDataSource;

  RepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductModel>> fetchAll({int page = 1, int limit = 10}) async {
    return await remoteDataSource.fetchAllProducts(page: page, limit: limit);
  }

  @override
  Future<List<ProductModel>> fetchCategoryDetail(int id,
      {int page = 1, int limit = 10}) async {
    return await remoteDataSource.fetchCategoryDetail(id,
        page: page, limit: limit);
  }
}
