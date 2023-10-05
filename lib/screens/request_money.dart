import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:spotmii/widgets.dart';
import '../components/constants.dart';
import '../constant.dart';
import '../main.dart';
import '../models/currency.dart';
import '../database.dart';
import 'money.dart';

class RequestMoney extends StatefulWidget {
  const RequestMoney({super.key});
  @override
  State<RequestMoney> createState() => _RequestMoneyState();
}

class _RequestMoneyState extends State<RequestMoney> {
  bool rSent = true;
  int rSCount = 0;
  int rRCount = 0;
  createRequest(number,currency,amount,date,sent,requestID){
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context,
          builder: (context){
            if(rSent){
              return Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.70,
                      child: MyWidgets.text("You have Sent Request to ${number}", 28, FontWeight.bold, Colors.black, context, false),
                    ),
                    SizedBox(height: 10,),
                    MyWidgets.text("${Currency.getSymbol(currency)} ${amount}", 50, FontWeight.bold, Colors.black, context, false),
                    SizedBox(height: 10,),
                    FractionallySizedBox(
                      widthFactor: 0.85,
                      child: MyWidgets.button("Cancel", ()async{
                        MyWidgets.showLoading();
                        await Database(url:url).send({
                          "req" : "cancelRequest",
                          "request_id" : requestID
                        });
                        Navigator.pop(context);
                        setState(() {

                        });
                      }, Colors.red, context),
                    )
                  ],
                ),
              );
            }else{
              return Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.70,
                      child: MyWidgets.text("You have Sent Request to ${number}", 28, FontWeight.bold, Colors.black, context, false),
                    ),
                    SizedBox(height: 10,),
                    MyWidgets.text("${Currency.getSymbol(currency)} ${amount}", 50, FontWeight.bold, Colors.black, context, false),
                    SizedBox(height: 10,),
                    FractionallySizedBox(
                      widthFactor: 0.85,
                      child: MyWidgets.button("Pay Now", ()async{
                        MyWidgets.showLoading();
                        var response = await Database(url:url).send({
                          "req" : "approveRequest",
                          "request_id" : requestID
                        });
                       if(response == "\"success\""){

                       }else{
                         //todo show error
                         print("failed");
                       }
                      }, Color(0xff04123B), context),
                    ),
                    SizedBox(height: 10,),
                    FractionallySizedBox(
                      widthFactor: 0.85,
                      child: MyWidgets.button("Cancel", ()async{
                        MyWidgets.showLoading();
                        await Database(url:url).send({
                          "req" : "cancelRequest",
                          "request_id" : requestID
                        });
                        Navigator.pop(context);
                        setState(() {

                        });
                      }, Colors.red, context),
                    )
                  ],
                ),
              );
            }

          }
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.withOpacity(0.7)
                )
            )
        ),
        child: Row(
          children: [
            Image.asset(sent?  "assets/req_sent.png" : "assets/req_received.png",width: 25,height: 25,),
            SizedBox(width: 15,),

            Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "You sent a request to ",
                              style: MyWidgets.TS(16, context, Color(0xff111111), FontWeight.normal),
                            ),
                            TextSpan(
                              text: number,
                              style: MyWidgets.TS(16, context, Color(0xff111111), FontWeight.bold),
                            ),

                          ]
                      ),
                    )
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyWidgets.text("${currency} ${amount}", 17, FontWeight.normal, Colors.black, context, false),
                      MyWidgets.text(date, 17, FontWeight.normal, Colors.black, context, false),
                    ],
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyWidgets.appbar("Request Money", context),
        body: Column(
          children: [
            Container(
              child:Container(
                color: Color(0xffE8E8E8),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              if(!rSent)
                                rSent = true;
                            });
                          },
                          child: Stack(
                              children: [
                                Visibility(
                                  visible: rSCount > 0,
                                  child: Positioned(
                                    top: 2.5,
                                    right: 2.5,
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: Colors.red,
                                      child: MyWidgets.text(rSCount.toString(), 13, FontWeight.bold, Colors.white, context, false),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: rSent ? BorderSide(width: 3,color: Color(0xff04123B)) : BorderSide(width: 0,color: Color(0xff04123B)),
                                    )
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                  width: MediaQuery.of(context).size.width*0.5,
                                  child: MyWidgets.text("Request Sent", 20, FontWeight.bold, Color(0xff111111), context, false),
                                ),
                              ]
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              if(rSent)
                                rSent = false;
                            });
                          },
                          child: Stack(
                            children: [
                              Visibility(
                                visible: rRCount > 0,
                                child: Positioned(
                                  top: 2.5,
                                  right: 2.5,
                                  child: CircleAvatar(
                                    radius: 7,
                                    backgroundColor: Colors.red,
                                    child: MyWidgets.text(rRCount.toString(), 13, FontWeight.bold, Colors.white, context, false),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12.5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: !rSent ? BorderSide(width: 3,color: Color(0xff04123B)) : BorderSide(width: 0,color: Color(0xff04123B)),
                                    )
                                ),
                                width: MediaQuery.of(context).size.width*0.5,
                                child: MyWidgets.text("Request Received", 20, FontWeight.bold, Color(0xff111111), context, false),
                              ),
                            ]
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              )
            ),
            Visibility(
              visible: rSent,
              child: FutureBuilder(
                future:Database(url:url).send({
                  "req" : "getRequestSent",
                  "user" : currentUser!.userID,
                }),
                builder: (context, AsyncSnapshot<String> snapshot){
                  if(snapshot.hasData){
                    List data = jsonDecode(snapshot.data!);
                    rSCount = data.length;
                    if(data.length == 0){
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/notransactions.png",height: 130,),
                            SizedBox(height: 20,),
                            MyWidgets.text("Sorry! there are no data to show", 22, FontWeight.bold, Colors.black, context, false)
                          ],
                        ),
                      );
                    }else{
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context,index){
                            return createRequest(data[index]["req_identity"],data[index]["req_currency"],data[index]["req_amount"],data[index]["req_date"],true,data[index]["req_uid"]);
                          },
                        ),
                      );
                    }
                  }else{
                    return Center(
                      child: MyWidgets.showLoading(),
                    );
                  }
                }
              )
            ),
            Visibility(
                visible: !rSent,
                child: FutureBuilder(
                    future:Database(url:url).send({
                      "req" : "getRequestReceived",
                      "user" : currentUser!.userID,
                    }),
                    builder: (context, AsyncSnapshot<String> snapshot){
                      if(snapshot.hasData){
                        List data = jsonDecode(snapshot.data!);
                        rRCount = data.length;
                        if(data.length == 0){
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/notransactions.png",height: 130,),
                                SizedBox(height: 20,),
                                MyWidgets.text("Sorry! there are no data to show!", 22, FontWeight.bold, Colors.black, context, false)
                              ],
                            ),
                          );
                        }else{
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            color: Colors.white,
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context,index){
                                return createRequest(data[index]["req_identity"],data[index]["req_currency"],data[index]["req_amount"],data[index]["req_date"],true,data[index]["req_uid"]);
                              },
                            ),
                          );
                        }
                      }else{
                        return Center(
                          child: MyWidgets.showLoading(),
                        );
                      }
                    }
                )
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width * 0.075)),
          child: MyWidgets.button("New Request", (){
            MyWidgets.navigateP(Request(), context);
          }, Color(0xff04123B), context),
        ),
      ),
    );
  }
}


