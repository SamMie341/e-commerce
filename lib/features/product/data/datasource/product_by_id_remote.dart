import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';

class ProductByIdRemote {
  final DioConfig dio;
  ProductByIdRemote(this.dio);

  Future<ProductModel> fetchProductById(int id) async {
    try {
      final response = await DioConfig.dioWithAuth.get('/api/products/$id');
      final Map<String, dynamic> json = response.data;
      // print('Product Detail: $json');
      print('product detail runtime: ${response.runtimeType}');
      return ProductModel.fromJson(json);
    } catch (e) {
      print('Fetch error: $e');
      rethrow;
    }
  }
}
