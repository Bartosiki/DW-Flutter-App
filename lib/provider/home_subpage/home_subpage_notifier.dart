import 'package:dw_flutter_app/model/home_subpages.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeSubpageNotifier extends StateNotifier<HomeSubpage> {
  HomeSubpageNotifier() : super(HomeSubpage.homeEvents);

  void switchHomeSubpage() {
    state = state == HomeSubpage.homeEvents
        ? HomeSubpage.homeJobs
        : HomeSubpage.homeEvents;
  }

  void changeHomeSubpage(HomeSubpage subpage) {
    state = subpage;
  }
}
