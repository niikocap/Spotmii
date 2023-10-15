import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../blocs/transaction_bloc/transaction_bloc.dart';
import '../../components/constants.dart';
import '../../components/custom_form.dart';
import '../../components/text.dart';
import '../../database.dart';
import '../../models/currency.dart';
import '../../models/localauth.dart';
import '../../widgets.dart';
import 'payment.dart';
import '../qr/qrscanner.dart';

class Send extends StatefulWidget {
  final recipient;
  const Send({super.key, this.recipient});

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  var recipient = TextEditingController();
  var amount = TextEditingController();
  var note = TextEditingController();
  var currency = TextEditingController();
  var myBal = "C¥${currentUser!.cny}";
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  late Contact _contact;
  final maxInput = ThousandsFormatter()
      .formatEditUpdate(
      const TextEditingValue(text: ''),
      TextEditingValue(
          text: supportedCurrency[selectedCurrency].toString()))
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
        items: {"PHP", '\$', '€','¥','£','Fr','A\$','C¥'}
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
              myBal = "$value ${currentUser!.getCurrency(Currency.getCode(Currency.getText(value)))}";
            });
          }
        },
      ),
    );
    return Scaffold(
      appBar: MyWidgets.appbar("Send Money", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 10,),
                Visibility(visible:false,child: Container(width: MediaQuery.of(context).size.width * 0.9,padding:const EdgeInsets.all(10),alignment:Alignment.centerLeft,child: MyWidgets.text("Send Again", 20.0, FontWeight.bold, const Color(0xff1B1B1B),context,false))),
                Visibility(
                  visible: widget.recipient != null ? false : true,
                  child: FutureBuilder(
                    future: Database(url:url).send(
                        {
                          "req" : "getRecent",
                          "what" : "sent",
                          "user" : currentUser!.userID,
                        }
                    ),
                    builder: (context,AsyncSnapshot<String> snapshot){
                      if(snapshot.hasData){
                        var data = jsonDecode(snapshot.data!);
                        return SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:  data.length,
                            itemBuilder: (context,index){
                              if(data.length > 0){
                                return MyWidgets.sendAgain(
                                      (){
                                    recipient.text = data[index]["ts_to"];
                                  },
                                  const NetworkImage("https://i.pravatar.cc/301"),
                                );
                              }else{
                                return Container();
                              }
                            },
                          ),
                        );
                      }else{
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              decoration: BoxDecoration(
                  color: const Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0,6),
                        color: Colors.black.withOpacity(0.3),
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
                          padding: const EdgeInsets.fromLTRB(20,10,20,0),
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
                            hintText: "Email, Username, Phone Number",
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            hintStyle: TextStyle(
                                color: const Color(0xff3B4652),
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
                        setState(() {
                          recipient.text = _contact.phoneNumbers!.first;
                        });
                      },
                      icon: const Icon(Icons.person,size: 30,)
                  )
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              decoration: BoxDecoration(
                  color: const Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0,6),
                        color: Colors.black.withOpacity(0.3),
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
                          padding: const EdgeInsets.fromLTRB(20,10,20,0),
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
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            hintStyle: TextStyle(
                                color: const Color(0xff3B4652),
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
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              decoration: BoxDecoration(
                  color: const Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0,6),
                        color: Colors.black.withOpacity(0.3),
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
                          padding: const EdgeInsets.fromLTRB(20,10,20,0),
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
                            fillColor: Colors.white,
                            prefixIcon: dropdown,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            hintStyle: TextStyle(
                                color: const Color(0xff3B4652),
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
            const SizedBox(height: 2.5,),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.centerLeft,
              child: myText(text: 'You have $myBal in your wallet',style:myStyle(size:MF(17,context),).create(),).create(),
            ),
            const SizedBox(height: 5,),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              decoration: BoxDecoration(
                  color: const Color(0xffEBEBEB),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0,6),
                        color: Colors.black.withOpacity(0.3),
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
                          padding: const EdgeInsets.fromLTRB(20,10,20,0),
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
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            hintStyle: TextStyle(
                                color: const Color(0xff3B4652),
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
            const SizedBox(height: 30,),
            SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyWidgets.button("Send", ()async{
                  var localauth = await LocalAuthApi.authenticate("Scan fingerprint to Send Money!");
                  if(localauth){
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
                      context.read<TransactionBloc>().add(const LoadTransaction());
                      MyWidgets.navigateP(PaymentDetails(amount: amount.text, sender: "${currentUser!.fname} ${currentUser!.lname}", transaction: response, currency: currency.text, date: DateTime.now().toString()), context);
                    }else{
                      Navigator.pop(context);
                      showModalBottomSheet(
                          context: context,
                          builder: (context){
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: const BoxDecoration(
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
                                  const SizedBox(height: 20,),
                                  MyWidgets.text("Send Failed, $response", 18, FontWeight.bold, const Color(0xff111111), context, false),
                                  const SizedBox(height: 20,),
                                  FractionallySizedBox(
                                    widthFactor: 0.85,
                                    child: MyWidgets.button("Go Back", (){
                                      Navigator.pop(context);
                                    }, const Color(0xff040606), context),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    }
                  }else{
                    showDialog(context: context, builder: (context){
                      return const Text("Error");
                    });
                  }
                }, const Color(0xff04123B),context)
            ),
            TextButton(
              onPressed: (){
                MyWidgets.navigateP(const QRScanner(), context);
              },
              child: myText(
                  text:"Send Money via QR Code",
                  style:TextStyle(
                      fontSize: MF(17,context),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      decoration: TextDecoration.underline,
                      color:const Color(0xff1B1B1B)
                  )
              ).create(),
              //MyWidgets.text(, 16.0, FontWeight.bold, Color(0xff1B1B1B),context,false)
            )

          ],
        ),
      ),
    );
  }
}