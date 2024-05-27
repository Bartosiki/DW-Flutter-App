import 'package:dw_flutter_app/constants/event_constants.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:dw_flutter_app/utility/string_utility.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EventCard extends ConsumerWidget {
  const EventCard({
    super.key,
    required this.title,
    required this.partner,
    required this.time,
    required this.room,
    required this.category,
    required this.type,
  });

  final String title;
  final String partner;
  final DateTime time;
  final String room;
  final String category;
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageCode = ref.watch(languageProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        child: ClipRect(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..translate(20.0, -20.0)
                      ..rotateZ(-0.5),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: 0.15,
                      child: Icon(
                        EventConstants.getIcon(category),
                        size: 80,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(
                      right: 40.0,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      softWrap: true,
                    ),
                  ),
                  subtitle: Opacity(
                    opacity: 0.6,
                    child: Text(
                      partner,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        extractDateTime(time),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        getRoomAndType(room, type, languageCode),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
