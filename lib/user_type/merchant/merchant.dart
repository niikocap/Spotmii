import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:spotmii/widgets.dart';
import '../../components/constants.dart';
import '../../screens/qr/QROverlay.dart';
import 'package:spotmii/database.dart';

import '../../screens/auth/login.dart';

class Merchant extends StatefulWidget {
  const Merchant({super.key});

  @override
  State<Merchant> createState() => _MerchantState();
}

class _MerchantState extends State<Merchant> {
  var totalSales = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyWidgets.text("Merchant Home", 22.5, FontWeight.bold, Colors.black, context, false),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(99)
            ),
            margin: EdgeInsets.all(12.5),
            padding: const EdgeInsets.symmetric(horizontal: 5.5,vertical: 0),
            child: IconButton(onPressed:(){
              MyWidgets.navigatePR(Login(), context);
            },icon: Icon(Icons.logout_outlined,size: 20,)),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      MyWidgets.text("Total Cash In :", 25, FontWeight.bold, Color(0xff111111), context, false),
                      SizedBox(width: 10,),
                      MyWidgets.text(totalSales.toString(), 25, FontWeight.bold, Color(0xff111111), context, false),
                    ],
                  ),
                  Row(
                    children: [
                      MyWidgets.text("Total Cash Out :", 25, FontWeight.bold, Color(0xff111111), context, false),
                      SizedBox(width: 10,),
                      MyWidgets.text(totalSales.toString(), 25, FontWeight.bold, Color(0xff111111), context, false),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                MyWidgets.navigateP(MerchantScan(type: "topup",), context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0,0),
                      blurRadius: 2,
                      color: Colors.grey.withOpacity(0.5)
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Icon(Icons.qr_code_scanner_rounded,size: 30,color: Colors.green,),
                    SizedBox(width: 20,),
                    MyWidgets.text("Process Cash In", 20, FontWeight.bold, Color(0xff111111), context, false),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                MyWidgets.navigateP(MerchantScan(type: "cashout",), context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,0),
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5)
                      )
                    ]
                ),
                child: Row(
                  children: [
                    Icon(Icons.qr_code_scanner_rounded,size: 30,color: Colors.red,),
                    SizedBox(width: 20,),
                    MyWidgets.text("Process Cash Out", 20, FontWeight.bold, Color(0xff111111), context, false),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class MerchantScan extends StatefulWidget {
  final type;
  const MerchantScan({required this.type});

  @override
  State<MerchantScan> createState() => _MerchantScanState();
}

class _MerchantScanState extends State<MerchantScan> {
  bool scanned = false;
  String result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar1("Merchant QR Scan", context),
      body: Stack(
        children: [

          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height ,
              child: MobileScanner(
                  allowDuplicates: false,
                  onDetect: (barcode, args) async{
                    if (barcode.rawValue == null) {
                      //debugPrint('Failed to scan Barcode');
                    } else {
                      if(!scanned){
                        scanned = !scanned;
                        result = barcode.rawValue!;
                        var response;
                        if(widget.type == "topup"){
                          response = await Database(url:url).send({
                            "req" : "topupsuccess",
                            "transaction" : result,
                            "cashierID" : currentUser!.userID
                          });
                        }else{
                          response = await Database(url:url).send({
                            "req" : "withdraw",
                            "transaction" : result,
                            "cashierID" : currentUser!.userID
                          });
                        }
                        print(response);
                        if(response == "\"success\""){
                          showModalBottomSheet(isDismissible:false,context: context, builder: (context){
                            return Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 30,),
                                  Image.asset(
                                    "assets/3.png",
                                    height: 120,
                                  ),
                                  SizedBox(height: 20,),
                                  MyWidgets.text("Transaction Success!", 25, FontWeight.bold, Color(0xff111111), context, false),
                                  SizedBox(height: 20,),
                                  FractionallySizedBox(
                                    widthFactor: 0.85,
                                    child: MyWidgets.button("Scan New", (){
                                      scanned = false;
                                      Navigator.pop(context);
                                    }, Color(0xff04123B), context),
                                  )
                                ],
                              ),
                            );
                          });
                        }else{
                          showModalBottomSheet(isDismissible:false, context: context, builder: (context){
                            return Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 30,),
                                  Image.asset(
                                    "assets/failed.png",
                                    height: 120,
                                  ),
                                  SizedBox(height: 20,),
                                  MyWidgets.text("Transaction Failed!", 25, FontWeight.bold, Color(0xff111111), context, false),
                                  SizedBox(height: 20,),
                                  FractionallySizedBox(
                                    widthFactor: 0.85,
                                    child: MyWidgets.button("Retry", (){
                                      scanned = false;
                                      Navigator.pop(context);
                                    }, Color(0xff04123B), context),
                                  )
                                ],
                              ),
                            );
                          });
                        }

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
                      width: 220,
                      height: 220,

                    ),
                  ),
                  SizedBox(height: 300,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                      ),
                      width: 250,
                      child: MyWidgets.text("Scan to start transaction!", 20, FontWeight.bold, Color(0xff111111), context, false)
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
