import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/favorite/data/datasource/favor_remote_datasource.dart';
import 'package:e_commerce/features/favorite/data/model/favor_model.dart';
import 'package:e_commerce/features/favorite/data/model/favor_request.dart';

abstract class FavorRepository {
  Future<Either<Failure, List<FavorModel>>> fetchFavor();
  Future<Either<Failure, void>> toggleFavor(FavoriteRequest request);
}

class FavorRepositoryImpl implements FavorRepository {
  final FavorRemoteDatasource remoteDatasource;

  FavorRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<FavorModel>>> fetchFavor() async {
    return await remoteDatasource.fetchFavor();
  }

  @override
  Future<Either<Failure, void>> toggleFavor(FavoriteRequest request) async {
    return await remoteDatasource.toggleFavor(request);
  }
}
