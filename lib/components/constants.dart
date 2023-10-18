import 'package:flutter/material.dart';
import 'package:spotmii/models/user_model.dart';

//todo assign values
Color mainColor = Colors.red;
String url = "https://app.spotmii.com.au/services.php";
Color button = const Color(0xff04123B);
SpotMiiUser? currentUser;
late final isLogin;
late final user;
late final password;
const supportedCurrency = {'PHP':10000, '\$': 10000, '€': 800,'¥':10000,'£':10000,'Fr':10000,'A\$':10000,'C¥':10000};
const supportedCurrency1 = {'PHP':10000, '\$': 10000, '€': 800,'¥':10000,'£':10000,'Fr':10000,'A\$':10000,'C¥':10000};

double MF(size,context){

  double ratio = MediaQuery.of(context).devicePixelRatio;
  return ratio < 2.5 ? (size / 2.75) * 2 : ratio <= 3 ? (size / 2.75) * 2.2 : ratio <= 3.5 ? (size / 2.75) * 2.1 : ratio <= 4 ? (size / 2.75) * 2 : size;
}