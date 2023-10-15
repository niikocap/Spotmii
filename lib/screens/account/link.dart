import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotmii/screens/account/view_card.dart';
import '../../components/constants.dart';
import '../../database.dart';
import '../../widgets.dart';
import 'link_bank.dart';
import 'link_card.dart';

class LinkAccounts extends StatefulWidget {
  const LinkAccounts({Key? key}) : super(key: key);

  @override
  State<LinkAccounts> createState() => _LinkAccountsState();
}

class _LinkAccountsState extends State<LinkAccounts> {
  Widget LTAccounts(type,typename,cardnumber,cardExp,cardCVV,context){
    return GestureDetector(
      onTap: (){
        if(type == "cards"){
          MyWidgets.navigateP(AccountCard(cardType:typename,cardNumber:cardnumber, cardName: typename, cardexp: cardExp, cardCVV: cardCVV,), context);
        }

      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color(0xff04123B),
                width: 1,
                style: BorderStyle.solid
            )
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
        child: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child:Image.asset(type == "cards" ? "assets/21.png" : "assets/22.png") ,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(alignment:Alignment.centerLeft,child: MyWidgets.text(typename, 23, FontWeight.normal, const Color(0xff111111), context,true)),
                  Align(alignment:Alignment.centerLeft,child: MyWidgets.text(cardnumber, 18, FontWeight.normal, const Color(0xff111111), context,true)),
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
      appBar: MyWidgets.appbar("My Link Accounts", context),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.4,
                child: MyWidgets.button("Link a bank", (){
                  MyWidgets.navigateP(const LinkABank(), context);
                }, const Color(0xff04123B), context),
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.4,
                child: MyWidgets.button("Link a card", (){
                  MyWidgets.navigateP(const LinkACard(), context);
                }, const Color(0xff04123B), context),
              )
            ],
          ),
          const SizedBox(height: 20,),
          FutureBuilder(
            future: Database(url: url).send({
              "req" : "getCardBank",
              "user" : currentUser!.userID
            }),
            builder: (context,AsyncSnapshot<String>snapshot){
              if(snapshot.hasData){
                var data = jsonDecode(snapshot.data!);
                return SizedBox(
                  height: ( MediaQuery.of(context).size.height * 0.75 ) - 4.8,
                  child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context,index){
                      return Container(
                        child: LTAccounts(data![index]["lacc_category"], data![index]["lacc_name"], data![index]["lacc_number"],data![index]["lacc_exp"],data![index]["lacc_cvv"],context),
                      );
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
        ],
      ),
    );
  }
}