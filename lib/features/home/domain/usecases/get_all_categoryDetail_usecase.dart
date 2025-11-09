import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/home/domain/repositories/product_repository.dart';

class GetAllCategoryDetailUseCase {
  final Repository repository;

  GetAllCategoryDetailUseCase(this.repository);

  Future<List<ProductModel>> callCategory(int id,
      {int page = 1, int limit = 10}) async {
    return await repository.fetchCategoryDetail(id, page: page, limit: limit);
  }
}
