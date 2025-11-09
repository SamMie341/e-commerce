import 'package:e_commerce/features/product/data/model/review_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';

class GetReviewUseCase {
  final ProductRepository repository;

  GetReviewUseCase(this.repository);

  Future<List<Review>> call(int productId) {
    return repository.fetchReview(productId);
  }
}
