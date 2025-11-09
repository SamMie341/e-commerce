import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/reviews/data/model/review_id_model.dart';
import 'package:e_commerce/features/reviews/data/model/review_model.dart';

abstract class ReviewDetailRemoteDatasource {
  Future<List<ReviewModel>> fetchReview({int page = 1, int limit = 10});

  Future<ReviewIdModel> fetchReviewById(int id);

  Future<void> postReview(int productId, int rating, String comment);
}

class ReviewDetailRemoteDataSourceImpl implements ReviewDetailRemoteDatasource {
  @override
  Future<List<ReviewModel>> fetchReview({int page = 1, int limit = 10}) async {
    final response = await DioConfig.dioWithAuth
        .get('/api/orderfinish?page=$page&limit=$limit');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => ReviewModel.fromJson(item)).toList();
  }

  @override
  Future<ReviewIdModel> fetchReviewById(int id) async {
    try {
      final response = await DioConfig.dioWithAuth.get('/api/orders/$id');
      final Map<String, dynamic> jsonList = response.data;
      return ReviewIdModel.fromJson(jsonList);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> postReview(int productId, int rating, String comment) async {
    final response = await DioConfig.dioWithAuth.post('/api/reviews', data: {
      "productId": productId,
      "rating": rating,
      "comment": comment,
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Fail to Reviews');
    }
  }
}
