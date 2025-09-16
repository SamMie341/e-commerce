import 'package:e_commerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce/features/auth/domain/entities/user.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> login(String username, String password) {
    print('[Repository] calling data source....');
    return remoteDataSource.login(username, password);
  }
}
