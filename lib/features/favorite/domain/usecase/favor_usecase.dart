import 'package:e_commerce/features/favorite/data/model/favor_model.dart';
import 'package:e_commerce/features/favorite/domain/repository/favor_repository.dart';

class FavorUseCase {
  final FavorRepository repository;
  FavorUseCase(this.repository);

  Future<List<FavorModel>> call() async {
    return await repository.fetchFavor();
  }
}
