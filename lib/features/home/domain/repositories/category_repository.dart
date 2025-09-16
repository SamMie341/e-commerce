import '../entities/categorys_entity.dart';

abstract class CategoryRepository {
  Future<List<Category>> fetchAll();
}
