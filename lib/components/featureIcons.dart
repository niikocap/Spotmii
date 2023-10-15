import 'package:flutter/material.dart';
import 'package:spotmii/components/text.dart';
import 'constants.dart';

class MyIcons{
  static feature(image,callback,color,text,textcolor,context){
    return SizedBox(
      width: ((MediaQuery.of(context).size.width * 0.9) / 5),
      child: GestureDetector(
        onTap: callback,
        //width: (MediaQuery.of(context).size.width * .9) / 4.5,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5)
              ),
              padding: const EdgeInsets.all(15),
              width: ((MediaQuery.of(context).size.width * 0.9) / 5.6),
              //height: ((MediaQuery.of(context).size.width * 1) / 6),
              child: Image.asset(image,height: 27.5,),
            ),
            const SizedBox(height: 5,),
            myText(text:text,overflow:TextOverflow.ellipsis,style:myStyle(size:MF(14,context),color: textcolor).create(),).create(),
          ],
        ),
      ),
    );
  }
}