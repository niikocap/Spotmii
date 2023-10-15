import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../../database.dart';
import '../../models/localauth.dart';
import '../../widgets.dart';
import '../home.dart';

class LinkABank extends StatefulWidget {
  const LinkABank({super.key});

  @override
  State<LinkABank> createState() => _LinkABankState();
}

class _LinkABankState extends State<LinkABank> {
  var nameController = TextEditingController();
  var bankNameController = TextEditingController();
  var bankCodeController = TextEditingController();
  var accountNumberController = TextEditingController();
  var billingController = TextEditingController();

  get bmSheet => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Link A Bank", context),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Align(alignment:Alignment.centerLeft,child: MyWidgets.text("Link a Bank Account", 40, FontWeight.bold, const Color(0xff111111), context,false)),
              Align(alignment: Alignment.centerLeft,child:  MyWidgets.text("The safety and security of your bank account information is ", 17, FontWeight.normal, const Color(0xff111111), context,false),),
              Align(alignment: Alignment.centerLeft,child: MyWidgets.text("protected by SpotMii.", 17, FontWeight.normal, const Color(0xff111111), context, false),),
              const SizedBox(height: 20,),
              MyWidgets.textFormField(nameController, "Full Name", const Color(0xff04123B), (value){

              }, context),
              const SizedBox(height: 20,),
              MyWidgets.textFormField(billingController, "Billing Address", const Color(0xff04123B), (value){

              }, context),
              const SizedBox(height: 20,),
              MyWidgets.textFormField(bankNameController, "Bank Name", const Color(0xff04123B), (value){

              }, context),
              const SizedBox(height: 20,),
              MyWidgets.textFormField(bankCodeController, "Bank Code", const Color(0xff04123B), (value){

              }, context),
              const SizedBox(height: 20,),
              MyWidgets.textFormField(accountNumberController, "Account Number", const Color(0xff04123B), (value){

              }, context),
              const SizedBox(height: 20,),
              Align(alignment: Alignment.centerLeft,child:  MyWidgets.text("Be sure to double-check your account number. Banks may ", 17, FontWeight.normal, const Color(0xff111111), context,false),),
              Align(alignment: Alignment.centerLeft,child: MyWidgets.text("not flag errors until you send payments.", 17, FontWeight.normal, const Color(0xff111111), context, false),),
              const SizedBox(height: 20,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: MyWidgets.button("Link Your Bank", ()async{
                  var isAuthenticated = await LocalAuthApi.authenticate("Scan fingerprint to Link Account!");
                  if(isAuthenticated){
                    var response = await Database(url: url).send({
                      "req" : "linkAccounts",
                      "user" : currentUser!.userID,
                      "category" : "banks",
                      "name" : nameController.text,
                      "bankNumber" : accountNumberController.text,
                      "bankCode" : bankCodeController.text,
                      "bankName" : bankNameController.text,
                      "bankAddress" : billingController.text,
                    });
                    print(response);
                    if(response == "\"success\""){
                      bmSheet.success("Success!", "Your bank has been successfully added on your account.", FractionallySizedBox(
                        widthFactor: 0.80,
                        child:  MyWidgets.button("Home", (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return const Home();
                          }));
                        }, const Color(0xff04123B), context),
                      ), context);
                    }else{
                      bmSheet.error("Link Failed!", "Bank linking failed due to some errors", FractionallySizedBox(
                        widthFactor: 0.80,
                        child:  MyWidgets.button("Home", (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return const Home();
                          }));
                        }, const Color(0xff04123B), context),
                      ), context);
                    }
                  }else{

                  }
                }, const Color(0xff04123B), context),
              )

            ],
          ),
        ),
      ),
    );
  }
}
