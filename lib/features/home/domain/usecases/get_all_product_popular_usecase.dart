import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/home/domain/repositories/product_repository.dart';

class GetAllProductPopularUseCase {
  final Repository repository;

  GetAllProductPopularUseCase(this.repository);

  Future<List<ProductModel>> call() async {
    return repository.fetchAllProductPopular();
  }
}
