import 'package:dw_flutter_app/auth/provider/user_id_provider.dart';
import 'package:dw_flutter_app/data/user_info_storage.dart';
import 'package:dw_flutter_app/exceptions/exception_with_message.dart';
import 'package:dw_flutter_app/extensions/log.dart';
import 'package:dw_flutter_app/provider/tasks_provider.dart';
import 'package:dw_flutter_app/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/strings.dart';
import '../../../model/task.dart';

class CameraScreen extends ConsumerWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const userInfoStorage = UserInfoStorage();

    final userInfo = ref.watch(userInfoProvider);
    final allTasks = ref.watch(tasksProvider);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            Strings.camera,
          ),
          TextButton(
            onPressed: () {
              scanQrCode(
                'secretqrcodewhat',
                allTasks,
                userInfoStorage,
                ref,
              );
            },
            child: const Text(
              'Finish task',
            ),
          ),
          userInfo.when(
            data: (userInfo) {
              return Column(
                children: [
                  Text(
                    "User ID: ${userInfo.userId}",
                  ),
                  Text(
                    userInfo.displayName,
                  ),
                  Text(
                    userInfo.email,
                  ),
                  Text(
                    "Points: ${userInfo.gainedPoints}",
                  )
                ],
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text(
              error.toString(),
            ),
          ),
        ],
      ),
    );
  }
}

void scanQrCode(
  String qrCode,
  AsyncValue<List<Task>> allTasks,
  UserInfoStorage userInfoStorage,
  WidgetRef ref,
) async {
  final userId = ref.read(userIdProvider);
  if (userId != null) {
    await allTasks.maybeWhen(
      data: (tasks) async {
        try {
          await userInfoStorage.finishTask(
            userId,
            qrCode,
            tasks,
          );
        } on ExceptionWithMessage catch (e) {
          e.message.log();
        } catch (e) {
          e.log();
        }
      },
      orElse: () {
        'Tasks not loaded, failed to finish task'.log();
      },
    );
  }
}
