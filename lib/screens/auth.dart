import 'package:flutter/material.dart';
import 'package:spotmii/widgets.dart';

import '../components/text.dart';

class TwoFactorAuth extends StatefulWidget {
  const TwoFactorAuth({Key? key}) : super(key: key);

  @override
  State<TwoFactorAuth> createState() => _TwoFactorAuthState();
}

class _TwoFactorAuthState extends State<TwoFactorAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            myText(text:"Two-Factor Authentication",style:myStyle(size:MF(53,context),).create(),).create(),
            Container(
              color: Color(0xff04123B),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 60,
              child: Row(
                children: [
                  myText(text: "2FA Security",style:myStyle(size:MF(15, context),color: Colors.white).create(),).create(),
                  //MyWidgets.text("", 15, FontWeight.bold, Colors.white, context,false),

                  //text field
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
