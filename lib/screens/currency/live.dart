import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forex_conversion/forex_conversion.dart';
import 'package:spotmii/widgets.dart';
import '../../components/constants.dart';
import '../../components/text.dart';
import '../../database.dart';
import '../../models/currency.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0,0),
                blurRadius: 3,
                color: Colors.grey.withOpacity(0.5)
            )
          ],
          color: Colors.white
      ),
      child: Row(
        children: [
          MyWidgets.text("1 $currency1 = ", 20, FontWeight.bold, const Color(0xff111111), context, false),
          MyWidgets.text("$amount $currency", 20, FontWeight.bold, const Color(0xff111111), context, false)
        ],
      ),
    );
  }

  Future<List<SalesData>>getData(currency,base)async{
    List<SalesData> datas = [];
    for(int i = 0;i<14;i++){
      var now = DateTime.now().subtract(Duration(days: i));
      var day = now.day < 10 ? "0${now.day}" : now.day;
      var month = now.month < 10 ? "0${now.month}" : now.month;
      var data =  jsonDecode(await Database(url: "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/${now.year}-$month-$day/currencies/$base.json").get());
      datas.add(SalesData(now, data[base][currency]));
    }
    return datas;
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
  void initState() {
    getData("usd", "php");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Live Currency", context),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
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
                    MyWidgets.text("Base Currency: $currency1", 20, FontWeight.bold, const Color(0xff111111), context, false),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              myText(text:"Graph of ${currentUser!.currency} vs value in $currency1 in the past 2 Weeks",style:myStyle(size:MF(16,context),).create(),).create(),
              const SizedBox(height: 10,),
              FutureBuilder(
                future: getData(Currency.getCode(currency1).toString().toLowerCase(), currentUser!.currency),
                builder: (context,AsyncSnapshot<List<SalesData>>snapshot){
                  if(snapshot.hasData){
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 200,
                      child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(
                          interval: 1,
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        series: <ChartSeries<SalesData, DateTime>>[
                          SplineAreaSeries<SalesData, DateTime>(
                            dataSource:  snapshot.data!,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales,
                          ),
                        ],
                        primaryYAxis: NumericAxis(numberFormat: NumberFormat.simpleCurrency(locale:Currency.getLocale(currency1),decimalDigits:2)),
                      ),
                    );
                  }else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(height: 10,),
              FutureBuilder(
                  future: getRates(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return SizedBox(
                        height: MediaQuery.of(context).size.height  * 0.8,
                        width: MediaQuery.of(context).size.width  * 0.85,
                        child: ListView(
                          children: [
                            currencyTile("US Dollar",usd),
                            currencyTile("Philippine Peso",php),
                            currencyTile("Pound",pound),
                            currencyTile("Japanese Yen",yen),
                            currencyTile("Chinese Yuan",yuan),
                            currencyTile("Euro",euro),
                            currencyTile("Australian Dollars",aud),
                            currencyTile("Swiss Francs",francs),
                          ],
                        ),
                      );
                    }else{
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}