import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/product/data/model/review_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getProductByShop(int id);
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
      throw Exception('Fail to load Review');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _dio.get('/api/products/$id');
      final Map<String, dynamic> json = response.data;
      print('Product Detail: $json');
      // print('product detail runtime: ${response.runtimeType}');
      return ProductModel.fromJson(json);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductModel>> getProductByShop(int id) async {
    final response = await _dio.get('/api/shops/$id');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final List<dynamic> productsJson = data['products'] ?? [];

      final shopInfo = {
        "id": data["id"],
        "name": data["name"],
        "tel": data["tel"],
      };

      final userInfo = data["user"] ?? {};

      return productsJson.map((product) {
        final Map<String, dynamic> productMap = Map.from(product);

        productMap['shop'] = shopInfo;
        productMap['user'] = userInfo;
        return ProductModel.fromJson(productMap);
      }).toList();
    } else {
      throw Exception('Fail to load Shop');
    }
  }
}
