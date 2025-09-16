import 'package:e_commerce/features/favorite/data/model/favor_request.dart';
import 'package:e_commerce/features/favorite/domain/repository/favor_repository.dart';

class toggleFavorUseCase {
  final FavorRepository repository;

  toggleFavorUseCase(this.repository);

  Future<void> call(FavoriteRequest request) {
    return repository.toggleFavor(request);
  }
}
