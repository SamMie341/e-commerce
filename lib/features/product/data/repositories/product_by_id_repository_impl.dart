import 'package:e_commerce/features/product/data/datasource/product_by_id_remote.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_by_id_repository.dart';

class ProductByIdRepositoryImpl implements ProductByIdRepository {
  final ProductByIdRemote remoteDataSource;

  ProductByIdRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProductModel> getProductById(int id) async {
    return await remoteDataSource.fetchProductById(id);
  }
}
