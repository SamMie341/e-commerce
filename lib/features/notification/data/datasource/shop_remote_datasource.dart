import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/notification/data/model/shop_model.dart';

abstract class ShopRemoteDatasource {
  Future<List<ShopModel>> fetchProductShop();
}

class ShopRemoteDatasourceImpl implements ShopRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<List<ShopModel>> fetchProductShop() async {
    try {
      final response = await _dio.get('/api/products/listuser');
      if (response.data is! List) {
        return [];
      }
      final List<dynamic> jsonList = response.data;
      return jsonList.map((item) => ShopModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load product ${e.message}');
    }
  }
}
