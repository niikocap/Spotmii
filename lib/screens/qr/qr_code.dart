import 'package:flutter/material.dart';
import 'package:spotmii/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/constants.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("QR Code", context),
      body:SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children:[
            const SizedBox(height: 40,),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: const Color(0xff04123B),
                borderRadius: BorderRadius.circular(10)
              ),
              child: MyWidgets.text("SCAN ME", 45.0, FontWeight.bold, Colors.white,context,false),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xff04123B),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: QrImageView(
                      // ignore: deprecated_member_use
                      foregroundColor: Colors.white,
                      data: currentUser!.email,
                      version: QrVersions.auto,
                      size: 250.0,
                    ),

                  ),
                  const SizedBox(height: 40,),
                  Container(
                    child: MyWidgets.text("Ask the sender to scan the QR Code", 21.0, FontWeight.bold, const Color(0xff040606),context,false),
                  ),
                ],
              ),
            ),

          ]
        ),
      ),

    );
  }
}
