import 'package:flutter/material.dart';
import 'package:spotmii/screens/bank/transfer.dart';
import '../../widgets.dart';

class Bank extends StatefulWidget {
  const Bank({Key? key}) : super(key: key);

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Bank", context),
      body: Column(
        children: [
          const SizedBox(height: 40,),
          MyWidgets.text("Select Partner Banks", 17.0, FontWeight.bold, const Color(0xff111111), context,false),
          //row temporary
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  MyWidgets.navigateP(const BankTransfer(), context);
                },
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child:  Image.network("https://1000logos.net/wp-content/uploads/2018/08/anz-bank-logo.jpg"),
                ),
              )

            ],
          )
        ],
      ),
    );
  }
}