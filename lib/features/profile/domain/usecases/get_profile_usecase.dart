import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:e_commerce/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Profile> call() async {
    return await repository.getProfile();
  }
}
