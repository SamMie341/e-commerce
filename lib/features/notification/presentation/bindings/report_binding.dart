import 'package:e_commerce/features/notification/data/datasource/report_remote_datasource.dart';
import 'package:e_commerce/features/notification/domain/repository/report_repository.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_sales_report_usecase.dart';
import 'package:e_commerce/features/notification/presentation/controller/sale_report_controller.dart';
import 'package:get/get.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportRemoteDatasource>(() => ReportRemoteDataSourceImpl());
    Get.lazyPut<ReportRepository>(() => ReportRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetSalesReportUseCase(Get.find()));
    Get.lazyPut(() => SaleReportController(Get.find()));
  }
}
