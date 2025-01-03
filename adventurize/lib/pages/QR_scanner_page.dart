import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:adventurize/components/cards/add_friend_card.dart';

class QRCodeScannerPage extends StatefulWidget {
  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage>
    with WidgetsBindingObserver {
  late MobileScannerController controller;
  String? avatarUrl; // To store the avatar URL of the scanned user
  String? username; // To store the username of the scanned user

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = MobileScannerController();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.start();
    } else if (state == AppLifecycleState.inactive) {
      controller.stop();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  void handleScannedData(String rawValue) {
    final Map<String, dynamic> data = {"avatarUrl": "", "username": "user123"};

    setState(() {
      avatarUrl = data['avatarUrl'];
      username = data['username'];
    });
  }

  Widget buildCameraFeed() {
    return MobileScanner(
      controller: controller,
      onDetect: (BarcodeCapture capture) {
        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          if (barcode.rawValue != null) {
            print('QR Code found: ${barcode.rawValue}');
            handleScannedData(barcode.rawValue!);
          }
        }
      },
    );
  }

  Widget buildOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget buildBackButton(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget buildAddFriendCard() {
    if (username != null && avatarUrl != null) {
      return AddFriendCard(
        avatarUrl: avatarUrl!,
        username: username!,
        onAddFriend: () {
          print("$username added");
        },
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildCameraFeed(),
          buildOverlay(),
          buildBackButton(context),
          buildAddFriendCard(),
        ],
      ),
    );
  }
}
