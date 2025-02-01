import 'package:dw_flutter_app/model/home_subpages.dart';
import 'package:dw_flutter_app/provider/home_subpage/home_subpage_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeSubpageProvider =
    StateNotifierProvider<HomeSubpageNotifier, HomeSubpage>(
  (ref) => HomeSubpageNotifier(),
);
