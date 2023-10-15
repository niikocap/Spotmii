import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../components/constants.dart';
import '../../components/custom_form.dart';
import '../../database.dart';
import '../../models/currency.dart';
import '../../models/localauth.dart';
import '../../widgets.dart';
import '../home.dart';
import '../request_money.dart';

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
  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  // ignore: unused_field
  late Contact _contact;
  final maxInput = ThousandsFormatter()
      .formatEditUpdate(
      const TextEditingValue(text: ''),
      TextEditingValue(
          text: supportedCurrency[selectedCurrency].toString()))
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
                  SizedBox(height: 10,),
                  Visibility(visible:false,child: Container(width: MediaQuery.of(context).size.width * 0.9,padding:EdgeInsets.all(10),alignment:Alignment.centerLeft,child: MyWidgets.text("Request Again", 20.0, FontWeight.bold, Color(0xff1B1B1B),context,false))),
                  Visibility(
                    visible: true,
                    child: FutureBuilder(
                      future: Database(url:url).send(
                          {
                            "req" : "getRecent",
                            "what" : "received",
                            "user" : currentUser!.userID,
                          }
                      ),
                      builder: (context,AsyncSnapshot<String> snapshot){
                        if(snapshot.hasData){
                          var data = jsonDecode(snapshot.data!);
                          if(data.length > 0){
                            return Container(
                              height: 70,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:  data.length,
                                itemBuilder: (context,index){
                                  return MyWidgets.sendAgain(
                                        (){
                                      recipient.text = data[index]["ts_to"];
                                    },
                                    NetworkImage("https://i.pravatar.cc/301"),
                                  );
                                },
                              ),
                            );
                          }else{
                            return Container();
                          }
                        }else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
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
                              hintText: "Email, Username, Phone Number",
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
                        onPressed: ()async{
                          Contact? contact = await _contactPicker.selectContact();
                          _contact = contact!;
                          print("___________________________________________________________");
                          //print(_contact.fullName!);
                          //print(_contact.phoneNumbers!);
                          setState(() {

                            //recipient.text = _contact == null ? '' : _contact.phoneNumbers!.first;
                          });
                        },
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
                              hintText: "Choose Currency",
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
                  child: MyWidgets.button("Request", ()async{
                    var isAuthenticated = await LocalAuthApi.authenticate("Scan fingerprint to Request Money!");
                    if(isAuthenticated){
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
                    }
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