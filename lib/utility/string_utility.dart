import 'package:dw_flutter_app/constants/event_constants.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}

String capitalizeEachWord(String s) {
  if (s.isEmpty) return s;
  return s.split(' ').map((word) => capitalize(word)).join(' ');
}

String extractDateTime(DateTime time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

String formatDate(DateTime date, String languageCode) {
  initializeDateFormatting(languageCode);
  String formatString = languageCode == 'pl' ? 'd MMMM yyyy' : 'MMMM d yyyy';
  return DateFormat(formatString, languageCode).format(date);
}

String getRoomAndType(String room, String type, String languageCode) {
  String translatedType = EventConstants.getTranslatedType(type, languageCode);
  return '$room, $translatedType';
}
