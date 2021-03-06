import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class SpritzRace extends StatefulWidget {
  const SpritzRace({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SpritzRace> createState() => SpritzRaceState();
}

class SpritzRaceState extends State<SpritzRace> {
  String barcodeScanRes = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.camera_enhance),
              onPressed: () async {
                await FlutterBarcodeScanner.scanBarcode(
                        "#ffbf66", "Cancel", true, ScanMode.QR)
                    .then((qr) {
                  setState(() {
                    barcodeScanRes = qr;
                  });
                });
              }),
        ],
        automaticallyImplyLeading: true,
      ),
      body: Center(child: Text(barcodeScanRes)),
    );
  }
}
