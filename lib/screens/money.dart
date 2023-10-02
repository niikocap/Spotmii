import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:spotmii/screens/bank.dart';
import 'package:spotmii/screens/payment.dart';
import 'package:spotmii/screens/qrscanner.dart';
import 'package:spotmii/screens/request_money.dart';
import 'package:spotmii/widgets.dart';
import '../constant.dart';
import '../main.dart';
import '../models/currency.dart';
import '../database.dart';
import 'cashin.dart';
import 'home.dart';

const _supportedCurrency = {'PHP':10000, '\$': 10000, '€': 800,'¥':10000,'£':10000,'Fr':10000,'A\$':10000,'C¥':10000};
const _supportedCurrency1 = {'PHP':10000, '\$': 10000, '€': 800,'¥':10000,'£':10000,'Fr':10000,'A\$':10000,'C¥':10000};

class Send extends StatefulWidget {
  final recipient;
  const Send({this.recipient});

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  var recipient = TextEditingController();
  var amount = TextEditingController();
  var note = TextEditingController();
  var currency = TextEditingController();
  final maxInput = ThousandsFormatter()
      .formatEditUpdate(
      const TextEditingValue(text: ''),
      TextEditingValue(
          text: _supportedCurrency[selectedCurrency].toString()))
      .text;
  @override
  void initState() {
    recipient.text = widget.recipient != null ?  widget.recipient : "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final dropdown = ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        underline: Container(height: 0,),
        items: {"PHP", 'U\$', '€','¥','£','Fr','A\$','C¥'}
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem(
              alignment: Alignment.center   ,
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
        value: selectedCurrency,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
          size: 30,
        ),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedCurrency = value;
              currency.text = Currency.getText(value);
            });
          }
        },
      ),
    );
    return Scaffold(
      appBar: MyWidgets.appbar("Send Money", context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 40,),
                  Container(width: MediaQuery.of(context).size.width * 0.9,padding:EdgeInsets.all(10),alignment:Alignment.centerLeft,child: MyWidgets.text("Send Again", 20.0, FontWeight.bold, Color(0xff1B1B1B),context,false)),
                  Visibility(
                    visible: widget.recipient == null,
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          //todo load latest send
                          MyWidgets.sendAgain(
                                (){
                              recipient.text = "12456789";
                            },
                            NetworkImage("https://i.pravatar.cc/300"),
                          ),
                          MyWidgets.sendAgain(
                                (){
                              recipient.text = "12456789";
                            },
                            NetworkImage("https://i.pravatar.cc/299"),
                          ),
                          MyWidgets.sendAgain(
                                (){
                              recipient.text = "12456789";
                            },
                            NetworkImage("https://i.pravatar.cc/298"),
                          ),
                          MyWidgets.sendAgain(
                                (){
                              recipient.text = "12456789";
                            },
                            NetworkImage("https://i.pravatar.cc/301"),
                          ),MyWidgets.sendAgain(
                                (){
                              recipient.text = "12456789";
                            },
                            NetworkImage("https://i.pravatar.cc/302"),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                              "Recipient",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: MF(18,context)
                              ),
                            )

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: recipient,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "ex. Charlie 0909000000",
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              hintStyle: TextStyle(
                                  color: Color(0xff3B4652),
                                  fontSize: MF(17,context)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.person,size: 30,)
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                              "Amount",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: MF(18,context)
                              ),
                            )

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: amount,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Amount",
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              hintStyle: TextStyle(
                                  color: Color(0xff3B4652),
                                  fontSize: MF(17,context)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                              "Currency",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: MF(18,context)
                              ),
                            )

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: currency,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Currency",
                              fillColor: Colors.white,
                              prefixIcon: dropdown,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              hintStyle: TextStyle(
                                  color: Color(0xff3B4652),
                                  fontSize: MF(17,context)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                              "Note (Optional)",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: MF(18,context)
                              ),
                            )

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: note,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Note.",
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              hintStyle: TextStyle(
                                  color: Color(0xff3B4652),
                                  fontSize: MF(17,context)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyWidgets.button("Send", (){
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color:Color(0xff04123B),
                          height: 60,
                          child: GestureDetector(
                            onTap: ()async{
                              MyWidgets.showLoading();
                              var response = await Database(url:url).send({
                                "req" : "send",
                                "uid" : currentUser!.userID,
                                "amount" : amount.text,
                                "note" : note.text,
                                "currency" : Currency.getCode(Currency.getText(selectedCurrency)), //todo change to drop down
                                "target" : recipient.text,
                              });
                              if(response.length == 42){
                                MyWidgets.navigateP(PaymentDetails(amount: amount.text, sender: currentUser!.fname + " " + currentUser!.lname, transaction: response, currency: currency.text, date: DateTime.now().toString()), context);
                              }else{
                                Navigator.pop(context);
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return Container(
                                      height: MediaQuery.of(context).size.height * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)
                                        )
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/failed.png",height: 100,),
                                          SizedBox(height: 20,),
                                          MyWidgets.text("Send Failed, ${response}", 18, FontWeight.bold, Color(0xff111111), context, false),
                                          SizedBox(height: 20,),
                                          FractionallySizedBox(
                                            widthFactor: 0.85,
                                            child: MyWidgets.button("Go Back", (){
                                              Navigator.pop(context);
                                            }, Color(0xff040606), context),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                );
                              }
                              //do connect to backend

                              //success
                              //
                            },
                            child: Center(
                              child: MyWidgets.text("Continue", 25.0, FontWeight.bold, Colors.white,context,false),
                            ),
                          ),
                        );
                      });
                }, Color(0xff04123B),context)
              ),
              SizedBox(height: 30,),
              TextButton(
                  onPressed: (){
                    MyWidgets.navigateP(QRScanner(), context);
                  },
                  child: MyWidgets.text("Send Money via QR Code", 16.0, FontWeight.bold, Color(0xff1B1B1B),context,false)
              )

            ],
          ),
        ),
      ),
    );
  }
}

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  var recipient = TextEditingController();
  var amount = TextEditingController();
  var currency = TextEditingController();
  var note = TextEditingController();
  final maxInput = ThousandsFormatter()
      .formatEditUpdate(
      const TextEditingValue(text: ''),
      TextEditingValue(
          text: _supportedCurrency[selectedCurrency].toString()))
      .text;

  @override
  Widget build(BuildContext context) {
    final dropdown = ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        underline: Container(height: 0,),
        items: {"PHP", 'U\$', '€','¥','£','Fr','A\$','C¥'}
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem(
              alignment: Alignment.center   ,
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
        value: selectedCurrency,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
          size: 30,
        ),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedCurrency = value;
              currency.text = Currency.getText(value);
            });
          }
        },
      ),
    );
    return Scaffold(
      appBar: MyWidgets.appbar("Request Money", context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 40,),
                  Container(width: MediaQuery.of(context).size.width * 0.9,padding:EdgeInsets.all(10),alignment:Alignment.centerLeft,child: MyWidgets.text("Request Again", 20.0, FontWeight.bold, Color(0xff1B1B1B),context,false)),
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        MyWidgets.sendAgain(
                              (){
                            recipient.text = "12456789";
                          },
                          NetworkImage("https://i.pravatar.cc/300"),
                        ),
                        MyWidgets.sendAgain(
                              (){
                            recipient.text = "12456789";
                          },
                          NetworkImage("https://i.pravatar.cc/299"),
                        ),
                        MyWidgets.sendAgain(
                              (){
                            recipient.text = "12456789";
                          },
                          NetworkImage("https://i.pravatar.cc/298"),
                        ),
                        MyWidgets.sendAgain(
                              (){
                            recipient.text = "12456789";
                          },
                          NetworkImage("https://i.pravatar.cc/301"),
                        ),MyWidgets.sendAgain(
                              (){
                            recipient.text = "12456789";
                          },
                          NetworkImage("https://i.pravatar.cc/302"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                              "Request From",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: MF(18,context)
                              ),
                            )

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: recipient,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "ex. Charlie 0909000000",
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              hintStyle: TextStyle(
                                  color: Color(0xff3B4652),
                                  fontSize: MF(17,context)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.person,size: 30,)
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                              "Amount",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: MF(18,context)
                              ),
                            )

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: amount,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Amount",
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              hintStyle: TextStyle(
                                  color: Color(0xff3B4652),
                                  fontSize: MF(17,context)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                              "Currency",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: MF(18,context)
                              ),
                            )

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: currency,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Currency",
                              prefixIcon: dropdown,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              hintStyle: TextStyle(
                                  color: Color(0xff3B4652),
                                  fontSize: MF(17,context)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                              "Note (Optional)",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: MF(18,context)
                              ),
                            )

                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: note,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Note.",
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              hintStyle: TextStyle(
                                  color: Color(0xff3B4652),
                                  fontSize: MF(17,context)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyWidgets.button("Request", (){
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            color:Color(0xff04123B),
                            height: 60,
                            child: GestureDetector(
                              onTap: ()async{
                                //todo validation
                                MyWidgets.showLoading();
                                var response = await Database(url: url).send({
                                  "req" : "createRequest",
                                  "amount" : amount.text,
                                  "currency" : selectedCurrency,
                                  "to" : recipient.text,
                                  "user" : currentUser!.userID,
                                  "note" : note.text,
                                  "identity" : recipient.text
                                });
                                Navigator.pop(context);
                                if(response == ""){

                                }
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context){
                                      return Container(
                                        height: MediaQuery.of(context).size.height * 0.6,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)
                                            )
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/3.png",height: 150,),
                                            SizedBox(height: 20,),
                                            MyWidgets.text("Success!", 35, FontWeight.bold, Colors.black, context, false),
                                            SizedBox(height: 10,),
                                            MyWidgets.text("Your request has been successfully sent.", 18, FontWeight.bold, Colors.grey, context, false),
                                            SizedBox(height: 20,),
                                            FractionallySizedBox(
                                              widthFactor: 0.85,
                                              child: MyWidgets.button("Home", (){
                                                MyWidgets.navigatePR(Home(), context);
                                              }, Color(0xff04123B), context),
                                            )
                                          ],
                                        )
                                      );
                                    }
                                );

                              },
                              child: Center(
                                child: MyWidgets.text("Continue", 25.0, FontWeight.bold, Colors.white,context,false),
                              ),
                            ),
                          );
                        });
                  }, Color(0xff04123B),context)
              ),
              SizedBox(height: 30,),
              TextButton(
                  onPressed: (){
                    var data = [recipient.text,selectedCurrency,amount.text,currentUser!.userID];
                    MyWidgets.navigateP(RequestQR(data: data), context);
                  },
                  child: MyWidgets.text("Request Money via QR Code", 16.0, FontWeight.bold, Color(0xff1B1B1B),context,false)
              )

            ],
          ),
        ),
      ),
    );
  }
}

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

