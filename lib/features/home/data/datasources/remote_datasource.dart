import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';

abstract class RemoteDatasource {
  Future<List<ProductModel>> fetchAllProducts({int page = 1, int limit = 10});
  Future<List<ProductModel>> fetchCategoryDetail(int id,
      {int page = 1, int limit = 10});
  Future<List<ProductModel>> fetchProductPopular();
}

class RemoteDataSourceImpl implements RemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;
  @override
  Future<List<ProductModel>> fetchAllProducts(
      {int page = 1, int limit = 10}) async {
    final response = await _dio.get('/api/products');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<ProductModel>> fetchCategoryDetail(int id,
      {int page = 1, int limit = 10}) async {
    final response =
        await _dio.get('/api/products?categoryId=$id&page=$page&limit=$limit');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<List<ProductModel>> fetchProductPopular() async {
    final response = await _dio.get('/api/products/productpopular');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((pp) => ProductModel.fromJson(pp)).toList();
  }
}
