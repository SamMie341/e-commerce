import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';

class ProductByShopRemote {
  final DioConfig dioConfig;
  ProductByShopRemote(this.dioConfig);

  Future<List<ProductModel>> fetchProductByShop(String userCode) async {
    final response = await DioConfig.dioWithAuth
        .get('/api/products/getproduct?userCode=$userCode');
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
