import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/auth/domain/entities/user.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repositories.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String username, String password,
      String fcmToken, String platform, String model, bool rememberMe) async {
    return await repository.login(
        username, password, fcmToken, platform, model, rememberMe);
  }
}
