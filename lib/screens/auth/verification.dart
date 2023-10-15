import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../../database.dart';
import '../../widgets.dart';
import 'login.dart';

class SignVerify extends StatefulWidget {
  const SignVerify({Key? key}) : super(key: key);

  @override
  State<SignVerify> createState() => _SignVerifyState();
}

class _SignVerifyState extends State<SignVerify> {
  late Timer _time1;
  late Timer _time2;
  int time1 = 0;
  int time2 = 0;
  bool timer1On = false;
  bool timer2On = false;
  String verCode1 = "";
  String verCode2 = "";
  bool mVerErrorOn = false;
  bool eVerErrorOn = false;
  FocusNode _focus8 = FocusNode();
  FocusNode _focus9 = FocusNode();
  var emailVerification = TextEditingController();
  var mobileVerification = TextEditingController();
  String mVerErrorMessage = "";
  String eVerErrorMessage = "";
  void initState() {
    super.initState();
    _focus8.addListener(_onFocusChange8);
    _focus9.addListener(_onFocusChange9);
  }
  void dispose() {
    super.dispose();
    _focus8.removeListener(_onFocusChange8);_focus9.removeListener(_onFocusChange9);
    _focus8.dispose();_focus9.dispose();
  }
  void _onFocusChange8() {
    setState(() {
      eVerErrorOn = false;
    });
  }
  void _onFocusChange9() {
    setState(() {
      mVerErrorOn = false;
    });
  }
  String generate(int lengthOfString){
    final random = Random();
    const allChars='1234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
            (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString;    // return the generated string
  }
  String simplifyTime(time){
    time = 300 - time;
    String minutes =( time / 60 ).floor().toString();
    int seconds =( time % 60 );
    String segundo = "";
    segundo = seconds < 10 ? "0" + seconds.toString() : seconds.toString();
    return "$minutes:$segundo";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )
          ),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40,),
              Center(child: MyWidgets.text("Verification Code", 25.0, FontWeight.bold, Color(0xff111111), context,false)),
              SizedBox(height: 40,),
              FractionallySizedBox(widthFactor:0.7,child: Center(child: MyWidgets.text(" For verification purposes please enter the verification code we sent in your email and mobile number to verify your identity.", 15.0, FontWeight.normal, Color(0xff111111), context,false))),
              SizedBox(height: 20,),
              FractionallySizedBox(
                widthFactor:0.8,
                child: MyWidgets.errorTextFormField(emailVerification, "Email Verification Code", Color(0xff111111),context,eVerErrorOn,eVerErrorMessage,_focus8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyWidgets.text("Didn't receive the OTP? ", 15.0, FontWeight.normal, Color(0xff111111), context,false),
                  TextButton(
                    onPressed: ()async{
                      if(!timer1On){
                        timer1On = true;
                        verCode2 = generate(6);

                        var checking = await Database(url: url).send({
                          "req" : "tryverify",
                          "email" :currentUser!.email,
                          "code1" : verCode1,
                          "code2" : verCode2,
                        });
                        await Database(url: "https://ipostup.site/assets/php/mail/sendmail1.php").send({
                          "email" : "spotmiiapp@gmail.com",
                          "password" : "avqiwruhgwqifkog",
                          "target" :currentUser!.email,
                          "subject" : "SpotMii App Verification",
                          "body" : "To continue signing up on SpotMii your Email verification code is $verCode1."
                        });
                        print(checking);
                        _time1 = Timer.periodic(Duration(seconds: 1), (time) {
                          setState(() {
                            if(time1 >= 300){
                              time1 = 0;
                              timer1On = false;
                              _time1.cancel();
                            }
                            time1++;
                          });

                        });

                      }else{
                        MyWidgets.message("Verification already sent! ${time1}", context);
                      }
                    },
                    child: MyWidgets.text("RESEND OTP", 16.0, FontWeight.bold, Color(0xff04123B), context,false),
                  ),
                  MyWidgets.text("${simplifyTime(time1)}", 17.0, FontWeight.bold, Colors.red, context,false),
                ],
              ),
              FractionallySizedBox(
                widthFactor:0.8,
                child: MyWidgets.errorTextFormField(mobileVerification, "Mobile Verification Code", Color(0xff111111),context,eVerErrorOn,mVerErrorMessage,_focus9),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyWidgets.text("Didn't receive the OTP? ", 15.0, FontWeight.normal, Color(0xff111111), context,false),
                  TextButton(
                    onPressed: ()async{
                      if(!timer2On){
                        timer2On = true;
                        verCode1 = generate(6);
                        var checking = await Database(url: url).send({
                          "req" : "tryverify",
                          "email" :currentUser!.email,
                          "code1" : verCode1,
                          "code2" : verCode2,
                        });
                        await Database(url: "https://ipostup.site/assets/php/mail/sendmail1.php").send({
                          "email" : "spotmiiapp@gmail.com",
                          "password" : "avqiwruhgwqifkog",
                          "target" :currentUser!.email,
                          "subject" : "SpotMii App Verification",
                          "body" : "To continue signing up on SpotMii your Mobile verification code is $verCode2."
                        });
                        print(checking);

                        _time2 = Timer.periodic(Duration(seconds: 1), (time) {
                          setState(() {
                            if(time2 >= 300){
                              time2 = 0;
                              timer2On = false;
                              _time2.cancel();
                            }
                            time2++;
                          });

                        });

                      }else{
                        MyWidgets.message("Code Already Sent!", context);
                      }
                    },
                    child: MyWidgets.text("RESEND OTP", 16.0, FontWeight.bold, Color(0xff04123B), context,false),

                  ),
                  MyWidgets.text("${simplifyTime(time2)}", 17.0, FontWeight.bold, Colors.red, context,false),
                ],
              ),
              SizedBox(height: 40,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: MyWidgets.button("Submit", ()async{
                  showDialog(
                      barrierDismissible: false,
                      context: context, builder: (context){
                    return Center(
                      child:CircularProgressIndicator(),
                    );
                  });
                  //getVerification code
                  var verify = await Database(url: url).send({
                    "req" : "verify",
                    "email" : currentUser!.email
                  });
                  verCode1 = jsonDecode(verify)[0];
                  verCode2 = jsonDecode(verify)[1];
                  if(emailVerification.text.trim() == verCode1.toString() && mobileVerification.text.trim() == verCode2){
                    Database(url: url).send({
                      "req" : "verified",
                      "code1" : verCode1,
                      "code2" : verCode2
                    });
                    MyWidgets.navigatePR(MyWidgets.congratulation("Congratulations", "Your account has been successfully created!", (){
                      MyWidgets.navigatePR(Login(), context);
                    }, context, "Sign In"), context);
                  }else{
                    eVerErrorOn = true;
                    eVerErrorMessage = "Wrong Verification Code";
                    mVerErrorOn = true;
                    mVerErrorMessage = "Wrong Verification Code";
                  }
                }, Color(0xff04123B), context),
              )

            ],
          ),
        ),
      ),
    );
  }
}