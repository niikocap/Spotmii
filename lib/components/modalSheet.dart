import 'package:flutter/material.dart';
import 'package:spotmii/components/text.dart';

import '../widgets.dart';
import 'constants.dart';

class bmSheet{
  double height;
  Widget body;
  final context;
  bmSheet({required this.height,required this.body,required this.context});
  create(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: body,
        );
      }
    );
  }
  static success(title,message,button,context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                )
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/3.png",width: MediaQuery.of(context).size.width * 0.5,),
                SizedBox(height: 20,),
                myText(text:title,style:myStyle(size:MF(35,context),weight: FontWeight.bold).create(),).create(),
                FractionallySizedBox(widthFactor:0.9,child: myText(text:message,alignment:TextAlign.center,style:myStyle(size:MF(20,context),).create(),).create()),
                SizedBox(height: 20,),
                button,
              ],
            ),
          );
        }
    );
  }
  static error(title,message,button,context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                )
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/failed.png",width: MediaQuery.of(context).size.width * 0.5,),
                SizedBox(height: 20,),
                myText(text:title,style:myStyle(size:MF(35,context),weight: FontWeight.bold).create(),).create(),
                FractionallySizedBox(widthFactor:0.9,child: myText(text:message,alignment:TextAlign.center,style:myStyle(size:MF(20,context),).create(),).create()),
                SizedBox(height: 20,),
                button,
                FractionallySizedBox(
                  widthFactor: 0.80,
                  child:  MyWidgets.button("Retry", (){
                    Navigator.pop(context);
                  }, Color(0xff04123B), context),
                )
              ],
            ),
          );
        }
    );
  }
}