import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/data/datasource/order_product_remote.dart';
import 'package:e_commerce/features/notification/data/model/order_product_model.dart';

abstract class OrderProductRepository {
  Future<List<OrderProductModel>> fetchOrderProduct();

  Future<List<OrderProductModel>> fetchAcceptProduct();

  Future<Either<Failure, bool>> acceptOrder(int orderId, int productstatusId,
      {String? comment});

  Future<OrderProductModel> fetchById(int id);
}

class OrderProductRepositoryImpl implements OrderProductRepository {
  final OrderProductRemote remoteDatasource;
  OrderProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<OrderProductModel>> fetchOrderProduct() async {
    return await remoteDatasource.fetchOrderProduct();
  }

  @override
  Future<List<OrderProductModel>> fetchAcceptProduct() async {
    return await remoteDatasource.fetchAcceptProduct();
  }

  @override
  Future<Either<Failure, bool>> acceptOrder(int orderId, int productstatusId,
      {String? comment}) async {
    try {
      final result = await remoteDatasource
          .acceptOrder(orderId, productstatusId, comment: comment);
      return Right(result);
    } on DioException {
      return Left(Failure('Cannot update status'));
    }
  }

  @override
  Future<OrderProductModel> fetchById(int id) async {
    return await remoteDatasource.fetchById(id);
  }
}
