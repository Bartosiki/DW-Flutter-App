import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssistantScreen extends ConsumerWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text(
        Strings.assistant,
      ),
    );
  }
}
