import 'package:dw_flutter_app/components/calendar/event_list_filter.dart';
import 'package:dw_flutter_app/components/calendar/job_card.dart';
import 'package:dw_flutter_app/constants/event_constants.dart';
import 'package:dw_flutter_app/model/job.dart';
import 'package:dw_flutter_app/provider/language/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../model/event.dart';
import 'event_card.dart';

class JobsList extends ConsumerStatefulWidget {
  const JobsList({
    super.key,
    required this.jobList,
  });

  final List<Job> jobList;

  @override
  ConsumerState<JobsList> createState() => _EventListState();
}

class _EventListState extends ConsumerState<JobsList> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.jobList.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.jobList.length) {
                return const SizedBox(height: 50);
              }
              return JobCard(
                title: widget.jobList[index].title,
                companyName: widget.jobList[index].companyName,
                companyLogo: widget.jobList[index].companyLogo!,
                salaryRange: widget.jobList[index].salaryRange,
                description: widget.jobList[index].description,
                offerUrl: widget.jobList[index].offerUrl,
              );
            },
          ),
        ),
      ],
    );
  }
}
