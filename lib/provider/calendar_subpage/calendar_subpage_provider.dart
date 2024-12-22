import 'package:dw_flutter_app/model/calendar_subpages.dart';
import 'package:dw_flutter_app/provider/calendar_subpage/calendar_subpage_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final calendarSubpageProvider =
    StateNotifierProvider<CalendarSubpageNotifier, CalendarSubpage>(
  (ref) => CalendarSubpageNotifier(),
);
