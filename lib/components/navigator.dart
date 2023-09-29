import 'package:flutter/material.dart';

class MyNavigation{
  MyNavigation();
  static push(context,to){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => to,
      ),
    );
  }
  static pop(context){
    Navigator.pop(context);
  }
  static pushReplace(context,to){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
       builder: (context) => to, 
      )
    );
  }
  static popUntil(context,to){
    Navigator.popUntil(context, to);
  }
}