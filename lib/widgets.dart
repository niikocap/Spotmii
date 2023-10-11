import 'package:flutter/material.dart';
import 'package:spotmii/screens/help_center.dart';
import 'package:spotmii/screens/home.dart';
import 'package:spotmii/screens/notifications.dart';
import 'package:spotmii/screens/profile.dart';
import 'package:spotmii/screens/qrscanner.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'components/constants.dart';

class MyWidgets{
  static TextStyle TS(size,context,color,weight){
    return TextStyle(
        fontWeight: weight,
        fontFamily: "Poppins",
        fontSize: MF(size,context),
        color: color
    );
  }
  static textField(TextEditingController controller,String hint,Color color,context){
    BorderSide borderSide = BorderSide(color: color, width: 2.0,);
    return Container(
      height: 45,
      child: Align(
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          obscureText: false,
          decoration:  InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide:  borderSide,
              borderRadius: BorderRadius.circular(40),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: BorderRadius.circular(40),
            ),
            fillColor: Colors.white,
            hintText: hint,
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
  static TextField textField1(TextEditingController controller,String hint,Color color){
    BorderSide borderSide = BorderSide(color: color, width: 2.0,);
    return TextField(
      controller: controller,
      obscureText: false,
      decoration:  InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide:  borderSide,
          borderRadius: BorderRadius.circular(40),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide,
          borderRadius: BorderRadius.circular(40),
        ),
        fillColor: Colors.white,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
        hintStyle: TextStyle(
            color: color,
            fontSize: 15,
            fontFamily: "Poppins"
        ),
      ),
    );
  }
  static textFormField(TextEditingController controller,String hint,Color color,validation,context){
    OutlineInputBorder border = OutlineInputBorder(
      borderSide:  BorderSide(color: color, width: 1.5,),
      borderRadius: BorderRadius.circular(20),
    );
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        /*
        boxShadow: [
          BoxShadow(
              offset: Offset(0,8),
              color: color,
              blurRadius: 5,
              spreadRadius: -5
          ),
        ]

         */
      ),
      child: Stack(
        children: [
          TextFormField(
            validator: validation,
            controller: controller,
            obscureText: false,
            decoration:  InputDecoration(
              filled: true,
              focusedBorder: border,
              enabledBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
              fillColor: Colors.white,
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              hintStyle: TextStyle(
                  color: color,
                  fontSize: MF(17,context),
                  fontFamily: "Poppins"
              ),
            ),
            style: TextStyle(
                fontSize: MF(18, context),
                fontFamily: "Poppins",
                color:color
            ),
          ),
          //text(error, 17 , FontWeight.normal, Colors.red, context)
        ],
      ),
    );
  }
  static passwordFormField(TextEditingController controller,String hint,Color color,validation,visible,todo,context){
    OutlineInputBorder border = OutlineInputBorder(
      borderSide:  BorderSide(color: color, width: 1.5,),
      borderRadius: BorderRadius.circular(20),
    );
    return Container(
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          /*
          boxShadow: [
            BoxShadow(
                offset: Offset(0,8),
                color: color,
                blurRadius: 5,
                spreadRadius: -5
            ),
          ]

           */
      ),
      child: SizedBox(
        child: TextFormField(
          validator: validation,
          controller: controller,
          obscureText: visible,
          decoration:  InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(!visible ? Icons.visibility : Icons.visibility_off,color: color,size: MF(30, context),),
              onPressed: todo,
            ),
            filled: true,
            focusedBorder: border,
            enabledBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
            fillColor: Colors.white,
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            hintStyle: TextStyle(
                color: color,
                fontSize: MF(17, context),
                fontFamily: "Poppins"
            ),
          ),
        ),
      ),
    );
  }
  static errorTextFormField(TextEditingController controller,String hint,Color color,context,errorOn,error,focus){
    OutlineInputBorder border = OutlineInputBorder(
      borderSide:  BorderSide(color: color, width: 1.5,),
      borderRadius: BorderRadius.circular(20),
    );
    return Container(
      alignment: Alignment.center,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          /*
          boxShadow: [
            BoxShadow(
                offset: Offset(0,8),
                color: color,
                blurRadius: 5,
                spreadRadius: -5
            ),
          ]

           */
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            //textAlignVertical: TextAlignVertical.center,
            focusNode: focus,
            controller: controller,
            style: TextStyle(
                color: color,
                fontSize: MF(17, context),
                fontFamily: "Poppins"
            ),
            decoration:  InputDecoration(
              filled: true,
              focusedBorder: border,
              enabledBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
              fillColor: Colors.white,
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
              hintStyle: TextStyle(
                  color: color,
                  fontSize: MF(17, context),
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
  static errorPasswordFormField(TextEditingController controller,String hint,Color color,context,visible, errorOn,error,focus,todo){
    OutlineInputBorder border = OutlineInputBorder(
      borderSide:  BorderSide(color: color, width: 1.5,),
      borderRadius: BorderRadius.circular(20),
    );
    return Container(
      alignment: Alignment.center,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          /*
          boxShadow: [
            BoxShadow(
                offset: Offset(0,8),
                color: color,
                blurRadius: 5,
                spreadRadius: -5
            ),
          ]

           */
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            focusNode: focus,
            obscureText: visible,
            controller: controller,
            style: TextStyle(
                color: color,
                fontSize: MF(17, context),
                fontFamily: "Poppins"
            ),
            decoration:  InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(!visible ? Icons.visibility : Icons.visibility_off,color: color,size: MF(30, context),),
                onPressed: todo,
              ),
              filled: true,
              focusedBorder: border,
              enabledBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
              fillColor: Colors.white,
              hintText: hint,

              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
              hintStyle: TextStyle(
                  color: color,
                  fontSize: MF(17, context),
                  fontFamily: "Poppins"
              ),
            ),
          ),
          Positioned(
            right: ( MediaQuery.of(context).size.width / 10 ) + 5,
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
  static button(text,callback,color,context){
    return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: color,
        ),
        child: MyWidgets.text(text, 17, FontWeight.bold, Colors.white, context,false)
    );
  }
  static Text text(text,size,weight,color,context,el){
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: el ? TextOverflow.ellipsis : TextOverflow.visible,
      style: TS(size,context,color,weight),
    );
  }
  static Widget congratulation(type,String message,callback,context,buttonn){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        title: MyWidgets.text("", 22.0, FontWeight.bold, Color(0xff111111),context,false),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height:40,
            ),
            IconButton(
              icon: Image.asset('assets/3.png'),
              iconSize: 150,
              onPressed: () {},
            ),
            SizedBox(height: 50,),
            MyWidgets.text(type, 30.0, FontWeight.bold,Colors.black,context,false),
            SizedBox(height: 30,),
            Align(
                alignment:Alignment.center,
                child: Container(
                  width: 300,
                    child: MyWidgets.text(message, 17.0, FontWeight.normal,Colors.black,context,false)
                )
            ),
            SizedBox(height: 40,),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.8,
              child: button(buttonn,callback,Color(0xff04123B),context),
            )
          ],
        ),
      ),
    );
  }
  static navigatePR(Widget to,context){
    Navigator.pushReplacement<void, void>(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => to,
        transitionDuration: Duration(milliseconds: 50),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );
  }
  static navigateP(Widget to,context){
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => to,
        transitionDuration: Duration(milliseconds: 50),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );
  }
  static AppBar appbar(String title,context){
    return AppBar(
        title: MyWidgets.text(title, 20.0, FontWeight.bold, Color(0xff111111),context,false),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){MyWidgets.navigatePR(Home(), context);}, icon: Image.asset("assets/homeicon.png"),iconSize: 15,),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Image.asset("assets/backicon.png"),
            iconSize: 15,
          ),
        )
    );
  }
  static AppBar appbar1(String title,context){
    return AppBar(
        title: MyWidgets.text(title, 20.0, FontWeight.bold, Color(0xff111111),context,false),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Image.asset("assets/backicon.png"),
            iconSize: 15,
          ),
        )
    );
  }
  static Widget transaction(background,who,type,price,date,context,data){
    return GestureDetector(
      onTap: (){
        //MyWidgets.navigateP(PaymentDetails(howMuch: data["howmuch"], who: data["who"], account: data["account"], transaction: data["transaction"]), context);
        message("UnderConstruction", context);
      },
      child: Container(
        height:70,
        margin: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.1,color: Colors.grey)
            )
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height:45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color:Color(0xffF1F1F1),
                ),
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(0,0,20,0),
                child: CircleAvatar(
                  backgroundImage: background,
                  radius:50,
                  backgroundColor: Colors.white,
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width * 0.6) - 45,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyWidgets.text(who, 16.0, FontWeight.normal, Color(0xff111111),context,false),
                    MyWidgets.text(type, 14.0, FontWeight.normal, Color(0xff111111),context,false),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyWidgets.text(price, 16.0, FontWeight.normal, Color(0xff111111),context,false),
                    MyWidgets.text(date,  14.0, FontWeight.normal, Color(0xff111111),context,false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  static Widget notification(who,type,date,context,data){
    return GestureDetector(
      onTap: (){
        //MyWidgets.navigateP(PaymentDetails(howMuch: data["howmuch"], who: data["who"], account: data["account"], transaction: data["transaction"]), context);
      },
      child: Container(
        height:70,
        //width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
        decoration: BoxDecoration(

            border: Border(
                bottom: BorderSide(width: 0.1,color: Colors.grey)
            )
          //color: Color(0xffF1F1F1),
          //borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyWidgets.text(who, 18.0, FontWeight.normal, Color(0xff111111),context,false),
                    MyWidgets.text(type, 15.0, FontWeight.normal, Color(0xff111111),context,false),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyWidgets.text(date,  15.0, FontWeight.normal, Color(0xff111111),context,false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  static Widget myBottomBar(context,active){
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.075,
        //margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015,horizontal: MediaQuery.of(context).size.width * 0.1,),
        decoration: BoxDecoration(
          color: Color(0xff8A8A8A).withOpacity(0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              //color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.19,
              height: MediaQuery.of(context).size.height * 0.07,
              child: IconButton(
                icon: Icon(Icons.home,color: active == 0 ? Color(0xff084E80): Colors.black,),
                iconSize: 22.5,
                onPressed: () {
                  if(active != 0){
                    MyWidgets.navigateP(Home(), context);
                  }
                },
              ),
            ),
            Container(
              //color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.19,
              height: MediaQuery.of(context).size.height * 0.07,
              child: IconButton(
                icon: Icon(Icons.notifications,color: active == 1 ? Color(0xff084E80): Colors.black,),
                iconSize: 22.5,
                onPressed: () {
                  if(active != 1){
                    MyWidgets.navigateP(Notifications(), context);
                  }
                },
              ),
            ),
            Container(
              //color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.24,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Container(
                child: IconButton(
                  icon: Icon(Icons.qr_code_2,color: active == 2 ? Color(0xff084E80): Colors.black,),
                  iconSize: 35,
                  onPressed: () {
                    if(active != 2){
                      MyWidgets.navigateP(QRScanner(), context);
                    }
                  },
                ),
              ),
            ),
            Container(
              //color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.19,
              height: MediaQuery.of(context).size.height * 0.07,
              child: IconButton(
                icon: Icon(Icons.help,color: active == 3 ? Color(0xff084E80): Colors.black,),
                iconSize: 22.5,
                onPressed: () {
                  if(active != 3){
                    MyWidgets.navigateP(HelpCenter(), context);
                  }
                },
              ),
            ),
            Container(
              //color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.19,
              height: MediaQuery.of(context).size.height * 0.07,
              child: IconButton(
                icon: Icon(Icons.person,color: active == 4 ? Color(0xff084E80): Colors.black,),
                iconSize: 22.5,
                onPressed: () {
                  if(active != 4){
                    MyWidgets.navigateP(Profile(), context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  static Widget feature(icon,text,callback,color,context){
    return GestureDetector(
      onTap: callback,
      //width: (MediaQuery.of(context).size.width * .9) / 4.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width * .9) / 5.5,
            child: icon,
          ),
          MyWidgets.text(text, 15.0, FontWeight.normal, color,context,false),
        ],
      ),
    );
  }
  static Widget sendAgain(callback,image){
    return IconButton(
        onPressed: callback,
        icon: CircleAvatar(
          backgroundImage: image,
          radius: 40,
        ),
        iconSize: 50,
    );
  }
  static message(text,context){
    var snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static showLoading(){
    return LoadingAnimationWidget.fourRotatingDots(
      color: Colors.white,//Color(0xff04123B),
      size: 50,
    );
  }
}