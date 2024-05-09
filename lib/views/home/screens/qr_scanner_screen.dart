import 'dart:async';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:dw_flutter_app/extensions/log.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sprintf/sprintf.dart';
import '../../../auth/provider/user_id_provider.dart';
import '../../../constants/strings.dart';
import '../../../data/user_info_storage.dart';
import '../../../exceptions/task_already_finished.dart';
import '../../../exceptions/task_not_found.dart';
import '../../../exceptions/user_not_found.dart';
import '../../../model/task.dart';
import '../../../provider/tasks_provider.dart';
import '../../../snackbar/snackbar_helper.dart';

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});

  @override
  ConsumerState<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends ConsumerState<QrScannerScreen>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController();
  StreamSubscription<Object?>? _subscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  bool isScanningStopped = false;

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero) -
          const Offset(0, 100),
      width: scanArea,
      height: scanArea,
    );

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: Stack(
          children: [
            MobileScanner(
              scanWindow: scanWindow,
              controller: controller,
              errorBuilder: (context, error, child) {
                return _onError(context, error, child);
              },
            ),
            _buildScanWindow(scanArea),
          ],
        ),
      ),
    );
  }

  Widget _buildScanWindow(double scanArea) {
    return Container(
      decoration: ShapeDecoration(
        shape: QrScannerOverlayShape(
          cutOutSize: scanArea,
        ),
      ),
    );
  }

  Widget _onError(
      BuildContext context, MobileScannerException error, Widget? child) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      error.log();
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
            label: Strings.openSettings,
            textColor: Colors.black,
            backgroundColor: Colors.white,
            onPressed: () {
              AppSettings.openAppSettings();
            },
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    });
    return const SizedBox(
      child: Center(
        child: Icon(
          Icons.error,
          color: Colors.grey,
          size: 36.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = controller.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        unawaited(controller.start());
        _subscription = controller.barcodes.listen(_handleBarcode);
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(controller.stop());
        unawaited(_subscription?.cancel());
        _subscription = null;
    }
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);

    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;

    // Dispose the widget itself.
    super.dispose();

    // Finally, dispose of the controller.
    await controller.dispose();
  }

  void _handleBarcode(BarcodeCapture? barcode) {
    if (barcode == null || isScanningStopped) {
      return;
    }
    scanQrCode(
      barcode.barcodes.first.rawValue ?? '',
      ref.read(tasksProvider),
      const UserInfoStorage(),
    );
  }

  void scanQrCode(
    String qrCode,
    AsyncValue<List<Task>> allTasks,
    UserInfoStorage userInfoStorage,
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
                sprintf(
                  Strings.taskFinishedSuccessfullyWithPoints,
                  [finishedTask.title, finishedTask.points],
                ),
                Colors.green,
              );
            }
          } on UserNotFound catch (e) {
            e.message.log();
            if (context.mounted) {
              SnackbarHelper.showSimpleSnackbar(
                _scaffoldMessengerKey,
                Strings.errorPleaseLogOutAndTryAgain,
                Colors.red,
              );
            }
          } on TaskNotFound catch (e) {
            e.message.log();
            if (context.mounted) {
              SnackbarHelper.showSimpleSnackbar(
                _scaffoldMessengerKey,
                Strings.thisQrCodeIsNotValidPleaseTryAgain,
                Colors.red,
              );
            }
          } on TaskAlreadyFinished catch (e) {
            e.message.log();
            if (context.mounted) {
              SnackbarHelper.showSimpleSnackbar(
                _scaffoldMessengerKey,
                Strings.thisTaskHasAlreadyBeenCompleted,
                Colors.yellow[800]!,
              );
            }
          } catch (e) {
            e.log();
            if (context.mounted) {
              SnackbarHelper.showSimpleSnackbar(
                _scaffoldMessengerKey,
                Strings.unknownErrorPleaseTryAgain,
                Colors.red,
              );
            }
          } finally {
            // disable scanning for 2 seconds without stopping the camera
            isScanningStopped = true;
            await Future.delayed(const Duration(seconds: 4));
            isScanningStopped = false;
          }
        },
        orElse: () {
          'Tasks not loaded, failed to finish task'.log();
        },
      );
    }
  }
}

class QrScannerOverlayShape extends ShapeBorder {
  QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 10.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.borderRadius = 10,
    this.borderLength = 40,
    double? cutOutSize,
    double? cutOutWidth,
    double? cutOutHeight,
    this.cutOutBottomOffset = 0,
  })  : cutOutWidth = cutOutWidth ?? cutOutSize ?? 250,
        cutOutHeight = cutOutHeight ?? cutOutSize ?? 250 {
    assert(
      borderLength <=
          min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2,
      "Border can't be larger than ${min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2}",
    );
    assert(
      (cutOutWidth == null && cutOutHeight == null) ||
          (cutOutSize == null && cutOutWidth != null && cutOutHeight != null),
      'Use only cutOutWidth and cutOutHeight or only cutOutSize',
    );
  }

  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutWidth;
  final double cutOutHeight;
  final double cutOutBottomOffset;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final borderWidthSize = width / 2;
    final height = rect.height;
    final borderOffset = borderWidth / 2;
    final mBorderLength =
        borderLength > min(cutOutHeight, cutOutHeight) / 2 + borderWidth * 2
            ? borderWidthSize / 2
            : borderLength;
    final mCutOutWidth =
        cutOutWidth < width ? cutOutWidth : width - borderOffset;
    final mCutOutHeight =
        cutOutHeight < height ? cutOutHeight : height - borderOffset;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - mCutOutWidth / 2 + borderOffset,
      -cutOutBottomOffset +
          rect.top +
          height / 2 -
          mCutOutHeight / 2 +
          borderOffset,
      mCutOutWidth - borderOffset * 2,
      mCutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )

      // Draw top right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.top,
          cutOutRect.right,
          cutOutRect.top + mBorderLength,
          topRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )

      // Draw top left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.top,
          cutOutRect.left + mBorderLength,
          cutOutRect.top + mBorderLength,
          topLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )

      // Draw bottom right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.right,
          cutOutRect.bottom,
          bottomRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )

      // Draw bottom left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.left + mBorderLength,
          cutOutRect.bottom,
          bottomLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          Radius.circular(borderRadius),
        ),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
