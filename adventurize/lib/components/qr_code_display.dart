import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDisplay extends StatelessWidget {
  final String data; // The data to encode into the QR code
  final double size; // The size of the QR code

  const QRCodeDisplay({
    required this.data,
    this.size = 200.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        QrImageView(
          data: data,
          version: QrVersions.auto,
          size: size,
          gapless: false,
        ),
      ],
    );
  }
}
