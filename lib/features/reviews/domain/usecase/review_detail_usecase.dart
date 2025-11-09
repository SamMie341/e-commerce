import 'package:e_commerce/features/reviews/data/model/review_id_model.dart';
import 'package:e_commerce/features/reviews/data/model/review_model.dart';
import 'package:e_commerce/features/reviews/domain/repository/review_repositories.dart';

class ReviewDetailUseCase {
  final ReviewDetailRepository repository;

  ReviewDetailUseCase(this.repository);

  Future<List<ReviewModel>> call({int page = 1, int limit = 10}) async {
    return await repository.fetchReview(page: page, limit: limit);
  }

  Future<ReviewIdModel> fetchReviewById(int id) async {
    return await repository.fetchReviewById(id);
  }

  Future<void> postReview(int productId, int rating, String comment) async {
    return await repository.postReview(productId, rating, comment);
  }
}
