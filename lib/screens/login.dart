import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotmii/screens/forgot_password.dart';
import 'package:spotmii/screens/signup.dart';
import 'package:spotmii/database.dart';
import 'package:spotmii/widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:spotmii/user_type/admin/admin.dart';
import '../components/constants.dart';
import '../main.dart';
import 'package:spotmii/user_type/merchant/merchant.dart';
import '../models/user_model.dart';
import 'home.dart';
import 'package:sms_autofill/sms_autofill.dart';

late String currEmail;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var con1 = TextEditingController(), con2 = TextEditingController(),con3 = TextEditingController(), con4 = TextEditingController(), con5 = TextEditingController(), con6 = TextEditingController();
  FocusNode _focus1 = FocusNode();
  FocusNode _focus2 = FocusNode();
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  int errorIndex = 0;
  int time2 = 0;
  bool emailErrorOn = false, otpVisible = false;
  bool passwordErrorOn = false;
  bool opt2Visible = false;
  String emailErrorMessage = "";
  String passwordErrorMessage = "";
  String _code = "";
  late Timer _time2;
  bool timer2On = false;
  bool errorVisible = false;
  List<String> error = ["","User doesn't exist, tap sign up to create an account.","Invalid credentials try again or Forgot password."];
  //final _formKey = GlobalKey<FormState>();
  bool visible = true;
  @override
  void initState() {
    super.initState();
    _focus1.addListener(_onFocusChange1);
    _focus2.addListener(_onFocusChange2);
  }
  void _onFocusChange1() {
    setState(() {
      emailErrorOn = false;
    });
  }
  void _onFocusChange2() {
    setState(() {
      passwordErrorOn = false;
    });
  }
  createTextField(cont){
    return Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.all(2.5),
      child: Align(
        alignment: Alignment.center,
        child: TextField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          controller: cont,
          decoration: InputDecoration(
              hintText: "",
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.blue,width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue,width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 2.5)
          ),
        ),
      ),
    );
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
  void dispose() {
    super.dispose();
    _focus1.removeListener(_onFocusChange1);
    _focus2.removeListener(_onFocusChange2);
    _focus1.dispose();
    _focus2.dispose();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            //decoration: MyWidgets.gradient(),


          child: Stack(
            children: [
              Positioned(
                top: 75,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Image.asset('assets/1.png'),
                    iconSize: 150,
                    onPressed: () {},
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  //SizedBox(height: 30,),
                  Column(

                    children: [
                      FractionallySizedBox(widthFactor: 1,),
                      Visibility(
                          visible: errorVisible,
                          child: Text(
                            error[errorIndex],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: MF(17, context),
                                color: Colors.red,
                                fontStyle: FontStyle.italic
                            ),
                          )
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MyWidgets.errorTextFormField(userController, 'Email',Color(0xff0A1B4D),context,emailErrorOn,emailErrorMessage,_focus1),
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: MyWidgets.errorPasswordFormField(passwordController, 'Password' ,Color(0xff0A1B4D),context, visible, passwordErrorOn, passwordErrorMessage, _focus2,(){
                                setState(() {
                                  visible = !visible;
                                });
                              })
                          ),
                        ],
                      ),
                      const SizedBox(height: 35,),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: 40,
                          child: MyWidgets.button("Sign In", () async{
                            showDialog(barrierDismissible:false,context: context, builder: (context){
                              return MyWidgets.showLoading();
                            });
                            setState((){
                              if(userController.text.trim() == ""){
                                emailErrorOn = true;
                                emailErrorMessage = "Email cannot be empty";
                              }
                              if(passwordController.text.trim() == ""){
                                passwordErrorOn = true;
                                passwordErrorMessage = "Password is required";
                              }else if(passwordController.text.trim().length < 8){
                                passwordErrorOn = true;
                                passwordErrorMessage = "Should be at least 8 characters";
                              }
                            });
                            if(!emailErrorOn && !passwordErrorOn){
                              var response = await Database(url: url).send({
                                "req" : "signIn",
                                "user" : userController.text.trim(),
                                "password" : passwordController.text.trim()
                              });
                              if(response == "0"){
                                setState(() {
                                  errorVisible = true;
                                  errorIndex = 1;
                                });
                                Navigator.pop(context);
                              }else if(response == "1"){
                                setState(() {
                                  errorVisible = true;
                                  errorIndex = 2;
                                });
                                Navigator.pop(context);
                              }else if(jsonDecode(response)[0] == "false"){
                                currentUser = SpotMiiUser.convert(jsonDecode(response)[1]);
                                MyWidgets.navigateP(SignVerify(), context);
                              }else{
                                currentUser = SpotMiiUser.convert(jsonDecode(jsonDecode(response)));
                                //print(await Database.conversionRates(currentUser!.currency));
                                //rates = ["result"];
                                if(currentUser!.type == "admin"){
                                  MyWidgets.navigatePR(Admin(), context);
                                }else if(currentUser!.type == "merchant"){
                                  print("merchant");
                                  MyWidgets.navigatePR(Merchant(), context);
                                } else if(currentUser!.twoFactor == "true"){
                                  String genCode = generate(6);
                                  if(!timer2On){
                                    await Database(url: url).sendSMS("Your SpotMii Code is $genCode",currentUser!.number);
                                  }
                                  //SmsAutoFill().listenForCode();
                                  Navigator.pop(context);
                                  showModalBottomSheet(context: context, builder: (context){
                                    return StatefulBuilder(
                                        builder: (BuildContext context, setState) {
                                          if(!timer2On){
                                            timer2On = true;
                                            _time2 = Timer.periodic(Duration(seconds: 1), (time) {
                                              setState(() {
                                                if(time2 >= 300){
                                                  time2 = 0;
                                                  timer2On = false;
                                                  _time2.cancel();
                                                }
                                              });
                                              time2++;
                                            });
                                          }
                                          return  Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            child: Container(

                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(15),
                                                      topLeft: Radius.circular(16)
                                                  )
                                              ),
                                              height: MediaQuery.of(context).size.height * 0.25,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Visibility(
                                                      visible: otpVisible,
                                                      child: MyWidgets.text("Incorrect OTP", 18, FontWeight.normal, Colors.red, context,false)
                                                  ),
                                                  Visibility(
                                                      visible: opt2Visible,
                                                      child: MyWidgets.text("Code Already Sent!", 18, FontWeight.normal, Colors.red, context,false)
                                                  ),
                                                  SizedBox(height: 10,),
                                                  FractionallySizedBox(
                                                    widthFactor: 0.8,
                                                    child: PinFieldAutoFill(

                                                        decoration: BoxTightDecoration(
                                                            textStyle: TextStyle(
                                                                fontSize: MF(20, context),
                                                                fontFamily: "Poppins",
                                                                color: Color(0xff111111)
                                                            ),
                                                            strokeWidth: 2,
                                                            strokeColor: Colors.blue
                                                        ), // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,
                                                        currentCode: _code,
                                                        onCodeSubmitted: (code){

                                                        },//code submitted callback
                                                        onCodeChanged: (code){
                                                          _code = code!;
                                                        },//code changed callback
                                                        codeLength: 6//code length, default 6
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.alarm,color: Colors.blue,size: 20,),
                                                      SizedBox(width: 5,),
                                                      Text(
                                                        simplifyTime(time2).toString(),
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: MF(17, context),
                                                          color: Colors.blue,
                                                          fontWeight: FontWeight.bold,

                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      MyWidgets.text("Didn't receive OTP,", 17.0, FontWeight.normal,Color(0xff111111),context,false),
                                                      TextButton(
                                                        onPressed: (){
                                                          if(!timer2On){
                                                            timer2On = true;
                                                            genCode = generate(6);

                                                            _time2 = Timer.periodic(Duration(seconds: 1), (time) {

                                                              setState(() {

                                                                if(time2 >= 300){
                                                                  time2 = 0;
                                                                  timer2On = false;
                                                                  _time2.cancel();
                                                                }

                                                              });
                                                              time2++;
                                                            });

                                                          }else{
                                                            opt2Visible = true;
                                                            Timer(Duration(seconds: 5),(){
                                                              setState((){
                                                                opt2Visible = true;
                                                              });
                                                            });
                                                          }

                                                        },
                                                        child: MyWidgets.text("RESEND OTP?", 17.0, FontWeight.normal,Colors.red,context,false),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: MediaQuery.of(context).size.width * 0.85,
                                                    child: MyWidgets.button("Submit", ()async{
                                                      //String otp = con1.text + con2.text + con3.text + con4.text + con5.text + con6.text;
                                                      if(_code == genCode) {
                                                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                        await prefs.setBool('isLogin', true);
                                                        await prefs.setString('user', userController.text.trim());
                                                        await prefs.setString('password', passwordController.text.trim());
                                                        setState(() {
                                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                                            return Home();
                                                          }));
                                                        });
                                                      }else{
                                                        otpVisible = true;
                                                        Timer(Duration(seconds: 5),(){
                                                          setState((){
                                                            otpVisible = false;
                                                          });
                                                        });
                                                      }
                                                    },Colors.black,context),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }

                                    );

                                  });
                                }else{
                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.setBool('isLogin', true);
                                  await prefs.setString('user', userController.text.trim());
                                  await prefs.setString('password', passwordController.text.trim());
                                  setState(() {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                      return Home();
                                    }));
                                  });
                                }

                              }
                            }else{
                              Navigator.pop(context);
                            }
                          },Color(0xff04123B),context)
                      ),
                      SizedBox(height: 15,),
                      TextButton(
                        onPressed: (){
                          MyWidgets.navigateP(ForgotPassword(), context);
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Color(0xff111111),
                              fontSize: MF(18,context),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height:25,),
                      IconButton(
                        icon: Image.asset('assets/2.png'),
                        iconSize: 90,
                        onPressed: () async{
                          MyWidgets.message("You need to sign in first to use this button!", context);
                        },
                      ),

                    ],
                  )
                ],
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyWidgets.text("Don't have an account?", 17.0, FontWeight.normal, Color(0xff111111),context,false),
                      TextButton(
                        onPressed: (){
                          MyWidgets.navigateP(SignUp(), context);
                        },
                        child: MyWidgets.text("Sign Up", 19.0, FontWeight.bold, Color(0xff111111),context,false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
          ,
      ),
        ),
    );
  }
}

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