class RequestQR extends StatefulWidget {
  final data;
  const RequestQR({required this.data});

  @override
  State<RequestQR> createState() => _RequestQRState();
}

class _RequestQRState extends State<RequestQR> {
  Widget myBorder(){
    return Container(margin:EdgeInsets.only(right: 2.5),width: 5,height: 3,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),);
  }
  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
      appBar: MyWidgets.appbar("Request Money", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 50,),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Color(0xff04123B),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Container(
                    width: 225,
                    height: 225,
                    child: QrImageView(
                      backgroundColor: Color(0xff04123B),
                      foregroundColor: Colors.white,
                      data: widget.data.toString(),
                    ),
                  ),
                  SizedBox(height: 15,),
                  MyWidgets.text(widget.data[1] + " " + widget.data[2], 50, FontWeight.bold, Colors.white, context, false),
                  MyWidgets.text("Amount", 20, FontWeight.bold, Colors.white, context, false),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),
                      myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),
                    ],
                  ),
                  SizedBox(height: 15,),
                  MyWidgets.text(widget.data[0], 40, FontWeight.bold, Colors.white, context, false),
                  MyWidgets.text("Send this to the recipient to continue!", 16, FontWeight.bold, Colors.white, context, false),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.file_download_outlined),
                      SizedBox(width: 5,),
                      MyWidgets.text("Download", 20, FontWeight.bold, Color(0xff04123B), context, false)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.share_rounded),
                      SizedBox(width: 5,),
                      MyWidgets.text("Share QR", 20, FontWeight.bold, Color(0xff04123B), context, false)
                    ],
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
