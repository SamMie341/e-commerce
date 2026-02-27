import 'package:e_commerce/core/utils/convert_color.dart';
import 'package:e_commerce/features/notification/data/model/sale_model.dart';
import 'package:e_commerce/features/notification/domain/usecase/get_sales_report_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SaleReportController extends GetxController {
  final GetSalesReportUseCase getSalesReportUseCase;

  SaleReportController(this.getSalesReportUseCase);

  var isLoading = false.obs;
  var salesData = Rxn<SaleModel>();

  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    fetchReport();
  }

  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      helpText: 'ເລືອກວັນທີເລີ່ມຕົ້ນ - ວັນທີສິ້ນສຸດ',
      saveText: 'ຕົກລົງ',
      initialDateRange:
          DateTimeRange(start: startDate.value, end: endDate.value),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: primaryColor,
                colorScheme: ColorScheme.light(primary: primaryColor),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary)),
            child: child!);
      },
    );
    if (picked != null) {
      startDate.value = picked.start;
      endDate.value = picked.end;
      fetchReport();
    }
  }

  void fetchReport() async {
    isLoading(true);

    String startStr = DateFormat('yyyy-MM-dd').format(startDate.value);
    String endStr = DateFormat('yyyy-MM-dd').format(endDate.value);

    final result = await getSalesReportUseCase(startStr, endStr);

    result.fold((failure) => null, (success) {
      isLoading(false);
      salesData.value = success;
    });
  }
}
