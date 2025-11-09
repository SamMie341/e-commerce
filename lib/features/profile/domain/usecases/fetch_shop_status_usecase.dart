import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/profile/domain/repositories/profile_repository.dart';

class FetchShopStatusUseCase {
  final ProfileRepository repository;

  FetchShopStatusUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.fetchStatus();
  }
}
