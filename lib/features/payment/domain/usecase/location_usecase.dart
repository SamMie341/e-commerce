import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/payment/data/models/location_model.dart';
import 'package:e_commerce/features/payment/domain/repository/payment_repository.dart';

class LocationUseCase {
  final PaymentRepository repository;

  LocationUseCase(this.repository);

  Future<Either<Failure, List<LocationModel>>> call() async {
    return await repository.fetchLocation();
  }
}
