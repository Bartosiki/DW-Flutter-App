import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../constants/strings.dart';

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

// void scanQrCode(
//   String qrCode,
//   AsyncValue<List<Task>> allTasks,
//   UserInfoStorage userInfoStorage,
//   WidgetRef ref,
// ) async {
//   final userId = ref.read(userIdProvider);
//   if (userId != null) {
//     await allTasks.maybeWhen(
//       data: (tasks) async {
//         try {
//           await userInfoStorage.finishTask(
//             userId,
//             qrCode,
//             tasks,
//           );
//         } on ExceptionWithMessage catch (e) {
//           e.message.log();
//         } catch (e) {
//           e.log();
//         }
//       },
//       orElse: () {
//         'Tasks not loaded, failed to finish task'.log();
//       },
//     );
//   }
// }
