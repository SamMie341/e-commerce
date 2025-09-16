import 'package:e_commerce/features/home/domain/entities/categorys_entity.dart';
import 'package:e_commerce/features/home/domain/repositories/category_repository.dart';

class GetAllCategoryUseCase {
  final CategoryRepository repository;

  GetAllCategoryUseCase(this.repository);

  Future<List<Category>> call() async {
    return await repository.fetchAll();
  }
}
