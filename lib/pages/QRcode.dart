// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:safeer/components/drawer.dart';

class BarcodeScannerPage extends StatelessWidget {
  const BarcodeScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Is it Halal ?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff5E17EB),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String barcode = await FlutterBarcodeScanner.scanBarcode(
              '#2A99CF',
              'Cancel',
              true,
              ScanMode.BARCODE,
            );

            if (barcode.isNotEmpty) {
              _handleScanResult(context, barcode);
            } else {
              _showFailDialog(context);
            }
          },
          child: const Text("Scan Barcode"),
        ),
      ),
    );
  }

  void _handleScanResult(BuildContext context, String barcode) {
    String message;
    DialogType dialogType;
    String desc;

    if (barcode == "123456") {
      message = "Halal";
      desc = "You can eat this food";
      dialogType = DialogType.success;
    } else if (barcode == "654321") {
      message = "Haram";
      desc = "You cannot eat this food!!!";
      dialogType = DialogType.error;
    } else {
      message = "Scan Canceled";
      desc = "The scan operation was not completed.";
      dialogType = DialogType.warning;
    }

    _showAwesomeDialog(context, message, dialogType, desc);
  }

  void _showAwesomeDialog(BuildContext context, String message,
      DialogType dialogType, String desc) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: message,
      desc: desc,
      btnOkText: 'Close',
      btnOkOnPress: () {},
    ).show();
  }

  void _showFailDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Scan Failed',
      desc: 'The scan operation was not completed.',
      btnOkText: 'Close',
      btnOkOnPress: () {},
    ).show();
  }
}
