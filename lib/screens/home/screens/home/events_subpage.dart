import 'package:dw_flutter_app/components/calendar/event_list.dart';
import 'package:dw_flutter_app/snackbar/snackbar_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dw_flutter_app/provider/config_provider.dart';
import 'package:dw_flutter_app/provider/contest_time_provider.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:dw_flutter_app/provider/selected_strings_provider.dart';
import 'package:dw_flutter_app/utility/string_utility.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../components/screen_description.dart';
import '../../../../provider/events_provider.dart';
import 'package:sprintf/sprintf.dart';

class EventsSubpage extends ConsumerWidget {
  EventsSubpage({super.key});
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static const registrationErrorSnackbar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    final strings = ref.watch(selectedStringsProvider);
    final contestTime = ref.watch(contestTimeProvider);
    final languageCode = ref.watch(languageProvider);
    final config = ref.watch(configProvider);

    return events.when(
      data: (events) {
        if (events.isEmpty) {
          return Center(
            child: Text(
              strings.empty,
            ),
          );
        }
        return ScaffoldMessenger(
          key: _scaffoldMessengerKey,
          child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                final String? url = config.value?.registrationLink;
                if (url != null) {
                  final Uri uri = Uri.parse(url);
                  try {
                    await launchUrl(uri);
                  } catch (e) {
                    SnackbarHelper.showSimpleSnackbar(
                      _scaffoldMessengerKey,
                      strings.registrationLinkError,
                      Colors.red,
                    );
                  }
                }
              },
              label: Text(strings.register),
              icon: const Icon(Icons.edit_outlined),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  ScreenDescription(
                    description: sprintf(strings.eventScreenDescription, [
                      formatDate(
                          contestTime.value != null
                              ? (contestTime.value as DateTime)
                              : DateTime.now(),
                          languageCode)
                    ]),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: EventList(
                      eventList: events,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        return Center(
          child: Text(
            strings.error,
          ),
        );
      },
    );
  }
}
