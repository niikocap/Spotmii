import 'package:flutter/material.dart';
import 'package:spotmii/widgets.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class Bank extends StatefulWidget {
  const Bank({Key? key}) : super(key: key);

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Bank", context),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40,),
            MyWidgets.text("Select Partner Banks", 17.0, FontWeight.bold, Color(0xff111111), context,false),
            //row temporary
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    MyWidgets.navigateP(BankTransfer(), context);
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    child:  Image.network("https://1000logos.net/wp-content/uploads/2018/08/anz-bank-logo.jpg"),
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}

class BankTransfer extends StatefulWidget {
  const BankTransfer({Key? key}) : super(key: key);

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  var controller = TextEditingController();
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    '50',
    '100',
    '150',
    '200',
    '250',
    '30x0',
  ];
  //var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Bank Transfer", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            FractionallySizedBox(widthFactor:0.9,child: MyWidgets.text("ANZ – Australia and New Zealand Banking Group", 17.0, FontWeight.bold, Color(0xff111111), context,false)),
            //MyWidgets.text("TO BE ADDED HARD TO IMPLEMENT ON FLUTTER", 16.0, FontWeight.bold, Color(0xff111111), context),
            SizedBox(height: 10,),
            Center(child: CustomFormWidget(controller: controller,)),
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15,0,10,15),
                      focusedBorder: UnderlineInputBorder(

                      ),
                      enabledBorder: UnderlineInputBorder(

                      ),
                      errorBorder: UnderlineInputBorder(

                      ),
                      hintText: "1000",
                      hintStyle: TextStyle(
                          color: Color(0xff04123B),
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,

                      ),
                    ),
                  ),
                )
              ],
            ),
             */
            SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(

                  ),
                  enabledBorder: UnderlineInputBorder(

                  ),
                  errorBorder: UnderlineInputBorder(

                  ),
                  hintText: "Account Name:",
                  hintStyle: TextStyle(
                      color: Color(0xff04123B),
                      fontSize: MF(17,context),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(

                  ),
                  enabledBorder: UnderlineInputBorder(

                  ),
                  errorBorder: UnderlineInputBorder(

                  ),
                  hintText: "Account Number:",
                  hintStyle: TextStyle(
                      color: Color(0xff04123B),
                      fontSize: MF(17,context),
                      fontFamily: "Poppins",
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(width:MediaQuery.of(context).size.width * 0.8,child: MyWidgets.text("Please verify the accuracy and completeness of the details before you proceed.", 15.0, FontWeight.normal, Color(0xff111111), context,false)),
            SizedBox(height: 30),
            SizedBox(
              height:40,
              width:MediaQuery.of(context).size.width * 0.80,
              child: MyWidgets.button("Send Money", (){
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color:Color(0xff04123B),
                        height: 60,
                        child: GestureDetector(
                          onTap: (){
                            MyWidgets.navigatePR(TopUpFailed(), context);
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

class CustomFormWidget extends StatefulWidget {
  final controller;
  const CustomFormWidget({required this.controller});

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

const _supportedCurrency = {'PHP':10000, '\$': 10000, '€': 800,'¥':10000,'£':10000,'Fr':10000,'A\$':10000,'C¥':10000};
var selectedCurrency = _supportedCurrency.entries.last.key;

class _CustomFormWidgetState extends State<CustomFormWidget> {

  @override
  Widget build(BuildContext context) {
    final maxInput = ThousandsFormatter()
        .formatEditUpdate(
        const TextEditingValue(text: ''),
        TextEditingValue(
            text: _supportedCurrency[selectedCurrency].toString()))
        .text;
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
            });
          }
        },
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyWidgets.text("Enter Amount", 20.0, FontWeight.bold, Color(0xff04123B), context,false),
        SizedBox(height: 5,),
        FractionallySizedBox(
          widthFactor: 0.7,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
            maxLines: 1,
            controller: widget.controller,
            decoration: InputDecoration(

              prefixIcon: dropdown,
              hintText: "1000",
              contentPadding: const EdgeInsets.only(bottom: 0, right: 48,top: 0),
              focusedBorder: UnderlineInputBorder(

              ),
              enabledBorder: UnderlineInputBorder(

              ),
            ),
            style: TextStyle(fontSize: MF(20, context),fontFamily: "Poppins",fontWeight: FontWeight.bold,color: Color(0xff04123B)),
            textAlign: TextAlign.center,
            inputFormatters: [
              ThousandsFormatter(),
            ],
            validator: (value) {
              final newValue = value?.replaceAll(RegExp(r'^[0-9]'), '');
              final intValue = int.tryParse(newValue ?? '0');
              if (intValue != null &&
                  intValue <= _supportedCurrency[selectedCurrency]!) {
                return null;
              }
              return 'Invalid Input';
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Maximum of $maxInput',
          style: TextStyle(fontSize: MF(16, context)),
        )
      ],
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
              width: 150,
              child: MyWidgets.button("Home",(){},Color(0xff04123B),context),
            ),
            SizedBox(height: 20,),
            TextButton(
                onPressed: (){
                 // MyWidgets.navigatePR(PaymentDetails(howMuch: "100", who: "Nikko", account: "13131", transaction: "13425"), context);
                },
                child: MyWidgets.text("Transaction Details", 15.0, FontWeight.bold,Colors.black,context,false)
            )
          ],
        ),
      ),
    );
  }
}