import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/features/favorite/data/model/favor_model.dart';
import 'package:e_commerce/features/favorite/data/model/favor_request.dart';

abstract class FavorRemoteDatasource {
  Future<Either<Failure, List<FavorModel>>> fetchFavor();
  Future<Either<Failure, void>> toggleFavor(FavoriteRequest request);
}

class FavorRemoteDatasourceImpl implements FavorRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<Either<Failure, List<FavorModel>>> fetchFavor() async {
    try {
      final response = await _dio.get('/api/favorites');
      if (response.statusCode == 200) {
        final List jsonList = response.data;
        final jsonData =
            jsonList.map((json) => FavorModel.fromJson(json)).toList();
        return Right(jsonData);
      } else {
        final message = response.data['message'] ?? 'Error To fetch Favorite';
        return Left(message);
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavor(FavoriteRequest request) async {
    try {
      final response = await _dio.post(
        '$apiUrl/api/favorites',
        data: request.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(null);
      } else {
        final message =
            response.data['message'] ?? 'ບໍ່ສາມາດເພີ່ມລາຍການທີ່ມັກໄດ້';
        return Left(Failure(message));
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
