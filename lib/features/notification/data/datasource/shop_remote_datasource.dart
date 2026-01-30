import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/notification/data/model/shop_model.dart';
import 'package:e_commerce/features/notification/data/model/add_product_model.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

abstract class ShopRemoteDatasource {
  Future<Either<Failure, List<ShopModel>>> fetchProductShop();
  Future<Either<Failure, List<CategoryModel>>> fetchCategory();
  Future<Either<Failure, List<UnitModel>>> fetchUnit();
  Future<Either<Failure, void>> updateProduct(
      AddProductModel product, int productId);
  Future<Either<Failure, void>> addBankQR(AddQRModel data);
  Future<Either<Failure, void>> updateBankQR(AddQRModel data, int id);
  Future<Either<Failure, List<BankModel>>> fetchBankQR();
  Future<Either<Failure, List<Banklogo>>> dropDownBank();
  Future<Either<Failure, void>> deleteQRBank(int id);
  Future<Either<Failure, void>> addProduct(AddProductModel data);
  Future<Either<Failure, void>> deleteProduct(int id);
}

class ShopRemoteDatasourceImpl implements ShopRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<Either<Failure, List<ShopModel>>> fetchProductShop() async {
    try {
      final response = await _dio.get('/api/products/listuser');
      final List jsonList = response.data;
      final jsonData =
          jsonList.map((item) => ShopModel.fromJson(item)).toList();
      print(jsonList);
      return Right(jsonData);
    } on DioException catch (e) {
      return Left(Failure(e.message!));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategory() async {
    try {
      final response = await _dio.get('/api/categorys');
      final List jsonList = response.data;
      final jsonData =
          jsonList.map((cat) => CategoryModel.fromJson(cat)).toList();
      return Right(jsonData);
    } on DioException catch (e) {
      return Left(Failure(e.message!));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UnitModel>>> fetchUnit() async {
    try {
      final response = await _dio.get('/api/productunits');
      final List jsonList = response.data;
      final jsonData =
          jsonList.map((unit) => UnitModel.fromJson(unit)).toList();
      return Right(jsonData);
    } on DioException catch (e) {
      return Left(Failure(e.message!));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(
      AddProductModel product, int productId) async {
    try {
      final Map<String, dynamic> data = {
        'categoryId': product.categoryId,
        'productunitId': product.productunitId,
        'title': product.title,
        'detail': product.detail,
        'price': product.price,
      };

      if (product.pimg != null) {
        data['pimg'] = await MultipartFile.fromFile(product.pimg!.path);
      }
      final formData = FormData.fromMap(data);

      final response =
          await _dio.put('/api/products/$productId', data: formData);
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(Failure('Failed to update product'));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An error Occurred'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addBankQR(AddQRModel data) async {
    try {
      final datas = FormData.fromMap({
        "banklogoId": data.banklogoId,
        "accountNo": data.accountNo,
        "accountName": data.accountName,
        "bankqr": await MultipartFile.fromFile(data.bankqr!.path,
            filename: data.bankqr!.path.split('/').last),
      });
      final response =
          await _dio.post('/api/banks', data: datas, options: Options(
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ));

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(null);
      } else {
        final message = response.data['message'] ?? 'ບໍ່ສາມາດເພີ່ມບັນຊີທະນາຄານ';
        return Left(Failure(message));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BankModel>>> fetchBankQR() async {
    try {
      final response = await _dio.get('/api/banks');
      final List jsonList = response.data;
      final jsonData = jsonList.map((b) => BankModel.fromJson(b)).toList();
      return Right(jsonData);
    } on DioException catch (e) {
      return Left(Failure(e.message!));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Banklogo>>> dropDownBank() async {
    try {
      final response = await _dio.get('/api/banklogos');
      final List jsonList = response.data;
      final jsonData = jsonList.map((i) => Banklogo.fromJson(i)).toList();
      return Right(jsonData);
    } on DioException catch (e) {
      return Left(Failure(e.message!));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateBankQR(AddQRModel data, int id) async {
    try {
      final Map<String, dynamic> datas = {
        "banklogoId": data.banklogoId,
        "accountNo": data.accountNo,
        "accountName": data.accountName,
      };
      if (data.bankqr != null) {
        datas['bankqr'] = await MultipartFile.fromFile(data.bankqr!.path,
            filename: data.bankqr!.path.split('/').last);
      }
      final formData = FormData.fromMap(datas);
      final response = await _dio.put('/api/banks/$id', data: formData);
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(Failure('Failed to update product'));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteQRBank(int id) async {
    try {
      final response = await _dio.delete('/api/banks/$id');
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        final message = response.data['message'] ?? 'ບໍ່ສາມາດລົບໄດ້';
        return Left(Failure(message));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addProduct(AddProductModel data) async {
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
      final response = await _dio.post('/api/products', data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(null);
      } else {
        final message = response.data['message'] ?? 'ບໍ່ສາມາດເພີ່ມສິນຄ້າ';
        return Left(Failure(message));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      final response = await _dio.delete('/api/products/$id');
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        final message = response.data['message'] ?? 'ບໍ່ສາມາດລົບໄດ້';
        return Left(Failure(message));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
