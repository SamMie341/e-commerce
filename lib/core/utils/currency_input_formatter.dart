import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String newText = newValue.text.replaceAll(',', '');
    if (int.tryParse(newText) == null) {
      return oldValue;
    }

    final formatter = NumberFormat('#,###');
    String newString = formatter.format(int.parse(newText));

    return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: newString.length));
  }
}
