import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:e_commerce/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Profile> getProfile() async {
    return await remoteDataSource.fetchProfile();
  }

  @override
  Future<Either<Failure, void>> requestShop(String name, String tel) async {
    try {
      final result = await remoteDataSource.requestShop(name, tel);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> fetchStatus() async {
    return await remoteDataSource.fetchShopStatus();
  }
}
