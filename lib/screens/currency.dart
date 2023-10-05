import 'package:flutter/material.dart';
import 'package:forex_conversion/forex_conversion.dart';
import 'package:spotmii/database.dart';
import 'package:spotmii/main.dart';
import 'package:spotmii/widgets.dart';

import '../models/currency.dart';

class LiveCurrency extends StatefulWidget {
  const LiveCurrency({super.key});

  @override
  State<LiveCurrency> createState() => _LiveCurrencyState();
}
const _supportedCurrency = {'PHP':10000, '\$': 10000, '€': 800,'¥':10000,'£':10000,'Fr':10000,'A\$':10000,'C¥':10000};
class _LiveCurrencyState extends State<LiveCurrency> {
  var rates;
  var usd,php,euro,yen,pound,francs,aud,yuan;
  var selected = _supportedCurrency.entries.first.key;
  var currency1 = "Philippine Peso";
  currencyTile(currency,amount){
    return Container(
      width: MediaQuery.of(context).size.width  * 0.85,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0,0),
                blurRadius: 3,
                color: Colors.grey.withOpacity(0.8)
            )
          ],
          color: Colors.white
      ),
      child: Row(
        children: [
          MyWidgets.text("${currency} : ", 20, FontWeight.bold, Color(0xff111111), context, false),
          MyWidgets.text("${amount}", 20, FontWeight.bold, Color(0xff111111), context, false)
        ],
      ),
    );
  }
  getRates()async{
    final fx = Forex();
    //rates = rates["rates"];
    usd = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "USD");
    php = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "PHP");
    pound = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "GBP");
    yen = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "JPY");
    yuan = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "CNY");
    euro = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "EUR");
    aud = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "AUD");
    francs = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "CHF");
    return "1";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Live Currency", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                children: [
                  ButtonTheme(
                    child: DropdownButton<String>(
                      underline: Container(height: 0,),
                      items: {"PHP", '\$', '€','¥','£','Fr','A\$','C¥'}
                          .map<DropdownMenuItem<String>>(
                            (e) => DropdownMenuItem(
                            alignment: Alignment.center,
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
                      value: selected,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                        size: 25,
                      ),
                      onChanged: (value) async{
                        if (value != null) {
                          selected = value;
                        }
                        if(value == 'PHP'){
                          currency1 = "Philippine Peso";
                        }else if(value == '\$'){
                          currency1 = "US Dollar";
                        }else if(value == '€'){
                          currency1 = "Euro";
                        }else if(value == '£'){
                          currency1 = "Pound";
                        }else if(value == 'A\$'){
                          currency1 = "Australian Dollar";
                        }else if(value == 'Fr'){
                          currency1 = "Swiss Franc";
                        }else if(value == 'C¥'){
                          currency1 = "Chinese Yuan";
                        }else if(value == '¥'){
                          currency1 = "Japanese Yen";
                        }
                        final fx = Forex();
                        //rates = rates["rates"];
                        usd = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "USD");
                        php = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "PHP");
                        pound = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "GBP");
                        yen = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "JPY");
                        yuan = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "CNY");
                        euro = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "EUR");
                        aud = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "AUD");
                        francs = await fx.getCurrencyConverted(sourceCurrency: Currency.getCode(currency1),destinationCurrency: "CHF");
                        setState(() {

                        });
                      },
                    ),
                  ),
                  MyWidgets.text("Base Currency: ${currency1}", 20, FontWeight.bold, Color(0xff111111), context, false),
                ],
              ),
            ),
            FutureBuilder(
              future: getRates(),
              builder: (context,snapshot) {
                if(snapshot.hasData){
                  return Container(
                    height: MediaQuery.of(context).size.height  * 0.8,
                    width: MediaQuery.of(context).size.width  * 0.85,
                    child: ListView(
                      children: [
                        currencyTile("US Dollar",usd),
                        currencyTile("Philippine Peso",php),
                        currencyTile("Pound",pound),
                        currencyTile("Japanse Yen",yen),
                        currencyTile("Chinese Yuan",yuan),
                        currencyTile("Euro",euro),
                        currencyTile("Australian Dollars",aud),
                        currencyTile("Swiss Francs",francs),
                      ],
                    ),
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

              }
            ),
          ],
        ),
      ),
    );
  }
}
