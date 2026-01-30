import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/notification/data/model/bank_model.dart';
import 'package:e_commerce/features/payment/data/models/payment_model.dart';

abstract class PaymentRemoteDatasource {
  Future<PaymentModel> fetchById(int id);
  Future<Either<Failure, void>> payment(PayModel data);
  Future<Either<Failure, List<BankModel>>> fetchBank(int id);
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<PaymentModel> fetchById(int id) async {
    try {
      final response = await _dio.get('/api/orders/$id');
      final Map<String, dynamic> jsonList = response.data;
      return PaymentModel.fromJson(jsonList);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> payment(PayModel data) async {
    try {
      final formData = FormData.fromMap({
        "orderId": data.orderId,
        "productstatusId": data.productstatusId,
        "comment": data.comment,
        "payimg": await MultipartFile.fromFile(
          data.payimg.path,
          filename: data.payimg.path.split('/').last,
        ),
      });
      final response =
          await _dio.post('/api/orders/orderstatus', data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(null);
      } else {
        return Left(Failure('Failed to Pay'));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BankModel>>> fetchBank(int id) async {
    try {
      final response = await _dio.get('/api/bankorder/$id');
      if (response.statusCode == 200) {
        if (response.data is List) {
          final List jsonList = response.data;
          print('Bank: $jsonList');
          final jsonData = jsonList.map((b) => BankModel.fromJson(b)).toList();
          return Right(jsonData);
        } else {
          return Left(Failure('Invalid response format: expected List'));
        }
      } else {
        final message =
            response.data is Map && response.data.containsKey('message')
                ? response.data['message']
                : 'Unknown server error';
        return Left(Failure(message ?? 'ບໍ່ສາມາດສະແດງ QR'));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    }
  }
}
