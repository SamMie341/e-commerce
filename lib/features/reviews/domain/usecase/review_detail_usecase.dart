import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/reviews/data/model/review_by_product_model.dart';
import 'package:e_commerce/features/reviews/data/model/review_model.dart';
import 'package:e_commerce/features/reviews/domain/repository/review_repositories.dart';

class ReviewDetailUseCase {
  final ReviewDetailRepository repository;

  ReviewDetailUseCase(this.repository);

  Future<List<ReviewModel>> call({int page = 1, int limit = 10}) async {
    return await repository.fetchReview(page: page, limit: limit);
  }

  Future<ProductModel> fetchReviewById(int id) async {
    return await repository.fetchReviewById(id);
  }

  Future<Either<Failure, void>> postReview(
      int productId, int rating, String comment) async {
    return await repository.postReview(productId, rating, comment);
  }

  Future<Either<Failure, List<ReviewByProductModel>>> fetchReviewByPro(
      int productId) async {
    return await repository.fetchReviewByPro(productId);
  }

  Future<Either<Failure, void>> updateReview(
      int reviewId, int productId, int rating, String comment) async {
    return repository.updateReview(reviewId, productId, rating, comment);
  }

  Future<Either<Failure, void>> deleteReview(int reviewId) async {
    return repository.deleteReview(reviewId);
  }
}
