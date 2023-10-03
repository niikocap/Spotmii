import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:spotmii/widgets.dart';

import '../components/constants.dart';

class Limits extends StatefulWidget {
  const Limits({Key? key}) : super(key: key);

  @override
  State<Limits> createState() => _LimitsState();
}

class _LimitsState extends State<Limits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Account Limits", context),
    );
  }
}

class LinkAccounts extends StatefulWidget {
  const LinkAccounts({Key? key}) : super(key: key);

  @override
  State<LinkAccounts> createState() => _LinkAccountsState();
}

class _LinkAccountsState extends State<LinkAccounts> {
  Widget LTAccounts(type,typename,cardnumber,context){
    return GestureDetector(
      onTap: (){
        MyWidgets.navigatePR(AccountCard(cardType:typename,cardNumber:cardnumber), context);
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
      appBar: MyWidgets.appbar("My Link Accounts", context),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: MyWidgets.button("Link a bank", (){
                    MyWidgets.navigateP(LinkABank(), context);
                  }, Color(0xff04123B), context),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: MyWidgets.button("Link a card", (){
                    MyWidgets.navigateP(LinkACard(), context);
                  }, Color(0xff04123B), context),
                )
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: ( MediaQuery.of(context).size.height * 0.75 ) - 4.8,
              child: ListView(
                children: [
                  LTAccounts("assets/21.png", "Visa", "Debit *****7125",context),
                  LTAccounts("assets/7.png", "Bank of the Philippine Island", "Checking *****123", context)
                ],
              ),
            ),
            MyWidgets.myBottomBar(context, 2)
          ],
        ),
      ),
    );
  }
}

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Link A Bank", context),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: [
              SizedBox(height: 40,),
              Align(alignment:Alignment.centerLeft,child: MyWidgets.text("Link a Bank Account", 40, FontWeight.bold, Color(0xff111111), context,false)),
              Align(alignment: Alignment.centerLeft,child:  MyWidgets.text("The safety and security of your bank account information is ", 17, FontWeight.normal, Color(0xff111111), context,false),),
              Align(alignment: Alignment.centerLeft,child: MyWidgets.text("protected by SpotMii.", 17, FontWeight.normal, Color(0xff111111), context, false),),
              SizedBox(height: 20,),
              MyWidgets.textFormField(nameController, "Full Name", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              MyWidgets.textFormField(billingController, "Billing Address", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              MyWidgets.textFormField(bankNameController, "Bank Name", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              MyWidgets.textFormField(bankNameController, "Bank Code", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              MyWidgets.textFormField(bankNameController, "Account Number", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              Align(alignment: Alignment.centerLeft,child:  MyWidgets.text("Be sure to double-check your account number. Banks may ", 17, FontWeight.normal, Color(0xff111111), context,false),),
              Align(alignment: Alignment.centerLeft,child: MyWidgets.text("not flag errors until you send payments.", 17, FontWeight.normal, Color(0xff111111), context, false),),
              SizedBox(height: 20,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: MyWidgets.button("Link Your Bank", (){

                }, Color(0xff04123B), context),
              )

            ],
          ),
        ),
      ),
    );
  }
}

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
              SizedBox(height: 40,),
              Align(alignment:Alignment.centerLeft,child: MyWidgets.text("Link a Card", 40, FontWeight.bold, Color(0xff111111), context,false)),
              SizedBox(height: 20,),
              MyWidgets.textFormField(nameController, "Name", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              MyWidgets.textFormField(cardNumberController, "Debit or Credit card Number", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: Colors.white,
                ),

                width: MediaQuery.of(context).size.width * 0.85,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Color(0xff04123B), width: 1.5,),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff04123B), width: 1.5,),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff3B4652), width: 1.5,),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff04123B), width: 1.5,),
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
                      color:Color(0xff3B4652)
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
              SizedBox(height: 20,),
              MyWidgets.textFormField(expController, "Expiration Date", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              MyWidgets.textFormField(securityCodeController, "Security Code", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              MyWidgets.textFormField(billingController, "Billing Address", Color(0xff04123B), (value){

              }, context),
              SizedBox(height: 20,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: MyWidgets.button("Link a Card", (){

                }, Color(0xff04123B), context),
              )
            ],
          ),
        ),
      )
    );
  }
}

class AccountCard extends StatefulWidget {
  final cardType;
  final cardNumber;
  AccountCard({required this.cardType,required this.cardNumber});

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("My Link Accounts", context),
      body: Column(
        children: [
          SizedBox(height: 40,),
          CreditCardWidget(
            cardNumber: widget.cardNumber,
            expiryDate: "11/23",
            cardHolderName: "Maria Nelfa Loren Sebastian",
            isHolderNameVisible: true,
            cvvCode: "113",
            showBackView: false,
            cardBgColor: Color(0xff04123B),
            onCreditCardWidgetChange: (CreditCardBrand ) {

            }, //true when you want to show cvv(back) view
          ),
        ],
      ),
    );
  }
}
