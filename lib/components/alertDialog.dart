import 'package:flutter/material.dart';

class myAlert{
  final context;
  myAlert({required this.context});
  create(){
    showDialog(
      context: context,
      builder: (context){
        return Container(
          //dialog component
        );
      }
    );
  }
}