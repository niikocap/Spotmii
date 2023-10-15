import 'package:flutter/material.dart';
import 'package:spotmii/models/user_model.dart';

//todo assign values
Color mainColor = Colors.red;
String url = "https://app.spotmii.com.au/services.php";
Color button = Color(0xff04123B);
late SpotMiiUser? currentUser;
const supportedCurrency = {'PHP':10000, '\$': 10000, '€': 800,'¥':10000,'£':10000,'Fr':10000,'A\$':10000,'C¥':10000};
const supportedCurrency1 = {'PHP':10000, '\$': 10000, '€': 800,'¥':10000,'£':10000,'Fr':10000,'A\$':10000,'C¥':10000};

double MF(size,context){
  double ratio = MediaQuery.of(context).devicePixelRatio;
  //return MediaQuery.of(context).textScaleFactor * size;
  if(ratio > 2.4){
    return (size / 2.75) * 2.2;
  }else{
    return ( size / 2.75 ) * ratio;
  }
}