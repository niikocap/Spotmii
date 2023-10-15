import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../../components/custom_form.dart';
import '../../database.dart';
import '../../widgets.dart';
import 'add_money.dart';

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