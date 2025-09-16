import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
}
