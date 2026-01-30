import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/notification/data/model/sale_model.dart';
import 'package:e_commerce/features/notification/domain/repository/report_repository.dart';

class GetSalesReportUseCase {
  final ReportRepository repository;

  GetSalesReportUseCase(this.repository);

  Future<Either<Failure, SaleModel>> call(
      String startDate, String endDate) async {
    return await repository.getSaleReport(startDate, endDate);
  }
}
