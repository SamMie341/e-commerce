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
  final Dio dioConfig = DioConfig.dioWithAuth;

  @override
  Future<List<FavorModel>> fetchFavor() async {
    final response = await DioConfig.dioWithAuth.get('/api/favorites');
    // print('Favor list: ${response.data}');
    // print('Favor runtimeType: ${response.runtimeType}');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => FavorModel.fromJson(json)).toList();
  }

  @override
  Future<void> toggleFavor(FavoriteRequest request) async {
    final response = await dioConfig.post(
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
