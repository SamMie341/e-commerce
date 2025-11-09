import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/data/model/review_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getProductByShop(String userCode);
  Future<List<Review>> fetchReview(int productId);
}

class ProductRemoteDatasourceImpl implements ProductRemoteDataSource {
  final Dio _dio = DioConfig.dioWithAuth;
  @override
  Future<List<Review>> fetchReview(int productId) async {
    final response = await _dio.get('/api/reviews?productId=$productId');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => Review.fromJson(json)).toList();
    } else {
      print(Exception());
      throw Exception('Fail to load Review');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _dio.get('/api/products/$id');
      final Map<String, dynamic> json = response.data;
      // print('Product Detail: $json');
      print('product detail runtime: ${response.runtimeType}');
      return ProductModel.fromJson(json);
    } catch (e) {
      print('Fetch error: $e');
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getProductByShop(String userCode) async {
    final response =
        await _dio.get('/api/products/getproduct?userCode=$userCode');
    if (response.statusCode == 200) {
      final List<dynamic> json = response.data;
      print('shop: $json');
      print('Response ${response.runtimeType}');
      return json.map((jsonList) => ProductModel.fromJson(jsonList)).toList();
    } else {
      print(Exception());
      throw Exception('Fail to load Shop');
    }
  }
}
