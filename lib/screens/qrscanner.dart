import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:spotmii/screens/money.dart';
import 'package:spotmii/widgets.dart';
import 'QROverlay.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool scanned = false;
  String result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar1("Scan QR Code", context),
      body: Stack(
        children: [

          Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height ,
                child: MobileScanner(
                    allowDuplicates: false,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        //debugPrint('Failed to scan Barcode');
                      } else {
                        if(!scanned){
                          scanned = !scanned;
                          result = barcode.rawValue!;
                          MyWidgets.navigatePR( Send(recipient: result), context);
                        }
                      }
                    }
                ),
              ),
          ),
          Positioned(
            child:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  CustomPaint(
                    foregroundPainter: BorderPainter(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green[50]!.withOpacity(0.1),

                      ),
                      width: 250,
                      height: 250,

                    ),
                  ),
                  SizedBox(height: 200,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white,
                    ),
                    width: 200,
                    child: MyWidgets.text("Scan to Send!", 25, FontWeight.bold, Color(0xff111111), context, false)
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
