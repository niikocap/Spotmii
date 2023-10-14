import 'package:flutter/material.dart';
//todo assign values
Color mainColor = Colors.red;
String url = "https://app.spotmii.com.au/services.php";
Color button = Color(0xff04123B);

double MF(size,context){
  double ratio = MediaQuery.of(context).devicePixelRatio;
  //return MediaQuery.of(context).textScaleFactor * size;
  if(ratio > 2.4){
    return (size / 2.75) * 2.2;
  }else{
    return ( size / 2.75 ) * ratio;
  }
}