class TopUpFailed extends StatefulWidget {
  const TopUpFailed({Key? key}) : super(key: key);

  @override
  State<TopUpFailed> createState() => _TopUpFailedState();
}

class _TopUpFailedState extends State<TopUpFailed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            IconButton(
              icon: Image.asset('assets/failed.png'),
              iconSize: 140,
              onPressed: () {},
            ),
            SizedBox(height: 10,),
            MyWidgets.text("Failed!", 33.0, FontWeight.bold,Colors.black,context,false),
            SizedBox(height: 20,),
            Align(
                alignment:Alignment.center,
                child: Container(
                    width: 300,
                    child: MyWidgets.text("You don't have enough money on your bank account. Try again", 17.0, FontWeight.normal,Colors.black,context,false)
                )
            ),
            SizedBox(height: 40,),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.8,
              child: MyWidgets.button("Home",(){},Color(0xff04123B),context),
            ),
            SizedBox(height: 20,),
            TextButton(
                onPressed: (){
                  //MyWidgets.navigatePR(PaymentDetails(amount: amount, sender: sender, transaction: transaction, currency: currency, date: date)), context);
                },
                child: MyWidgets.text("Transaction Details", 15.0, FontWeight.bold,Colors.black,context,false)
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

class ConvertMoney extends StatefulWidget {
  const ConvertMoney({Key? key}) : super(key: key);

  @override
  State<ConvertMoney> createState() => _ConvertMoneyState();
}

class _ConvertMoneyState extends State<ConvertMoney> {
  var _selectedCurrency = _supportedCurrency.entries.first.key;
  var _selectedCurrency1 = _supportedCurrency1.entries.last.key;
  String currency1 = "Philippine Peso";
  String currency2 = "Chinese Yuan";
  String result = "0 PHP = 0 CNY";
  var converted;
  var amountController = TextEditingController();
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
                                  }else if(value == '\$'){
                                    currency1 = "US Dollar";
                                  }else if(value == '€'){
                                    currency1 = "Euro";
                                  }else if(value == '£'){
                                    currency1 = "Pound";
                                  }else if(value == 'A\$'){
                                    currency1 = "Australian Dollar";
                                  }else if(value == 'Fr'){
                                    currency1 = "Swiss Franc";
                                  }else if(value == 'C¥'){
                                    currency1 = "Chinese Yuan";
                                  }else if(value == '¥'){
                                    currency1 = "Japanese Yen";
                                  }
                                  converted = await Database.convertCurrency(Currency.getCode(currency1), Currency.getCode(currency2), amountController.text);

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
                                converted = await Database.convertCurrency(Currency.getCode(currency1), Currency.getCode(currency2), amountController.text);
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

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  bool showList = false;
  Provider selected = Provider(image: Icon(Icons.shopping_bag), text: "Merchant Store",type: "store");
  var amountController = TextEditingController();
  List<Provider> provList = [
    Provider(
        image: CircleAvatar(
          backgroundImage: NetworkImage("https://play-lh.googleusercontent.com/sG15qNhfx0Rc746q2416LCozt7wCoHI-VcwohvvLwZfp2fRFPCx7zysZrlNpmIaEvQ=w240-h480-rw"),
        ),
        text: "ANZ – Australia and New Zealand Banking Group",type: "bank"),
    Provider(
        image: CircleAvatar(
          backgroundImage: NetworkImage("https://play-lh.googleusercontent.com/sG15qNhfx0Rc746q2416LCozt7wCoHI-VcwohvvLwZfp2fRFPCx7zysZrlNpmIaEvQ=w240-h480-rw"),
        ),
        text: "TEST – Australia and New Zealand Banking Group",type: "bank"),
  ];
  Widget myListTile(Provider prov,index){
    return GestureDetector(
      onTap: (){
        setState(() {
          provList.removeAt(index);
          provList.add(selected);
          selected = prov;
          //provList[index] = selected;
        });

      },
      child: Container(
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(offset: Offset(0,2),blurRadius: 2,color: Colors.grey.withOpacity(0.5))
              ]
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          child: Row(
            children: [
              prov.image,
              SizedBox(width: 10,),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.60,
                child: MyWidgets.text(prov.text, 17, FontWeight.bold, Color(0xff111111), context, false),
              )
            ],
          )
      ),
    );
  }
  Widget myListTileButton(Provider prov){
    return GestureDetector(
      onTap: (){
        setState(() {
          showList = !showList;
        });
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color(0xffEBEBEB),
            borderRadius: BorderRadius.circular(10)
        ),
        width: MediaQuery.of(context).size.width * 0.85,
        child: Row(
          children: [
            Icon(!showList ? Icons.expand_circle_down : Icons.cancel,size: 25),
            SizedBox(width: 10,),
            prov.image,
            SizedBox(width: 10,),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.55,
              child: MyWidgets.text(prov.text, 17, FontWeight.bold, Color(0xff111111), context, false),
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Withdraw", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20,),
            MyWidgets.text("Withdrawable Balance: \$${currentUser!.balance}", 25, FontWeight.bold, Color(0xff3B4652), context, false),
            SizedBox(height: 20,),
            FractionallySizedBox(child: CustomFormWidget(controller: amountController,),widthFactor: 0.85,),
            SizedBox(height: 40,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              alignment: Alignment.centerLeft,
              child: MyWidgets.text("Choose Account", 20, FontWeight.bold, Color(0xff111111), context, false),
            ),
            SizedBox(height: 20,),
            myListTileButton(selected),
            SizedBox(height: 20,),
            AnimatedOpacity(
              opacity: showList ? 1 : 0,
              curve: Curves.fastOutSlowIn,
              duration: Duration(seconds: 1),
              child: Visibility(
                visible: showList,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provList.length,
                      itemBuilder: (context,index){
                        return  myListTile(provList[index],index);
                      },
                    )
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: MyWidgets.text("Please choose where to withdraw your money.", 16, FontWeight.normal, Color(0xff111111), context, false),
            ),
            SizedBox(height: 20,),
            FractionallySizedBox(
              widthFactor: 0.85,
              child: MyWidgets.button("Withdraw Money", ()async{
                var response = await Database(url:url).send({
                  "req" : "topuprequest",
                  "amount" : amountController.text,
                  "currency" : selectedCurrency,
                  "user" : currentUser!.userID,
                  "type" : "withdraw",
                  "merchant" : "store",
                });
                print(response);
                if(selected.type == "store"){
                  MyWidgets.navigateP(TopUpMerchant(transaction: response, amount: amountController.text,currency: selectedCurrency,), context);
                }else if(selected.type  == "bank"){
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                              )
                          ),
                          height: MediaQuery.of(context).size.height* 0.4,
                          child: Center(
                            child: Image.asset("assets/underconstruction.png",height: 250,),
                          ),
                        );
                      }
                  );
                }else if(selected.type == "card"){
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                              )
                          ),
                          height: MediaQuery.of(context).size.height* 0.4,
                          child: Center(
                            child: Image.asset("assets/underconstruction.png"),
                          ),
                        );
                      }
                  );
                }
              }, Color(0xff04123B), context),
            )
          ],
        ),
      ),
    );
  }
}