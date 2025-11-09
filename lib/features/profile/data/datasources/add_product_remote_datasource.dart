import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/payment/data/models/add_product.dart';

abstract class AddProductRemoteDatasource {
  Future<void> addProduct(AddProductModel data);
}

class AddProductRemoteDatasourceImpl implements AddProductRemoteDatasource {
  @override
  Future<void> addProduct(AddProductModel data) async {
    try {
      final formData = FormData.fromMap({
        "categoryId": data.categoryId,
        "productunitId": data.productunitId,
        "title": data.title,
        "detail": data.detail,
        "price": data.price,
        "pimg": await MultipartFile.fromFile(data.pimg!.path,
            filename: data.pimg?.path.split('/').last)
      });
      final response =
          await DioConfig.dioWithAuth.post('/api/products', data: formData);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Fail To Payment');
      }
    } catch (e) {
      rethrow;
    }
  }
}
