import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/notification/data/datasource/shop_remote_datasource.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/notification/data/model/shop_model.dart';
import 'package:e_commerce/features/notification/data/model/add_product_model.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

abstract class ShopRepository {
  Future<Either<Failure, List<ShopModel>>> fetchProductShop();
  Future<Either<Failure, List<CategoryModel>>> fetchCategory();
  Future<Either<Failure, List<UnitModel>>> fetchUnit();
  Future<Either<Failure, void>> updateProduct(
      AddProductModel product, int productId);
  Future<Either<Failure, List<BankModel>>> fetchBankQR();
  Future<Either<Failure, List<Banklogo>>> dropDownBank();
  Future<Either<Failure, void>> addBankQR(AddQRModel data);
  Future<Either<Failure, void>> updateBankQR(AddQRModel data, int id);
  Future<Either<Failure, void>> deleteQRBank(int id);
  Future<Either<Failure, void>> addProduct(AddProductModel data);
  Future<Either<Failure, void>> deleteProduct(int id);
}

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDatasource remoteDatasource;
  ShopRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<ShopModel>>> fetchProductShop() async {
    return await remoteDatasource.fetchProductShop();
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategory() async {
    return await remoteDatasource.fetchCategory();
  }

  @override
  Future<Either<Failure, List<UnitModel>>> fetchUnit() async {
    return await remoteDatasource.fetchUnit();
  }

  @override
  Future<Either<Failure, void>> updateProduct(
      AddProductModel product, int productId) async {
    return await remoteDatasource.updateProduct(product, productId);
  }

  @override
  Future<Either<Failure, List<BankModel>>> fetchBankQR() async {
    return await remoteDatasource.fetchBankQR();
  }

  @override
  Future<Either<Failure, List<Banklogo>>> dropDownBank() async {
    return await remoteDatasource.dropDownBank();
  }

  @override
  Future<Either<Failure, void>> addBankQR(AddQRModel data) async {
    return await remoteDatasource.addBankQR(data);
  }

  @override
  Future<Either<Failure, void>> updateBankQR(AddQRModel data, int id) async {
    return await remoteDatasource.updateBankQR(data, id);
  }

  @override
  Future<Either<Failure, void>> deleteQRBank(int id) async {
    return await remoteDatasource.deleteQRBank(id);
  }

  @override
  Future<Either<Failure, void>> addProduct(AddProductModel data) async {
    return await remoteDatasource.addProduct(data);
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    return await remoteDatasource.deleteProduct(id);
  }
}
