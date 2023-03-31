import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_provider.dart';

class ScanBottom extends StatelessWidget {
  const ScanBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.filter_center_focus, size: 40),
      onPressed: () async{
        //String barcodeScaneRes = await FlutterBarcodeScanner.scanBarcode(
        // '#3D8BEF', 'Salir', false, ScanMode.QR);
        final barcodeScaneRes = 'geo:4.099432,-76.197305';
        final scanProvider = Provider.of<ScanListProvider>(context, listen: false);

        scanProvider.nuevoScan(barcodeScaneRes);
      },
    );
  }
}