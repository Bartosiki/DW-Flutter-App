import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:dw_flutter_app/exceptions/user_not_found.dart';
import 'package:dw_flutter_app/extensions/log.dart';
import 'package:dw_flutter_app/snackbar/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../auth/provider/user_id_provider.dart';
import '../../../constants/strings.dart';
import '../../../data/user_info_storage.dart';
import '../../../exceptions/task_already_finished.dart';
import '../../../exceptions/task_not_found.dart';
import '../../../model/task.dart';
import '../../../provider/tasks_provider.dart';
import '../../../provider/user_info_provider.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final userInfoStorage = const UserInfoStorage();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 5,
            cutOutSize: scanArea,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        scanQrCode(
          context,
          result!.code ?? '',
          ref.watch(tasksProvider),
          userInfoStorage,
          ref,
        );
      });
    });
  }

  void _onPermissionSet(
    BuildContext context,
    QRViewController ctrl,
    bool isPermissionGranted,
  ) {
    if (!isPermissionGranted) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: const Text(
            Strings.cameraPermissionWasDenied,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: "Open settings",
            textColor: Colors.black,
            backgroundColor: Colors.white,
            onPressed: () {
              AppSettings.openAppSettings();
            },
          ),
        ),
      );
    }
  }

  void scanQrCode(
    BuildContext context,
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
            final finishedTask = await userInfoStorage.finishTask(
              userId,
              qrCode,
              tasks,
            );
            if (context.mounted) {
              SnackbarHelper.showSimpleSnackbar(
                _scaffoldMessengerKey,
                context,
                'Task ${finishedTask.title} finished successfully!',
                Colors.green,
              );
            }
          } on UserNotFound catch (e) {
            e.message.log();
            if (context.mounted) {
              SnackbarHelper.showSimpleSnackbar(
                _scaffoldMessengerKey,
                context,
                'Error, please log out and try again.',
                Colors.red,
              );
            }
          } on TaskNotFound catch (e) {
            e.message.log();
            if (context.mounted) {
              SnackbarHelper.showSimpleSnackbar(
                _scaffoldMessengerKey,
                context,
                'This QR code is not valid. Try scanning another one.',
                Colors.red,
              );
            }
          } on TaskAlreadyFinished catch (e) {
            e.message.log();
            if (context.mounted) {
              SnackbarHelper.showSimpleSnackbar(
                _scaffoldMessengerKey,
                context,
                'This task has already been finished. Try scanning another one.',
                Colors.yellow,
              );
            }
          } catch (e) {
            e.log();
            if (context.mounted) {
              SnackbarHelper.showSimpleSnackbar(
                _scaffoldMessengerKey,
                context,
                'Unknown error, please try again.',
                Colors.red,
              );
            }
          } finally {
            // disable scanning for 2 seconds
            Future.delayed(
              const Duration(seconds: 2),
              () {
                controller?.resumeCamera();
              },
            );
          }
        },
        orElse: () {
          'Tasks not loaded, failed to finish task'.log();
        },
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// @override
// Widget build(BuildContext context) {
//   const userInfoStorage = UserInfoStorage();
//
//   final userInfo = ref.watch(userInfoProvider);
//   final allTasks = ref.watch(tasksProvider);
//
//   return QRViewExample();

// return Center(
//   child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       const Text(
//         Strings.camera,
//       ),
//       TextButton(
//         onPressed: () {
//           // scanQrCode(
//           //   'secretqrcodewhat',
//           //   allTasks,
//           //   userInfoStorage,
//           //   ref,
//           // );
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => const QRViewExample(),
//             ),
//           );
//         },
//         child: const Text(
//           'Finish task',
//         ),
//       ),
//       userInfo.when(
//         data: (userInfo) {
//           return Column(
//             children: [
//               Text(
//                 "User ID: ${userInfo.userId}",
//               ),
//               Text(
//                 userInfo.displayName,
//               ),
//               Text(
//                 userInfo.email,
//               ),
//               Text(
//                 "Points: ${userInfo.gainedPoints}",
//               )
//             ],
//           );
//         },
//         loading: () => const CircularProgressIndicator(),
//         error: (error, stackTrace) => Text(
//           error.toString(),
//         ),
//       ),
//     ],
//   ),
// );
// }
