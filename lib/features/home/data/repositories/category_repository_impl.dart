import 'package:e_commerce/features/home/data/datasources/category_remote_datasource.dart';
import 'package:e_commerce/features/home/domain/entities/categorys_entity.dart';
import 'package:e_commerce/features/home/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> fetchAll() {
    return remoteDataSource.fetchAllCategory();
  }
}
