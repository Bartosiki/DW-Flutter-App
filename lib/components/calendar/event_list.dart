import 'package:dw_flutter_app/components/calendar/event_list_filter.dart';
import 'package:dw_flutter_app/constants/event_constants.dart';
import 'package:flutter/material.dart';
import '../../model/event.dart';
import 'event_card.dart';

class EventList extends StatefulWidget {
  const EventList({
    super.key,
    required this.eventList,
  });

  final List<Event> eventList;

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    List<Event> filteredEvents = widget.eventList
        .where((event) =>
            selectedCategory == null || event.category == selectedCategory)
        .toList();

    return Column(
      children: [
        EventListFilter(
          categories: EventConstants.getCategories(),
          selectedCategory: selectedCategory,
          onSelected: (category) {
            setState(
              () {
                selectedCategory = category;
              },
            );
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredEvents.length + 1,
            itemBuilder: (context, index) {
              if (index == filteredEvents.length) {
                return const SizedBox(height: 50);
              }
              return EventCard(
                title: filteredEvents[index].title,
                partner: filteredEvents[index].partner,
                time: filteredEvents[index].timeStart,
                room: filteredEvents[index].room,
                category: filteredEvents[index].category,
                type: filteredEvents[index].type,
              );
            },
          ),
        ),
      ],
    );
  }
}
