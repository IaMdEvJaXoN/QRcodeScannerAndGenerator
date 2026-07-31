import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:proscan/Core/Utils/scanQr_utils/combine_time_and_payload.dart';
import 'package:proscan/Core/Utils/shared_utils/readable_time_display.dart';
import 'package:proscan/Core/Utils/scanQr_utils/scan_result_parser.dart';
import 'package:proscan/Core/Utils/scanQr_utils/scan_ui_mapper.dart';
import 'package:proscan/Core/Utils/scanQr_utils/scanfromgallery.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/decoded_string_provider.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/has_scanned_provider.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/zoom_control_provider.dart';
import 'package:proscan/Features/ScanQR/Presentation/Screens/scan_result.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/scan_qr_page_widgets/scanner_overlay.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/scan_qr_page_widgets/top_bar.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/scan_qr_page_widgets/zoom_control.dart';
import 'package:proscan/Features/Settings/Presentation/Providers/beep_notifier.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  late final MobileScannerController _mobileScannerController;
  late AudioPlayer _player;
  bool hasScanned = false;
  @override
  void initState() {
    super.initState();
    _mobileScannerController = MobileScannerController();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _mobileScannerController.dispose();
    _player.dispose();
    super.dispose();
  }

  void _onBarCodeDetected(BarcodeCapture capture) {
    if (hasScanned) {
      return;
    }
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) {
      return;
    }
    final String? rawValue = barcodes.first.rawValue;
    if (rawValue == null) {
      return;
    } else {
      final isBeepEnabled = ref.read(beepProvider);
      if (isBeepEnabled) {
        playBeep();
      }
      _mobileScannerController
          .stop(); //To minimise power wastage-Stopping the continuous scanning
      _handleDecodedValue(rawValue);
    }
  }

  Future<void> playBeep() async {
    await _player.play(AssetSource('sounds/click.mp3'));
  }

  void _handleDecodedValue(String rawValue) {
    final timeStamp = DateTime.now().toIso8601String();
    final combined = CombineTimeAndPayload.combine(timeStamp, rawValue);

    ref.read(decodedStringProvider.notifier).updateDecodedString(combined);
    ref.read(hasScannedProvider.notifier).updateScanState(true);
    navigateToScanResultScreen();
  }

  void navigateToScanResultScreen() {
    final decodedInfo = ref.read(decodedStringProvider);
    final data = ScanResultParser.parse(decodedInfo);
    final decodedMap = data.payload;
    final decodedPayload = decodedMap.values.join(', ');
    final contentType = data.contentType;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanResultScreen(
          decodedMap: decodedMap,
          decodedContent: decodedPayload,
          contentType: contentType,
          contentTypeIcon: data.contentTypeIcon,
          timestamp: ReadableTimeDisplay.toReadable(data.timestamp),
          verificationLabel: ScanResultUiMapper.verificationLabel(
            contentType,
            decodedPayload,
          ),
          primaryActionLabel: ScanResultUiMapper.primaryActionLabel(
            contentType,
          ),
          primaryActionIcon: ScanResultUiMapper.primaryActionIcon(contentType),
          statusTitle: ScanResultUiMapper.statusTitle(
            contentType,
            decodedPayload,
          ),
          statusDescription: ScanResultUiMapper.statusDescription(
            contentType,
            decodedPayload,
          ),
          statusIcon: ScanResultUiMapper.statusIcon(contentType),
        ),
      ),
    ).then((_) {
      ref.read(hasScannedProvider.notifier).updateScanState(false);
      _mobileScannerController.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    //decodedInfo = ref.watch(decodedStringProvider);
    //Listening to the current zoom value
    //ref.listen()-to prevent rebuilds.Riverpod triggers the callback only when the real value chanegs.
    ref.listen<double>(zoomControlProvider, (previous, next) {
      if (kIsWeb) {
        return;
      }
      try {
        _mobileScannerController.setZoomScale(next);
      } catch (e) {
        debugPrint('Error: $e');
      }
    });
    hasScanned = ref.watch(hasScannedProvider);
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: _mobileScannerController,
          onDetect: (barcodes) {
            _onBarCodeDetected(barcodes);
          },
        ),
        const ScannerOverlay(),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              ValueListenableBuilder(
                valueListenable: _mobileScannerController,
                builder: (context, value, child) {
                  return ScannerTopBar(
                    isTorchOn: value.torchState == TorchState.on,
                    onGalleryPressed: () async {
                      final decoded =
                          await ScanFromGallery.scanImageFromGallery(
                            _mobileScannerController,
                          );
                      if (decoded != null) {
                        _handleDecodedValue(decoded);
                      } else {
                        if (!context.mounted) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Scan From Gallery failed'),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    onTorchPressed: () {
                      if (kIsWeb) {
                        return;
                      }
                      try {
                        _mobileScannerController.toggleTorch();
                      } catch (e) {
                        debugPrint('$e');
                      }
                    },
                    onManualEntryPressed: () {},
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    'Align the QR code within the frame',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const ZoomControl(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
