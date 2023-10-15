import 'package:flutter/material.dart';
import '../screens/home.dart';
import 'navigator.dart';

class myAppbar{
  String title;
  double size;
  final BuildContext context;
  myAppbar({required this.title,required this.size,required this.context});
  AppBar create(){
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(onPressed: (){
            MyNavigation.push(context,const Home());
          }, icon: Image.asset("assets/homeicon.png"),iconSize: 15,),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: IconButton(
          onPressed: (){
            MyNavigation.pop(context);
          },
          icon: Image.asset("assets/backicon.png"),
          iconSize: 15,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: const Color(0xff111111)
        ),
      ),
    );
  }
}