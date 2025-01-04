import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:adventurize/components/cards/add_friend_card.dart';
import 'package:adventurize/database/db_helper.dart';
import 'package:adventurize/models/user_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class QRCodeScannerPage extends StatefulWidget {
  final User user;

  const QRCodeScannerPage({super.key, required this.user});
  
  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage>
    with WidgetsBindingObserver {
  late MobileScannerController controller;
  User? scannedUser; // To store the scanned User object

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

  void handleScannedData(String rawValue) async {
    try {
      // Assuming the rawValue is the email of the user
      final DatabaseHelper dbHelper = DatabaseHelper();
      final User? user = await dbHelper.getUsr(rawValue);

      if (user != null) {
        setState(() {
          scannedUser = user; // Store the scanned User object
        });
      } else {
        // Handle case where user is not found
        setState(() {
          scannedUser = null;
        });
        print('User not found.');
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
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
    if (scannedUser != null) {
      return AddFriendCard(
        user: scannedUser!,
        onAddFriend: () {
          DatabaseHelper().insFriend(widget.user.userID, scannedUser!.userID);
          print("${scannedUser!.username} added");
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
