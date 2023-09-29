import 'package:flutter/material.dart';

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
}