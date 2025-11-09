import 'package:e_commerce/features/reviews/data/datasource/review_detail_remote.dart';
import 'package:e_commerce/features/reviews/data/model/review_id_model.dart';
import 'package:e_commerce/features/reviews/data/model/review_model.dart';

abstract class ReviewDetailRepository {
  Future<List<ReviewModel>> fetchReview({int page = 1, int limit = 10});

  Future<ReviewIdModel> fetchReviewById(int id);

  Future<void> postReview(int productId, int rating, String comment);
}

class ReviewDetailRepositoryImpl implements ReviewDetailRepository {
  final ReviewDetailRemoteDatasource remote;
  ReviewDetailRepositoryImpl(this.remote);

  @override
  Future<List<ReviewModel>> fetchReview({int page = 1, int limit = 10}) async {
    return await remote.fetchReview(page: page, limit: limit);
  }

  @override
  Future<ReviewIdModel> fetchReviewById(int id) async {
    return await remote.fetchReviewById(id);
  }

  @override
  Future<void> postReview(int productId, int rating, String comment) async {
    return await remote.postReview(productId, rating, comment);
  }
}
