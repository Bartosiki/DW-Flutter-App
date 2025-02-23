import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../model/event.dart';
import 'event_card.dart';

class EventList extends ConsumerStatefulWidget {
  const EventList({
    super.key,
    required this.eventList,
  });

  final List<Event> eventList;

  @override
  ConsumerState<EventList> createState() => _EventListState();
}

class _EventListState extends ConsumerState<EventList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.eventList.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.eventList.length) {
                return const SizedBox(height: 50);
              }
              return EventCard(
                title: widget.eventList[index].title,
                partner: widget.eventList[index].partner,
                time: widget.eventList[index].timeStart,
                room: widget.eventList[index].room,
                category: widget.eventList[index].category,
                type: widget.eventList[index].type,
              );
            },
          ),
        ),
      ],
    );
  }
}
