import 'package:flutter/material.dart';
import 'package:spotmii/screens/info.dart';
import 'package:spotmii/widgets.dart';

class PaymentDetails extends StatefulWidget {
  final String amount;
  final String sender;
  final String transaction;
  final String currency;
  final String date;
  const PaymentDetails({required this.amount,required this.sender,required this.transaction,required this.currency,required this.date});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  text(first,second){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyWidgets.text(first, 15.0, FontWeight.normal, Color(0xff3B4652),context,false),
          MyWidgets.text(second, 15.0, FontWeight.normal, Color(0xff3B4652),context,false),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Payment Details", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20,),
            IconButton(
              icon: Image.asset('assets/3.png'),
              iconSize: 80,
              onPressed: () {},
            ),
            MyWidgets.text("Success!", 30.0, FontWeight.normal, Color(0xff111111),context,false),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff051D40),
              ),
              alignment: Alignment.center,
              height: 80,
              width: MediaQuery.of(context).size.width * 0.90,

              child: MyWidgets.text("${widget.currency} ${widget.amount}", 35.0, FontWeight.bold, Colors.white,context,false),
            ),
            SizedBox(height: 30,),
            Container(
              child: Column(
                children: [
                  text("Our fee","\$ 2.96"),
                  //text("We Converted","317.04"),
                  //text("Exchange rate","${widget.amount - 2.96}"),
                  //SizedBox(height: 30,),
                  text("Receiver received",(int.parse(widget.amount) - 2.96).toString()),
                  text("Sender Name",widget.sender),
                  //text("Account Number",widget.s),
                  SizedBox(height: 30,),
                  text("Transaction Number",widget.transaction),
                  text("Date",widget.date),
                  //Container(width: MediaQuery.of(context).size.width * 0.90,alignment:Alignment.centerLeft,child: MyWidgets.text("25 March 2023 at 7:02 PM",15.0, FontWeight.normal, Color(0xff3B4652),context,false)),
                ],
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.90,
              child: MyWidgets.button("Download Receipt", (){}, Color(0xff04123B),context),
            ),
            SizedBox(height: 20,),
            TextButton(
                onPressed: (){
                  MyWidgets.navigateP(TalkToOurTeam(), context);
                },
                child: MyWidgets.text("Report this transaction", 18.0, FontWeight.bold, Color(0xff1B1B1B),context,false)
            )
          ],
        ),
      ),
    );
  }
}
