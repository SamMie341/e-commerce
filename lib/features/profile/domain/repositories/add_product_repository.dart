import 'package:e_commerce/features/payment/data/models/add_product.dart';
import 'package:e_commerce/features/profile/data/datasources/add_product_remote_datasource.dart';

abstract class AddProductRepository {
  Future<void> addProduct(AddProductModel data);
}

class AddProductRepositoryImpl implements AddProductRepository {
  final AddProductRemoteDatasource remote;

  AddProductRepositoryImpl(this.remote);

  @override
  Future<void> addProduct(AddProductModel data) async {
    return await remote.addProduct(data);
  }
}
