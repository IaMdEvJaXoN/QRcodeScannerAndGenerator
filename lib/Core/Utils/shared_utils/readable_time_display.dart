import 'package:intl/intl.dart';

class ReadableTimeDisplay {
  ReadableTimeDisplay._();
  static String toReadable(String isoTimestamp) {
    final dateTime = DateTime.tryParse(isoTimestamp);
    if (dateTime == null) return isoTimestamp;

    return DateFormat('MMM d, yyyy • h:mm a').format(dateTime);
  }
}
