import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/domain/entities/categorys_entity.dart';

class CategoryRemoteDataSource {
  final DioConfig dio;
  CategoryRemoteDataSource(this.dio);

  Future<List<Category>> fetchAllCategory() async {
    final response = await DioConfig.dioWithAuth.get('/api/categorys');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}
