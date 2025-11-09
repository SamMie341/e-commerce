import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/domain/entities/categorys_entity.dart';

class CategoryRemoteDataSource {
  final Dio _dio = DioConfig.dioWithAuth;
  Future<List<Category>> fetchAllCategory() async {
    final response = await _dio.get('/api/categorys');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}
