import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/custom_form.dart';
import '../../widgets.dart';
import '../home.dart';

class Remittance extends StatefulWidget {
  const Remittance({Key? key}) : super(key: key);

  @override
  State<Remittance> createState() => _RemittanceState();
}

class _RemittanceState extends State<Remittance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Remittance", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    child: Image.network("https://cdn.freebiesupply.com/logos/large/2x/western-union-1-logo-png-transparent.png")
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    MyWidgets.text("Western Union", 17.0, FontWeight.bold, Color(0xff3B4652), context,false),
                    MyWidgets.text("Any Remittance Centers", 15.0, FontWeight.bold, Color(0xff3B4652), context,false),
                  ],
                ),

                //to be added
              ],
            ),
            SizedBox(height: 40,),
            Center(
              child: CustomFormWidget(controller: TextEditingController,),
            ),
            SizedBox(height: 30,),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Column(
                    children: [
                      Container(width:MediaQuery.of(context).size.width * 0.85,alignment:Alignment.centerLeft,child: MyWidgets.text("Recipient's Full Name:", 16.0, FontWeight.bold, Color(0xff3B4652), context,false)),
                      SizedBox(height: 10,),
                      Container(
                        width:MediaQuery.of(context).size.width * 0.85,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,6),
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  spreadRadius: -5
                              ),
                            ]
                        ),
                        child: TextField(

                            decoration: InputDecoration(
                                hintText: "Enter Full Name",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: MF(17, context),
                                    fontFamily: "Poppins"
                                )
                            )
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    children: [
                      Container(width:MediaQuery.of(context).size.width * 0.85,alignment:Alignment.centerLeft,child: MyWidgets.text("Recipient's Contact Number:", 16.0, FontWeight.bold, Color(0xff3B4652), context,false)),
                      SizedBox(height: 10,),
                      Container(
                        width:MediaQuery.of(context).size.width * 0.85,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,6),
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  spreadRadius: -5
                              ),
                            ]
                        ),
                        child: TextField(

                            decoration: InputDecoration(
                                hintText: "Enter Mobile Number",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: MF(17, context),
                                    fontFamily: "Poppins"
                                )
                            )
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    children: [
                      Container(width:MediaQuery.of(context).size.width * 0.85,alignment:Alignment.centerLeft,child: MyWidgets.text("Recipient's Address:", 16.0, FontWeight.bold, Color(0xff3B4652), context,false)),
                      SizedBox(height: 10,),
                      Container(
                        width:MediaQuery.of(context).size.width * 0.85,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Color(0xffEBEBEB),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,6),
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  spreadRadius: -5
                              ),
                            ]
                        ),
                        child: TextField(

                            decoration: InputDecoration(
                                hintText: "Enter Address",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: MF(17, context),
                                    fontFamily: "Poppins"
                                )
                            )
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(width:MediaQuery.of(context).size.width * 0.8,alignment:Alignment.centerLeft,child: MyWidgets.text("Fee \$10", 18.0, FontWeight.bold, Color(0xff3B4652), context,false)),
                  SizedBox(height: 20),
                  MyWidgets.text("Please verify the accuracy and completeness of the details before you proceed.", 14.0, FontWeight.normal, Color(0xff111111), context,false),
                  SizedBox(height: 20),
                  SizedBox(
                    height:40,
                    width:MediaQuery.of(context).size.width * 0.85,
                    child: MyWidgets.button("Send Money", (){
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color:Color(0xff04123B),
                              height: 60,
                              child: GestureDetector(
                                onTap: (){
                                  MyWidgets.navigateP(MyWidgets.congratulation("Success!", "Your money has been successfully sent.", (){MyWidgets.navigateP(Home(), context);}, context,"Home"), context);
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
            )
          ],
        ),
      ),
    );
  }
}