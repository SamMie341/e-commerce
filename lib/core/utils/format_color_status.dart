import 'package:flutter/material.dart';

class FormatColorStatus {
  static Color formatStatusColor(dynamic statusId) {
    switch (statusId) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.red;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.teal;
      case 5:
        return Colors.green;
      case 6:
        return Colors.purple;
      case 7:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static String formatStatusText(dynamic statusId) {
    switch (statusId) {
      case 1:
        return 'ສັ່ງຊື້ສຳເລັດ';
      case 2:
        return 'ຍົກເລີກ';
      case 3:
        return 'ລໍຖ້າຊຳລະ';
      case 4:
        return 'ຊຳລະເງິນສຳເລັດ';
      case 5:
        return 'ຊຳລະເງິນຖືກຕ້ອງ';
      case 6:
        return 'ສົ່ງສິນຄ້າສຳເລັດ';
      case 7:
        return 'ຮັບສິນຄ້າສຳເລັດ';
      default:
        return 'ບໍ່ມີສະຖານະ';
    }
  }
}
