import 'package:flutter/material.dart';
import '../../widgets.dart';

class TopUpFailed extends StatefulWidget {
  const TopUpFailed({Key? key}) : super(key: key);

  @override
  State<TopUpFailed> createState() => _TopUpFailedState();
}

class _TopUpFailedState extends State<TopUpFailed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          IconButton(
            icon: Image.asset('assets/failed.png'),
            iconSize: 140,
            onPressed: () {},
          ),
          const SizedBox(height: 10,),
          MyWidgets.text("Failed!", 33.0, FontWeight.bold,Colors.black,context,false),
          const SizedBox(height: 20,),
          Align(
              alignment:Alignment.center,
              child: SizedBox(
                  width: 300,
                  child: MyWidgets.text("You don't have enough money on your bank account. Try again", 17.0, FontWeight.normal,Colors.black,context,false)
              )
          ),
          const SizedBox(height: 40,),
          SizedBox(
            height: 40,
            width: 150,
            child: MyWidgets.button("Home",(){},const Color(0xff04123B),context),
          ),
          const SizedBox(height: 20,),
          TextButton(
              onPressed: (){

              },
              child: MyWidgets.text("Transaction Details", 15.0, FontWeight.bold,Colors.black,context,false)
          )
        ],
      ),
    );
  }
}