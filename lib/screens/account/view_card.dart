import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import '../../widgets.dart';

class AccountCard extends StatefulWidget {
  final cardType;
  final cardNumber;
  final cardName;
  final cardexp;
  final cardCVV;
  const AccountCard({super.key, required this.cardType,required this.cardNumber,required this.cardName,required this.cardexp,required this.cardCVV});

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
          const SizedBox(height: 40,),
          CreditCardWidget(
            cardNumber: widget.cardNumber,
            expiryDate: widget.cardexp,
            cardHolderName: widget.cardName,
            isHolderNameVisible: true,
            cvvCode: widget.cardCVV,
            showBackView: false,
            cardBgColor: const Color(0xff04123B),
            onCreditCardWidgetChange: (CreditCardBrand ) {

            }, //true when you want to show cvv(back) view
          ),
        ],
      ),
    );
  }
}