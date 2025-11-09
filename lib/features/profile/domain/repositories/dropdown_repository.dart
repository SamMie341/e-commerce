import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/profile/data/datasources/dropdown_remote_datasource.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

abstract class DropdownRepository {
  Future<List<CategoryModel>> fetchCategory();
  Future<List<UnitModel>> fetchUnit();
}

class DropdownRepositoryImpl implements DropdownRepository {
  final DropdownRemoteDatasource remote;
  DropdownRepositoryImpl(this.remote);

  @override
  Future<List<CategoryModel>> fetchCategory() async {
    return await remote.fetchCategory();
  }

  @override
  Future<List<UnitModel>> fetchUnit() async {
    return await remote.fetchUnit();
  }
}
