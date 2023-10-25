import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:spotmii/components/xendit.dart';

import 'config.dart';

class Payment extends StatelessWidget {
  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }
  const Payment({super.key});
  @override
  xenditTest()async{
    Xendit xendit = Xendit(apiKey: "xnd_development_9vpgnC3cFUrnzQCt2YXogOKkV1fiIVKPB4B4AkOaL2HxqleIDZjaFpfrKmm1N6f9");
    var res = await xendit.createAccount(email: "a@gmail.com", type: "OWNED",bussiness_name: "Nikko Testing Account");
    print(res);
    return res;
  }
  @override
  Widget build(BuildContext context) {
    List<PaymentItem> paymentItems = [
      const PaymentItem(
        label: 'Total',
        amount: '99.99',
        status: PaymentItemStatus.final_price,
      )
    ];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GooglePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(
                  defaultGooglePay),
              paymentItems: paymentItems,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            FutureBuilder(future: xenditTest(), builder: (context,snapshot){
              if(snapshot.hasData){
                print(snapshot.data!.toString());
                return Text("hello");
              }else{
                return CircularProgressIndicator();
              }

            })
          ],
        ),
      ),
    );
  }
}
