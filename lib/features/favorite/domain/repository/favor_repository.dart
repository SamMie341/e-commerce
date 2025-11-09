import 'package:e_commerce/features/favorite/data/datasource/favor_remote_datasource.dart';
import 'package:e_commerce/features/favorite/data/model/favor_model.dart';
import 'package:e_commerce/features/favorite/data/model/favor_request.dart';

abstract class FavorRepository {
  Future<List<FavorModel>> fetchFavor();
  Future<void> toggleFavor(FavoriteRequest request);
}

class FavorRepositoryImpl implements FavorRepository {
  final FavorRemoteDatasource remoteDatasource;

  FavorRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<FavorModel>> fetchFavor() {
    return remoteDatasource.fetchFavor();
  }

  @override
  Future<void> toggleFavor(FavoriteRequest request) async {
    return await remoteDatasource.toggleFavor(request);
  }
}
