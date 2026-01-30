import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/reviews/data/model/review_by_product_model.dart';
import 'package:e_commerce/features/reviews/data/model/review_model.dart';

abstract class ReviewDetailRemoteDatasource {
  Future<List<ReviewModel>> fetchReview({int page = 1, int limit = 10});

  Future<ProductModel> fetchReviewById(int productId);

  Future<void> postReview(int productId, int rating, String comment);
  Future<List<ReviewByProductModel>> fetchReviewByPro(int productId);
  Future<void> updateReview(
      int reviewId, int productId, int rating, String comment);
  Future<void> deleteReview(int reviewId);
}

class ReviewDetailRemoteDataSourceImpl implements ReviewDetailRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;
  @override
  Future<List<ReviewModel>> fetchReview({int page = 1, int limit = 10}) async {
    final response = await _dio.get('/api/productreviews');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((item) => ReviewModel.fromJson(item)).toList();
  }

  @override
  Future<ProductModel> fetchReviewById(int id) async {
    try {
      final response = await _dio.get('/api/products/$id');
      final Map<String, dynamic> json = response.data;
      return ProductModel.fromJson(json);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> postReview(int productId, int rating, String comment) async {
    final response = await _dio.post('/api/reviews', data: {
      "productId": productId,
      "rating": rating,
      "comment": comment,
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Fail to Reviews');
    }
    if (response.statusCode == 409) {
      throw Exception('ທ່ານຣີວິວສິນຄ້າແລ້ວ');
    }
  }

  @override
  Future<List<ReviewByProductModel>> fetchReviewByPro(int productId) async {
    final response = await _dio
        .get('/api/personreviews', queryParameters: {'productId': productId});
    if (response.statusCode == 200) {
      final List data = response.data;
      print(data);
      return data.map((e) => ReviewByProductModel.fromJson(e)).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> deleteReview(int reviewId) async {
    final response = await _dio.delete('/api/reviews/$reviewId');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete review');
    }
  }

  @override
  Future<void> updateReview(
      int reviewId, int productId, int rating, String comment) async {
    final response = await _dio.put('/api/reviews/$reviewId', data: {
      "productId": productId,
      "rating": rating,
      "comment": comment,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to update review');
    }
  }
}
