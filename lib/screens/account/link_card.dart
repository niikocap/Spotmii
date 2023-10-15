import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../database.dart';
import '../../models/localauth.dart';
import '../../widgets.dart';
import 'package:spotmii/components/modalSheet.dart';

import '../home.dart';

class LinkACard extends StatefulWidget {
  const LinkACard({super.key});

  @override
  State<LinkACard> createState() => _LinkACardState();
}

class _LinkACardState extends State<LinkACard> {
  var nameController = TextEditingController();
  var cardNumberController = TextEditingController();
  var cardTypeController = TextEditingController();
  var expController = TextEditingController();
  var securityCodeController = TextEditingController();
  var billingController = TextEditingController();
  var items = [
    'VISA',
    'Mastercard',
    'Debit Card',
    'Other',
  ];
  String dropdownvalue = 'VISA';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyWidgets.appbar("Link a Card", context),
        body:Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              children: [
                const SizedBox(height: 40,),
                Align(alignment:Alignment.centerLeft,child: MyWidgets.text("Link a Card", 40, FontWeight.bold, const Color(0xff111111), context,false)),
                const SizedBox(height: 20,),
                MyWidgets.textFormField(nameController, "Name", const Color(0xff04123B), (value){

                }, context),
                const SizedBox(height: 20,),
                MyWidgets.textFormField(cardNumberController, "Debit or Credit card Number", const Color(0xff04123B), (value){

                }, context),
                const SizedBox(height: 20,),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: Colors.white,
                  ),

                  width: MediaQuery.of(context).size.width * 0.85,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  const BorderSide(color: Color(0xff04123B), width: 1.5,),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff04123B), width: 1.5,),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff3B4652), width: 1.5,),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff04123B), width: 1.5,),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    // Initial Value
                    value: "VISA",
                    borderRadius: BorderRadius.circular(15),
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                        fontSize: MF(18, context),
                        fontFamily: "Poppins",
                        color:const Color(0xff3B4652)
                    ),
                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                MyWidgets.textFormField(expController, "Expiration Date", const Color(0xff04123B), (value){

                }, context),
                const SizedBox(height: 20,),
                MyWidgets.textFormField(securityCodeController, "Security Code", const Color(0xff04123B), (value){

                }, context),
                const SizedBox(height: 20,),
                MyWidgets.textFormField(billingController, "Billing Address", const Color(0xff04123B), (value){

                }, context),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: MyWidgets.button("Link a Card", ()async{
                    final isAuthenticated = await LocalAuthApi.authenticate("Scan fingerprint to Link Account!");
                    if(isAuthenticated){
                      var response = await Database(url: url).send({
                        "req" : "linkAccounts",
                        "user" : currentUser!.userID,
                        "category" : "cards",
                        "name" : nameController.text,
                        "cardType" : dropdownvalue,
                        "cardNumber" : cardNumberController.text,
                        "cardExp" : expController.text,
                        "cardCVV" : securityCodeController.text,
                        "cardAddress" :billingController.text,
                      });
                      if(response == "\"success\""){
                        bmSheet.success("Success!", "Your card has been successfully added on your account.", FractionallySizedBox(
                          widthFactor: 0.80,
                          child:  MyWidgets.button("Home", (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return const Home();
                            }));
                          }, const Color(0xff04123B), context),
                        ), context);
                      }else{
                        bmSheet.error("Link Failed!", "Card linking failed due to some errors", FractionallySizedBox(
                          widthFactor: 0.80,
                          child:  MyWidgets.button("Home", (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return const Home();
                            }));
                          }, const Color(0xff04123B), context),
                        ), context);
                      }
                    }else{
                      //show fingerprint auth error
                    }

                  }, const Color(0xff04123B), context),
                )
              ],
            ),
          ),
        )
    );
  }
}