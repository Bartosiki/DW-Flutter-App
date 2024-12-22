import 'package:dw_flutter_app/model/calendar_subpages.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarSubpageNotifier extends StateNotifier<CalendarSubpage> {
  CalendarSubpageNotifier() : super(CalendarSubpage.calendarEvents);

  void switchCalendarSubpage() {
    state = state == CalendarSubpage.calendarEvents
        ? CalendarSubpage.calendarJobs
        : CalendarSubpage.calendarEvents;
  }

  void changeCalendarSubpage(CalendarSubpage subpage) {
    state = subpage;
  }
}
