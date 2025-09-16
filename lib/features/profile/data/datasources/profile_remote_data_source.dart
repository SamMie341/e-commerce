import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> fetchProfile();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDataSource {
  final DioConfig dioConfig;

  ProfileRemoteDatasourceImpl(this.dioConfig);

  @override
  Future<Profile> fetchProfile() async {
    final response = await DioConfig.dioWithAuth.get('/api/profile');

    if (response.statusCode == 200) {
      print('${Profile.fromJson(response.data)}');
      return Profile.fromJson(response.data);
    } else {
      throw Exception('Failed to load Profile');
    }
  }
}
