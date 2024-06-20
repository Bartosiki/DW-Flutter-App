import 'package:dw_flutter_app/components/calendar/event_list_filter.dart';
import 'package:dw_flutter_app/constants/event_constants.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
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
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final languageCode = ref.watch(languageProvider);

    List<Event> filteredEvents = widget.eventList
        .where((event) =>
            selectedCategory == null || event.category == selectedCategory)
        .toList();

    return Column(
      children: [
        EventListFilter(
          categories: EventConstants.getCategories(languageCode),
          selectedCategory: selectedCategory,
          onSelected: (category) {
            setState(
              () {
                if (category == null) {
                  selectedCategory = null;
                  return;
                }
                selectedCategory =
                    EventConstants.getUnifiedCategoryName(category);
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
