import 'package:e_commerce/features/product/data/model/review_model.dart';

abstract class ReviewRepository {
  Future<List<Review>> fetchReview(int productId);
}
