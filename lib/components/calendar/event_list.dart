import 'package:flutter/widgets.dart';

import '../../model/event.dart';
import 'event_card.dart';

class EventList extends StatelessWidget {
  const EventList({Key? key, required this.eventList}) : super(key: key);

  final List<Event> eventList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: eventList.length,
      itemBuilder: (context, index) {
        return EventCard(
          eventTitle: eventList[index].title,
          partner: eventList[index].partner,
          time: eventList[index].timeStart,
          room: eventList[index].room,
        );
      },
    );
  }
}
