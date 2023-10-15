import 'package:flutter/material.dart';

import '../../widgets.dart';

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