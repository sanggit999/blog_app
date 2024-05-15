import 'package:intl/intl.dart';

String formatDateByDDMMYYYY(DateTime dateTime) {
  return DateFormat("dd/MM/yyyy").format(dateTime);
}
