import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../widgets.dart';
import 'bank/topup_failed.dart';
import 'money/add_money.dart';


class CashIn extends StatefulWidget {
  const CashIn({Key? key}) : super(key: key);

  @override
  State<CashIn> createState() => _CashInState();
}

class _CashInState extends State<CashIn> {
  var currencyController = TextEditingController();
  var amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Top Up", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            //SizedBox(height: 20,),
            //MyWidgets.text("T", 18.0, FontWeight.bold, Color(0xff111111), context,false),
            SizedBox(height: 20,),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: GestureDetector(
                onTap: (){
                  //MyWidgets.navigateP(CCard(), context);
                },
                child: Row(
                  children: [

                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: IconButton(
                        icon: Image.asset('assets/21.png'),
                        iconSize: 25,
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Align(child: MyWidgets.text("Debit **** 7125", 20.0, FontWeight.normal, Color(0xff111111),context,false),alignment: Alignment.centerLeft,),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width * 0.8,
              //margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                  ],
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.75,
                          padding: EdgeInsets.fromLTRB(20,10,20,0),
                          child: Text(
                            "Set Amount",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: MF(20,context),
                                color: Color(0xff04123B)
                            ),
                          )

                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          controller: amountController,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "How much do you like to top up?",
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            hintStyle: TextStyle(
                                color: Color(0xff3B4652),
                                fontSize: MF(18, context)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      amountController.text = "10";
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 6,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,5),
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  spreadRadius: -5
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffEBEBEB)
                        ),
                        child: MyWidgets.text("\$10", 18.0, FontWeight.bold, Color(0xff04123B), context,false)
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      amountController.text = "50";
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 6,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,5),
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  spreadRadius: -5
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffEBEBEB)
                        ),
                        child: MyWidgets.text("\$50", 18.0, FontWeight.bold, Color(0xff04123B), context,false)
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      amountController.text = "100";
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 6,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,5),
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  spreadRadius: -5
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffEBEBEB)
                        ),
                        child: MyWidgets.text("\$100", 18.0, FontWeight.bold, Color(0xff04123B), context,false)
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      amountController.text = "500";
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 6,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,5),
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  spreadRadius: -5
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffEBEBEB)
                        ),
                        child: MyWidgets.text("\$500", 16.0, FontWeight.bold, Color(0xff04123B), context,false)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width * 0.8,
              //margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              decoration: BoxDecoration(

                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0,6),
                        color: Colors.black54,
                        blurRadius: 5,
                        spreadRadius: -5
                    ),
                  ],
                  color: Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.fromLTRB(20,10,20,0),
                          child: Text(
                            "Currency",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: MF(20, context),
                                color: Color(0xff04123B)
                            ),
                          )

                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: currencyController,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Currency",
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            hintStyle: TextStyle(
                                color: Color(0xff3B4652),
                                fontSize: MF(19, context)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.8,
              child: MyWidgets.button("Continue", (){
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color:Color(0xff04123B),
                        height: 60,
                        child: GestureDetector(
                          onTap: (){
                            MyWidgets.navigateP(TopUpFailed(),context);
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

class Topup extends StatefulWidget {
  const Topup({Key? key}) : super(key: key);

  @override
  State<Topup> createState() => _TopupState();
}

class _TopupState extends State<Topup> {
  Widget LTAccounts(type,typename,cardnumber,context){
    return GestureDetector(
      onTap: (){
        MyWidgets.navigatePR(CashIn(), context);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Color(0xff04123B),
                width: 1,
                style: BorderStyle.solid
            )
        ),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
        child: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child:Image.asset(type) ,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(alignment:Alignment.centerLeft,child: MyWidgets.text(typename, 23, FontWeight.normal, Color(0xff111111), context,true)),
                  Align(alignment:Alignment.centerLeft,child: MyWidgets.text(cardnumber, 18, FontWeight.normal, Color(0xff111111), context,true)),
                  //text
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Top Up", context),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            GestureDetector(
              onTap: ()async{
                //var converted= await Database.convertCurrency("USD", "PHP", "3");
                MyWidgets.navigatePR(CashInStore(), context);
              },
              child:Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child:Column(
                  children: [
                    MyWidgets.text("Top up on Store", 20, FontWeight.bold, Color(0xff111111), context, false),
                    SizedBox(height: 10,),

                  ],
                ),
              )
            ),
            SizedBox(height: 10,),
            LTAccounts("assets/21.png", "Visa", "Debit *****7125",context),
          ],
        ),
      ),
    );
  }
}