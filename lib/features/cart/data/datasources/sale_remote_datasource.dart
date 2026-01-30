import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';

abstract class SaleRemoteDatasource {
  Future<Either<Failure, void>> sale(List<Map<String, dynamic>> data);
}

class SaleRemoteDatasourceImpl implements SaleRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<Either<Failure, void>> sale(List<Map<String, dynamic>> data) async {
    try {
      final response = await _dio.post(
        '$apiUrl/api/orders',
        data: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(null);
      } else {
        final message = response.data['message'];
        return Left(Failure(message));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occured'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
