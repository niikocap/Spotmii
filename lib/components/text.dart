import "package:flutter/material.dart";

class myStyle{
  FontWeight? weight;
  double size;
  Color? color;
  String? family;
  myStyle({this.weight,required this.size,this.color,this.family});
  TextStyle create(){
    return TextStyle(
      fontWeight: weight != null ? weight : FontWeight.normal,
      fontSize: size,
      color: color != null ? color : Color(0xff111111),
      fontFamily: family != null ? "Poppins" : family,
    );
  }
}

class myText{
  String text;
  TextStyle style;
  TextAlign? alignment;
  TextOverflow? overflow;
  myText({required this.text,required this.style,this.alignment,this.overflow});
  Text create(){
    return Text(
      text,
      textAlign: alignment != null ? alignment : TextAlign.left,
      overflow: overflow != null ? overflow : TextOverflow.visible,
      style: style,
    );
  }
}