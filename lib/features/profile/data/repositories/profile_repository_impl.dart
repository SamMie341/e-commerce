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
}
