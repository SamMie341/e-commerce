import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:e_commerce/features/transaction/data/model/order_detail_model.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
  Future<Either<Failure, void>> requestShop(String name, String tel);
  Future<Either<Failure, bool>> fetchStatus();
  Future<Either<Failure, List<OrderDetailModel>>> fetchHistory();
}
