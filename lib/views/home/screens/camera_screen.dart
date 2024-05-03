import 'package:dw_flutter_app/auth/provider/user_id_provider.dart';
import 'package:dw_flutter_app/auth/user_info_storage.dart';
import 'package:dw_flutter_app/exceptions/exception_with_message.dart';
import 'package:dw_flutter_app/extensions/log.dart';
import 'package:dw_flutter_app/provider/users/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/strings.dart';

class CameraScreen extends ConsumerWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const userInfoStorage = UserInfoStorage();

    final userInfo = ref.watch(userInfoProvider);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            Strings.camera,
          ),
          TextButton(
            onPressed: () async {
              final userId = ref.read(userIdProvider);
              if (userId != null) {
                try {
                  await userInfoStorage.finishTask(userId, 'secretqrcodewhat');
                } on ExceptionWithMessage catch (e) {
                  e.message.log();
                } catch (e) {
                  e.log();
                }
              }
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
