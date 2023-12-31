import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotmii/widgets.dart';
import '../../components/constants.dart';
import '../../database.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  Future<List> loadTransaction()async{
    var response = await Database(url: url).send({
      "req" : "transaction",
      "uid" : currentUser!.userID
    });
    return jsonDecode(response);
  }
  @override
  Widget build(BuildContext context) {
    //double pixelratio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: MyWidgets.appbar("Transaction", context),
      body: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height * 0.825 ) - 0.5,
            child: Column(
              children: [
                const SizedBox(height: 10,),
                MyWidgets.text("See your latest transaction history here. \n Some transaction may reflect within 24 hours.", 14.0, FontWeight.normal, const Color(0xff111111),context,false),
                const SizedBox(height: 10,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: FutureBuilder(
                      future:loadTransaction(),
                      builder: (context,AsyncSnapshot<List>snapshot){
                        if(snapshot.hasData){
                          var data = snapshot.data!;
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context,index){
                              return null;
                              //return MyWidgets.transaction(const AssetImage('assets/10.png'), data[index]["ts_to"], data[index]["ts_type"], data[index]["ts_amount"], data[index]["ts_date"], context, data[index]["ts_account"]);
                            },
                          );
                        }else{
                          return Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height:130,
                                    child: Image.asset("assets/notransactions.png"),
                                  ),
                                  const SizedBox(height:10),
                                  MyWidgets.text("No Transactions Yet!", 22, FontWeight.bold, const Color(0xff111111), context, false)
                                ],
                              ),
                            ),
                          );
                        }

                      }),
                ),

              ],
            ),
          ),
          MyWidgets.myBottomBar(context, 1)
        ],
      ),

      //bottomNavigationBar: MyWidgets.bottombar(context, 1),
    );
  }
}
