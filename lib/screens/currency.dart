import 'package:flutter/material.dart';
import 'package:spotmii/database.dart';
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
                        //rates = await Database.conversionRates(Currency.getCode(currency1));
                        rates = rates["rates"];
                        usd = 1 * rates["USD"];
                        php = 1 * rates["PHP"];
                        pound = 1 * rates["GBP"];
                        yen = 1 * rates["JPY"];
                        yuan = 1 * rates["CNY"];
                        euro = 1 * rates["EUR"];
                        aud = 1 * rates["AUD"];
                        francs = 1 * rates["CHF"];
                        setState(() {

                        });
                      },
                    ),
                  ),
                  MyWidgets.text("Base Currency: ${currency1}", 20, FontWeight.bold, Color(0xff111111), context, false),
                ],
              ),
            ),
            Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
