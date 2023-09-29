import 'package:flutter/material.dart';
import 'package:spotmii/screens/qr_code.dart';
import 'package:spotmii/widgets.dart';

import 'bank.dart';
import 'cards.dart';
import 'money.dart';

class Features extends StatefulWidget {
  const Features({Key? key}) : super(key: key);

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyWidgets.appbar("Features", context),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    MyWidgets.text("Current Balance", 25.0, FontWeight.w100, Color(0xff111111),context,false),
                    SizedBox(height: 5,),
                    MyWidgets.text("\$ 8,589.00", 40.0, FontWeight.bold, Color(0xff111111),context,false),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: GridView.count(
                        padding: EdgeInsets.zero,
                        primary: false,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 10,
                        crossAxisCount: 5,
                        children: <Widget>[
                          MyWidgets.feature(Image.asset('assets/5.png'), "Send", () {
                            MyWidgets.navigateP(Send(), context);
                          },Colors.black,context),
                          MyWidgets.feature(Image.asset('assets/6.png'), "Top up", () {
                            MyWidgets.navigateP(Topup(), context);
                          },Colors.black,context),
                          MyWidgets.feature(Image.asset('assets/7.png'), "Bank", () {
                            MyWidgets.navigateP(Bank(), context);
                          },Colors.black,context),
                          MyWidgets.feature(Image.asset('assets/8.png'), "Remittance", () {
                            MyWidgets.navigateP(Remittance(), context);
                          },Colors.black,context),
                          MyWidgets.feature(Image.asset('assets/9.png'), "Request", () {
                            MyWidgets.navigateP(Request(), context);
                          },Colors.black,context),
                          MyWidgets.feature(Image.asset('assets/44.png'), "My Cards", () {
                            MyWidgets.navigateP(CCard(), context);
                          },Colors.black,context),
                          MyWidgets.feature(Image.asset('assets/42.png'), "Currency", () {
                            MyWidgets.navigateP(Send(), context);
                          },Colors.black,context),
                          MyWidgets.feature(Image.asset('assets/41.png'), "Converter", () {
                            MyWidgets.navigateP(ConvertMoney(), context);
                          },Colors.black,context),
                          MyWidgets.feature(Image.asset('assets/43.png'), "QR Code", () {
                            MyWidgets.navigateP(QRCode(), context);
                          },Colors.black,context),
                          MyWidgets.feature(Image.asset('assets/withdraw.png'), "Withdraw", () {
                            MyWidgets.navigateP(Withdraw(), context);
                          },Colors.black,context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xff8A8A8A)
                ),
                child: MyWidgets.text("SAMPLE AD HERE", 20.0, FontWeight.normal, Colors.white, context,false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
