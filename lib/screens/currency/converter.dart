import 'package:flutter/material.dart';
import 'package:forex_conversion/forex_conversion.dart';

import '../../components/constants.dart';
import '../../components/text.dart';
import '../../database.dart';
import '../../models/currency.dart';
import '../../widgets.dart';
import '../home.dart';

class ConvertMoney extends StatefulWidget {
  const ConvertMoney({Key? key}) : super(key: key);

  @override
  State<ConvertMoney> createState() => _ConvertMoneyState();
}

class _ConvertMoneyState extends State<ConvertMoney> {
  var _selectedCurrency = supportedCurrency.entries.first.key;
  var _selectedCurrency1 = supportedCurrency1.entries.last.key;
  String currency1 = "Philippine Peso";
  String currency2 = "Chinese Yuan";
  var cur1 = "PHP " + currentUser!.php.toString();
  var cur2 = "C¥ " + currentUser!.cny.toString();
  String result = "0 PHP = 0 CNY";
  var converted;
  var amountController = TextEditingController();
  @override
  void initState() {
    amountController.text = "1";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Currency Converter", context),
      body: SingleChildScrollView(
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Column(
            children: [
              SizedBox(height: 30,),
              Column(
                children: [
                  Container(width:MediaQuery.of(context).size.width * 0.8,alignment:Alignment.centerLeft,child: MyWidgets.text("Value to Convert:", 16.0, FontWeight.bold, Color(0xff3B4652), context,false)),
                  SizedBox(height: 10,),
                  Container(
                    width:MediaQuery.of(context).size.width * 0.80,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0,6),
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: -5
                        ),
                      ],
                      color: Color(0xffEBEBEB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                        controller: amountController,
                        decoration: InputDecoration(
                            hintText: "Enter Amount",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: "Poppins"
                            )
                        )
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Container(width:MediaQuery.of(context).size.width * 0.8,alignment:Alignment.centerLeft,child: MyWidgets.text("From:", 16.0, FontWeight.bold, Color(0xff3B4652), context,false)),
                  SizedBox(height: 10,),
                  Container(
                      width:MediaQuery.of(context).size.width * 0.80,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,6),
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: -5
                          ),
                        ],
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                                underline: Container(height: 0,),
                                items: {"PHP", '\$', '€','¥','£','Fr','A\$','C¥'}
                                    .map<DropdownMenuItem<String>>(
                                      (e) => DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: e,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 15,
                                        child: Text(
                                          e,
                                          style: const TextStyle(color: Colors.white, fontSize: 14,fontFamily: "Poppins"),
                                        ),
                                      )),
                                )
                                    .toList(),
                                value: _selectedCurrency,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                onChanged: (value) async{
                                  if (value != null) {
                                    _selectedCurrency = value;
                                  }
                                  if(value == 'PHP'){
                                    currency1 = "Philippine Peso";
                                    cur1 = value! + " " + currentUser!.php.toString();
                                  }else if(value == '\$'){
                                    currency1 = "US Dollar";
                                    cur1 = value! + " " + currentUser!.usd.toString();
                                  }else if(value == '€'){
                                    currency1 = "Euro";
                                    cur1 = value! + " " + currentUser!.eur.toString();
                                  }else if(value == '£'){
                                    currency1 = "Pound";
                                    cur1 = value! + " " + currentUser!.gbp.toString();
                                  }else if(value == 'A\$'){
                                    currency1 = "Australian Dollar";
                                    cur1 = value! + " " + currentUser!.aud.toString();
                                  }else if(value == 'Fr'){
                                    currency1 = "Swiss Franc";
                                    cur1 = value! + " " + currentUser!.chf.toString();
                                  }else if(value == 'C¥'){
                                    currency1 = "Chinese Yuan";
                                    cur1 = value! + " " + currentUser!.cny.toString();
                                  }else if(value == '¥'){
                                    currency1 = "Japanese Yen";
                                    cur1 = value! + " " + currentUser!.jpy.toString();
                                  }
                                  converted = await Forex().getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency:  Currency.getCode(currency2),sourceAmount: double.parse(amountController.text));
                                  setState(() {
                                    result = amountController.text + " "  + currency1 + " = " + converted.toString() + " "  + currency2;
                                  });
                                }
                            ),
                          ),
                          MyWidgets.text(currency1, 18.0, FontWeight.bold, Color(0xff04123B), context,false)
                        ],
                      )
                  )
                ],
              ),
              SizedBox(height: 2.5,),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.8,
                child: myText(text:"You have ${cur1} on your wallet",style:myStyle(size:MF(16,context),).create(),).create(),
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Container(width:MediaQuery.of(context).size.width * 0.8,alignment:Alignment.centerLeft,child: MyWidgets.text("To:", 16.0, FontWeight.bold, Color(0xff3B4652), context,false)),
                  SizedBox(height: 10,),
                  Container(
                      width:MediaQuery.of(context).size.width * 0.80,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,6),
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: -5
                          ),
                        ],
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              underline: Container(height: 0,),
                              items: {"PHP", '\$', '€','¥','£','Fr','A\$','C¥'}
                                  .map<DropdownMenuItem<String>>(
                                    (e) => DropdownMenuItem(
                                    alignment: Alignment.center,
                                    value: e,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 15,
                                      child: Text(
                                        e,
                                        style: const TextStyle(color: Colors.white, fontSize: 14,fontFamily: "Poppins"),
                                      ),
                                    )),
                              )
                                  .toList(),
                              value: _selectedCurrency1,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                                size: 25,
                              ),
                              onChanged: (value) async{
                                if (value != null) {
                                  _selectedCurrency1 = value;
                                }
                                if(value == 'PHP'){
                                  currency2 = "Philippine Peso";
                                }else if(value == '\$'){
                                  currency2 = "US Dollar";
                                }else if(value == '€'){
                                  currency2 = "Euro";
                                }else if(value == '£'){
                                  currency2 = "Pound";
                                }else if(value == 'A\$'){
                                  currency2 = "Australian Dollar";
                                }else if(value == 'Fr'){
                                  currency2 = "Swiss Franc";
                                }else if(value == 'C¥'){
                                  currency2 = "Chinese Yuan";
                                }else if(value == '¥'){
                                  currency2 = "Japanese Yen";
                                }
                                converted = await Forex().getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency:  Currency.getCode(currency2),sourceAmount: double.parse(amountController.text));
                                setState(() {
                                  result = amountController.text + " " + currency1 + " = " + converted.toString()  + " " + currency2;
                                });

                              },
                            ),
                          ),
                          MyWidgets.text(currency2, 18.0, FontWeight.bold, Color(0xff04123B), context,false)
                        ],
                      )
                  )
                ],
              ),
              SizedBox(height: 15,),
              Column(
                children: [
                  Container(width:MediaQuery.of(context).size.width * 0.8,alignment:Alignment.centerLeft,child: MyWidgets.text("Result:", 16.0, FontWeight.bold, Color(0xff3B4652), context,false)),
                  SizedBox(height: 10,),
                  Container(
                    width:MediaQuery.of(context).size.width * 0.80,

                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0,6),
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: -5
                        ),
                      ],
                      color: Color(0xffEBEBEB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: result,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: "Poppins"
                            )
                        )
                    ),
                  )
                ],
              ),
              SizedBox(height: 35,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.8,
                child: MyWidgets.button("Convert", ()async{
                  var response = await Database(url:url).send({
                    "req" : "convertMoney",
                    "currency1" : Currency.getCode(currency1),
                    "currency2" : Currency.getCode(currency2),
                    "user" : currentUser!.userID,
                    "amount" : amountController.text,
                  });
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),

                              ),
                              color:Colors.white
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(response == "\"success\"" ? "assets/3.png" : "assets/failed.png",height: 120,),
                              SizedBox(height: 10,),
                              MyWidgets.text(response == "\"success\"" ?  "Success" : response, 25, FontWeight.bold, Color(0xff111111), context, false),
                              SizedBox(height: 10,),
                              FractionallySizedBox(
                                widthFactor: 0.85,
                                child: MyWidgets.button("Convert Again", (){
                                  Navigator.pop(context);
                                }, Color(0xff04123B), context),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.85,
                                child: MyWidgets.button("Home", (){
                                  MyWidgets.navigatePR(Home(), context);
                                }, Color(0xff04123B), context),
                              )
                            ],
                          ),
                        );
                      }
                  );
                }, Color(0xff04123B),context),
              )
            ],
          ),
        ),
      ),
    );
  }
}