import 'package:intl/intl.dart';

class StringFormatters {
  static String currency(double? value) {
    value ??= 0;
    final formatter = NumberFormat('#,##0.00');
    final formattedString = formatter.format(value);
    return '\$$formattedString';
  }

  static String dateDDMMYYYY(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static String dateYYYY(DateTime date) {
    final formatter = DateFormat('yyyy');
    return formatter.format(date);
  }

  static String namedDate(DateTime date) {
    final formatter = DateFormat('dd/MMMM/yyyy', 'es');
    return formatter.format(date);
  }

  static String yearDate(DateTime date) {
    final formatter = DateFormat('yyyy', 'es');
    return formatter.format(date);
  }

  static String percent(double? percent) {
    percent ??= 0;
    final limitedPercent = percent.floor();
    if (limitedPercent == 0) return '${(percent * 100).toStringAsFixed(0)}%';
    return '${(percent * 100).toStringAsFixed(2)}%';
  }
}
