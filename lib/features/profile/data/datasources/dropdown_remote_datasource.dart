import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

abstract class DropdownRemoteDatasource {
  Future<List<CategoryModel>> fetchCategory();
  Future<List<UnitModel>> fetchUnit();
}

class DropdownRemoteDatasourceImpl implements DropdownRemoteDatasource {
  final Dio dio = DioConfig.dioWithAuth;

  @override
  Future<List<CategoryModel>> fetchCategory() async {
    final response = await dio.get('/api/categorys');
    final List jsonList = response.data;
    return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
  }

  @override
  Future<List<UnitModel>> fetchUnit() async {
    final response = await dio.get('/api/productunits');
    final List jsonList = response.data;
    return jsonList.map((item) => UnitModel.fromJson(item)).toList();
  }
}