// ignore: must_be_immutable
class FingerprintPage extends StatelessWidget {
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  int errorIndex = 0;
  List<String> error = ["We didn't recognize that Mobile Number Try again","We didn't recognize that Email. Try again","We didn't recognize that Username. Try again"];
  final _formKey = GlobalKey<FormState>();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    //print(context.read<TransactionBloc>().state);
    return Scaffold(

    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //decoration: MyWidgets.gradient(),


        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 40,),
            IconButton(
              icon: Image.asset('assets/1.png'),
              iconSize: 150,
              onPressed: () {},
            ),
            SizedBox(height: 50,),
            Column(
              children: [
                Visibility(
                    visible: false,
                    child: Text(
                      error[errorIndex],
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: MF(17, context),
                        color: Colors.red,
                      ),
                    )
                ),
                Form(
                    key: _formKey,
                    child:Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),

                            ),
                            child: TextFormField(
                              enabled: false,
                              initialValue: user,
                              //controller: userController,
                              obscureText: false,

                              decoration:  InputDecoration(
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(color: Color(0xff0A1B4D), width: 1.5,),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff0A1B4D), width: 1.5,),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff0A1B4D), width: 1.5,),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff0A1B4D), width: 1.5,),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                fillColor: Colors.white,
                                hintText: "Email",
                                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                suffixIcon: IconButton(
                                  color: Color(0xff0A1B4D),
                                  onPressed: ()async{
                                    SharedPreferences preferences = await SharedPreferences.getInstance();
                                    await preferences.clear();
                                    MyWidgets.navigateP(Login(), context);
                                  },
                                  icon: Icon(Icons.change_circle_outlined),
                                ),
                                hintStyle: TextStyle(
                                    color: Color(0xff0A1B4D),
                                    fontSize: MF(18.0, context),
                                    fontFamily: "Poppins"
                                ),
                              ),
                            ),
                          ),
                          /*MyWidgets.textFormField(userController, 'Email',Color(0xff0A1B4D),(value){

                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty!';
                            }else if(value.length < 9){
                              return 'Email cannot be less than 8 characters!';
                            }else if(!value.contains("@") && !value.contains(".")){
                              return 'Invalid Email format!';
                            }
                          }),

                           */
                        ),

                        SizedBox(height: 10,),
                        Visibility(
                          visible: false,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: MyWidgets.passwordFormField(passwordController, 'Password',Color(0xff0A1B4D),(value){
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty!';
                                }else if(value.length < 9){
                                  return 'Password cannot be less than 8 characters!';
                                }
                              },visible,(){

                              },context)
                          ),
                        ),
                      ],
                    )
                ),
                Visibility(
                  visible: false,
                    child: SizedBox(height: 35,)
                ),
                Visibility(
                  visible: false,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: 40,
                      child: MyWidgets.button("Sign In", () async{
                        /*
                        if (_formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email:userController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            MyWidgets.navigatePR(Home(), context);
                          } on FirebaseAuthException catch (e) {
                            MyWidgets.message(e.toString(), context);
                          } catch (e) {
                            print(e);
                          }
                        }

                         */
                        MyWidgets.navigatePR(Home(), context);
                      },Color(0xff04123B),context)
                  ),
                ),
                Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: TextButton(
                            onPressed: ()async{
                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              await preferences.clear();
                              MyWidgets.navigateP(Login(), context);
                            },
                            child: MyWidgets.text("Login via password", 20.0, FontWeight.bold, Color(0xff111111), context,false)),
                      ),
                      SizedBox(height: 20,),
                      IconButton(
                        icon: Image.asset('assets/2.png'),
                        iconSize: 90,
                        onPressed: () async{
                          final isAuthenticated = await LocalAuthApi.authenticate();
                          if (isAuthenticated) {
                            if(currentUser!.type == "admin"){
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Admin()),
                              );
                            }else if(currentUser!.type == "merchant"){
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Merchant()),
                              );
                            }else{
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            }

                          }else{
                            print("aa");
                          }
                        },
                      ),
                      SizedBox(height: 120,)
                    ],
                  ),
                ),


              ],
            )
          ],
        )
        ,
      ),
    ),
  );
  }

  Widget buildAvailability(BuildContext context) => buildButton(
    text: 'Check Availability',
    icon: Icons.event_available,
    onClicked: () async {
      final isAvailable = await LocalAuthApi.hasBiometrics();
      final biometrics = await LocalAuthApi.getBiometrics();

      final hasFingerprint = biometrics.contains(BiometricType.fingerprint);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Availability'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildText('Biometrics', isAvailable),
              buildText('Fingerprint', hasFingerprint),
            ]
          ),
        ),
      );
    },
  );

  Widget buildText(String text, bool checked) => Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        checked
            ? Icon(Icons.check, color: Colors.green, size: 24)
            : Icon(Icons.close, color: Colors.red, size: 24),
        const SizedBox(width: 12),
        Text(text, style: TextStyle(fontSize: 24)),
      ],
    ),
  );

  Widget buildAuthenticate(BuildContext context) => buildButton(
    text: 'Authenticate',
    icon: Icons.lock_open,
    onClicked: () async {
      final isAuthenticated = await LocalAuthApi.authenticate();

      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    },
  );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 48),
            buildLogoutButton(context)
          ],
        ),
      ),
    ),
  );

  Widget buildLogoutButton(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(50),
    ),
    child: Text(
      'Logout',
      style: TextStyle(fontSize: 20),
    ),
    onPressed: () => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => FingerprintPage()),
    ),
  );
}

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Scan Fingerprint to Login',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return false;
    }
  }
}

