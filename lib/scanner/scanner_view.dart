import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nubank_scanner/scanner/guide_overlay.dart';
import 'package:nubank_scanner/scanner/scanner_view_model.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  final viewModel = ScannerViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.scanController.start();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    viewModel.scanController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 250,
      height: 250,
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: MobileScanner(
              controller: viewModel.scanController,
              scanWindow: scanWindow,
              errorBuilder: (context, error, child) {
                return const Center(
                  child: Text("Error"),
                );
              },
              onDetect: viewModel.onCameraDetect,
            ),
          ),
          CustomPaint(
            painter: GuideOverlay(scanWindow: scanWindow),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 128),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey.shade100,
                    ),
                  ),
                  Text(
                    "Aponte a camera \n para o QrCode",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: IconButton(
                  onPressed: () => viewModel.onBackPage(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey.shade200,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
