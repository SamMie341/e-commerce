import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/data/datasource/report_remote_datasource.dart';
import 'package:e_commerce/features/notification/data/model/sale_model.dart';

abstract class ReportRepository {
  Future<Either<Failure, SaleModel>> getSaleReport(
      String startDate, String endDate);
}

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDatasource remoteDatasource;
  ReportRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, SaleModel>> getSaleReport(
      String startDate, String endDate) async {
    return await remoteDatasource.getSalesReport(startDate, endDate);
  }
}
