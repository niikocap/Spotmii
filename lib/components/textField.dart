import 'package:flutter/material.dart';

import '../widgets.dart';

class MyTextField{
  Color color;
  double borderRadius,size;
  bool? isPassword;
  final context;
  MyTextField({required this.color,required this.borderRadius,required this.size,this.isPassword,required this.context});
  withFocus(focus,controller,hintText,error,errorOn){
    OutlineInputBorder border = OutlineInputBorder(
      borderSide:  BorderSide(color: color, width: 1.5,),
      borderRadius: BorderRadius.circular(borderRadius),
    );
    return Container(
      alignment: Alignment.center,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            obscureText: isPassword != null ? true : false,
            focusNode: focus,
            controller: controller,
            style: TextStyle(
                color: color,
                fontSize: size,
                fontFamily: "Poppins"
            ),
            decoration:  InputDecoration(
              filled: true,
              focusedBorder: border,enabledBorder: border,errorBorder: border,focusedErrorBorder: border,fillColor: Colors.white,
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
              hintStyle: TextStyle(
                  color: color,
                  fontSize: size,
                  fontFamily: "Poppins"
              ),
            ),
          ),
          Positioned(
            right: ( MediaQuery.of(context).size.width / 20 ),
            //top: 12.5,
            child: Visibility(
              visible: errorOn,
              child: Text(
                error,
                style: TextStyle(
                    fontSize: MF(14, context),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    color:Colors.red
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  create(controller,hintText){
    BorderSide borderSide = BorderSide(color: color, width: 1.5,);
    var border = OutlineInputBorder(
      borderSide:  borderSide,
      borderRadius: BorderRadius.circular(40),
    );
    return Container(
      height: 45,
      child: Align(
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          obscureText: isPassword != null ? true : false,
          decoration:  InputDecoration(
            filled: true,
            focusedBorder: border,enabledBorder: border,
            fillColor: Colors.white,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
            hintStyle: TextStyle(
                color: color,
                fontSize: MF(18,context)
            ),
          ),
          style: TextStyle(
              fontSize: MF(17, context),
              fontFamily: "Poppins",
              color:color
          ),
        ),
      ),
    );
  }
}