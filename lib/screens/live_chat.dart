import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:spotmii/widgets.dart';

import '../main.dart';

class LiveChat extends StatelessWidget {
  const LiveChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Live Chat", context),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height -  MediaQuery.of(context).viewPadding.top,
          width: MediaQuery.of(context).size.width,
          child: Tawk(
            directChatLink: 'https://tawk.to/chat/651ad647e6bed319d00504ff/1hboda28m',
            visitor: TawkVisitor(
              name: "${currentUser!.fname} ${currentUser!.lname}",
              email: currentUser!.email,
            ),
          ),
        ),
      ),
    );
  }
}
