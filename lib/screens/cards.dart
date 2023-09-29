import 'package:flutter/material.dart';
import 'package:spotmii/widgets.dart';

import 'home.dart';

class CCard extends StatefulWidget {
  const CCard({Key? key}) : super(key: key);

  @override
  State<CCard> createState() => _CCardState();
}

class _CCardState extends State<CCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("My Link Accounts", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [

              ],
            ),
            Container(
              child: Row(
                children: [
                  //icon,
                  Column(
                    children: [

                    ],
                  )
                ],
              ),
            )
            /*
            Container(
              margin: EdgeInsets.all(20),
              height: 170,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: MyWidgets.text("SAMPLE CARD", 20.0, FontWeight.normal, Colors.white, context)),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.8,
              child: MyWidgets.button("Deactivate", (){
                MyWidgets.navigateP(MyWidgets.congratulation("Congratulations", "Your card has been deactivated successfully. ", (){},context,"Home"), context);
              }, Color(0xff04123B),context),
            )
             */
          ],
        ),
      ),
    );
  }
}

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Add Card", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.centerLeft,
              child: MyWidgets.text("Link a card", 25.0, FontWeight.bold, Color(0xff3B4652),context,false),
            ),
            SizedBox(height: 40,),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
              child: MyWidgets.textField(controller, "Full Name", Color(0xff04123B),context)
            ),
            SizedBox(height: 10,),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyWidgets.textField(controller, "Debit Credit Card Number", Color(0xff04123B),context)
            ),
            SizedBox(height: 10,),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyWidgets.textField(controller, "Card Type", Color(0xff04123B),context)
            ),
            SizedBox(height: 10,),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyWidgets.textField(controller, "Expiration Date", Color(0xff04123B),context)
            ),
            SizedBox(height: 10,),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyWidgets.textField(controller, "Security Code", Color(0xff04123B),context)
            ),
            SizedBox(height: 50,),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 45,
                child: MyWidgets.button("Link a Card", (){
                  MyWidgets.navigateP(MyWidgets.congratulation("Congratulations", "Your card has been activated successfully. ", (){MyWidgets.navigateP(Home(), context);},context,"Home"), context);
                }, Color(0xff04123B),context)
            )
          ],
        ),
      ),
    );
  }
}

