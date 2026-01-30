import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/features/notification/data/model/sale_model.dart';

abstract class ReportRemoteDatasource {
  Future<Either<Failure, SaleModel>> getSalesReport(
      String startDate, String endDate);
}

class ReportRemoteDataSourceImpl implements ReportRemoteDatasource {
  final Dio dio = DioConfig.dioWithAuth;

  @override
  Future<Either<Failure, SaleModel>> getSalesReport(
      String startDate, String endDate) async {
    try {
      // final response = await dio.get('$apiUrl/api/reportshoporder?datestart=$startDate&dateend=$endDate');
      final response =
          await dio.get('$apiUrl/api/reportshoporder', queryParameters: {
        'datestart': startDate,
        'dateend': endDate,
      });
      return Right(SaleModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
