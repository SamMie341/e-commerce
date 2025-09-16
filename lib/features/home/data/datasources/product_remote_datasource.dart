import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';

class ProductRemoteDataSource {
  final DioConfig dioConfig;
  ProductRemoteDataSource(this.dioConfig);

  Future<List<ProductModel>> fetchAllProducts() async {
    final response = await DioConfig.dioWithAuth.get('/api/products');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}
