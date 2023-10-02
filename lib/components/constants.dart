import 'package:flutter/material.dart';
//todo assign values
Color mainColor = Colors.red;
String url = "https://app.spotmii.com.au/services.php";

double MF(size,context){
  double ratio = MediaQuery.of(context).devicePixelRatio;
  if(ratio == 2.625){
    return (size / 2.75) * 2;
  }else if(ratio > 2.5){
    return (size / 2.75) * 2.2;
  }else{
    return ( size / 2.75 ) * ratio;
  }
}