import 'package:e_commerce/features/home/data/models/product_model.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:e_commerce/features/profile/domain/repositories/dropdown_repository.dart';

class DropdownUseCase {
  final DropdownRepository repository;

  DropdownUseCase(this.repository);

  Future<List<CategoryModel>> category() async {
    return await repository.fetchCategory();
  }

  Future<List<UnitModel>> unit() async {
    return await repository.fetchUnit();
  }
}
