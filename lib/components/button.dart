import 'package:flutter/material.dart';
import 'package:spotmii/components/text.dart';
import 'constants.dart';

class myButton{
  final callback;
  Color? color;
  Text? customText;
  String text;
  double size;
  myButton({required this.callback,this.color,this.customText,required this.text,required this.size});
  ElevatedButton create(){
    return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: color != null ? color : mainColor,
        ),
        child: customText != null ? myText(text: text, style: myStyle(size: size).create()).create() : customText,
    );
  }
}
