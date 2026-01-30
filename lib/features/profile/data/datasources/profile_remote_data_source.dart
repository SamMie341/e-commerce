import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> fetchProfile();
  Future<Either<Failure, void>> requestShop(String name, String tel);
  Future<Either<Failure, bool>> fetchShopStatus();
  Future<Either<Failure, List<OrderDetailModel>>> fetchHistory();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDataSource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<Profile> fetchProfile() async {
    final response = await _dio.get('/api/profile');

    if (response.statusCode == 200) {
      return Profile.fromJson(response.data);
    } else {
      throw Exception('Failed to load Profile');
    }
  }

  @override
  Future<Either<Failure, void>> requestShop(String name, String tel) async {
    try {
      final response = await _dio.post('/api/shops', data: {
        "name": name,
        "tel": tel,
      });
      if (response.statusCode != 200 && response.statusCode != 201) {
        return Left(Failure(e.toString()));
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> fetchShopStatus() async {
    try {
      final response = await _dio.get('/api/shops/checkshop');

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> jsonData = response.data;

        if (jsonData.containsKey('openshop') && jsonData['openshop'] is bool) {
          print('Shop status: ${jsonData['openshop']}');
          return Right(jsonData['openshop']);
        }
        return Left(Failure(
            'Invalid response format: "openshop" key is missing or not a boolean.'));
      }
      return Left(Failure(
          'Failed to fetch shop status. Status code: ${response.statusCode}'));
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An unexpected Dio error occurred.'));
    } catch (e) {
      return Left(Failure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<OrderDetailModel>>> fetchHistory() async {
    try {
      final response = await _dio.get('/api/orderfinish');
      if (response.statusCode == 200) {
        final List jsonList = response.data;
        final jsonData =
            jsonList.map((h) => OrderDetailModel.fromJson(h)).toList();
        return Right(jsonData);
      } else {
        final message = response.data['message'];
        return message;
      }
    } on DioException catch (e) {
      return Left(Failure(e.message ?? 'An Error Occurred'));
    }
  }
}
