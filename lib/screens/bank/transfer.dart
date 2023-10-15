import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../../components/custom_form.dart';
import '../../widgets.dart';
import 'package:spotmii/screens/bank/topup_failed.dart';

class BankTransfer extends StatefulWidget {
  const BankTransfer({Key? key}) : super(key: key);

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  var controller = TextEditingController();
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    '50',
    '100',
    '150',
    '200',
    '250',
    '30x0',
  ];
  //var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Bank Transfer", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            FractionallySizedBox(widthFactor:0.9,child: MyWidgets.text("ANZ – Australia and New Zealand Banking Group", 17.0, FontWeight.bold, Color(0xff111111), context,false)),
            SizedBox(height: 10,),
            Center(child: CustomFormWidget(controller: controller,)),
            SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(

                  ),
                  enabledBorder: UnderlineInputBorder(

                  ),
                  errorBorder: UnderlineInputBorder(

                  ),
                  hintText: "Account Name:",
                  hintStyle: TextStyle(
                      color: Color(0xff04123B),
                      fontSize: MF(17,context),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(

                  ),
                  enabledBorder: UnderlineInputBorder(

                  ),
                  errorBorder: UnderlineInputBorder(

                  ),
                  hintText: "Account Number:",
                  hintStyle: TextStyle(
                      color: Color(0xff04123B),
                      fontSize: MF(17,context),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(width:MediaQuery.of(context).size.width * 0.8,child: MyWidgets.text("Please verify the accuracy and completeness of the details before you proceed.", 15.0, FontWeight.normal, Color(0xff111111), context,false)),
            SizedBox(height: 30),
            SizedBox(
              height:40,
              width:MediaQuery.of(context).size.width * 0.80,
              child: MyWidgets.button("Send Money", (){
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color:Color(0xff04123B),
                        height: 60,
                        child: GestureDetector(
                          onTap: (){
                            MyWidgets.navigatePR(TopUpFailed(), context);
                          },
                          child: Center(
                            child: MyWidgets.text("Continue", 25.0, FontWeight.bold, Colors.white,context,false),
                          ),
                        ),
                      );
                    });
              }, Color(0xff04123B),context),
            )
          ],
        ),
      ),
    );
  }
}