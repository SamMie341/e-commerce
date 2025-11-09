import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/core/utils/constant.dart';
import 'package:e_commerce/features/favorite/data/model/favor_model.dart';
import 'package:e_commerce/features/favorite/data/model/favor_request.dart';

abstract class FavorRemoteDatasource {
  Future<List<FavorModel>> fetchFavor();
  Future<void> toggleFavor(FavoriteRequest request);
}

class FavorRemoteDatasourceImpl implements FavorRemoteDatasource {
  final Dio _dio = DioConfig.dioWithAuth;

  @override
  Future<List<FavorModel>> fetchFavor() async {
    try {
      final response = await _dio.get('/api/favorites');
      if (response.data is! List) {
        return [];
      }
      final List<dynamic> jsonList = response.data;
      print('favor list: $jsonList');
      return jsonList
          .where((json) => json != null && json is Map<String, dynamic>)
          .map((json) => FavorModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      print('Dio error in fetchFavor: $e');
      throw Exception('Failed to load favorites');
    }
  }

  @override
  Future<void> toggleFavor(FavoriteRequest request) async {
    final response = await _dio.post(
      '$apiUrl/api/favorites',
      data: request.toJson(),
    );
    print(response.data);
    if (response.statusCode != 200) {
      print(response.statusCode);
      throw Exception('Fail to toggle favorite');
    }
  }
}
