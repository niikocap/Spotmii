import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:spotmii/components/constants.dart';
import 'package:spotmii/screens/auth/register.dart';
import 'package:spotmii/screens/auth/verification.dart';
import 'package:spotmii/widgets.dart';
import 'package:spotmii/database.dart';
import 'package:spotmii/models/user_model.dart';
import 'package:spotmii/user_type/admin/admin.dart';
import 'package:spotmii/user_type/merchant/merchant.dart';
import 'forgot_password.dart';
import 'package:spotmii/screens/home.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var con1 = TextEditingController(), con2 = TextEditingController(),con3 = TextEditingController(), con4 = TextEditingController(), con5 = TextEditingController(), con6 = TextEditingController();
  final FocusNode _focus1 = FocusNode(),_focus2 = FocusNode();
  var userController = TextEditingController(),passwordController = TextEditingController();
  int errorIndex = 0,time2 = 0;
  bool emailErrorOn = false, otpVisible = false,passwordErrorOn = false,opt2Visible = false;
  String emailErrorMessage = "",passwordErrorMessage = "";
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
      margin: const EdgeInsets.all(2.5),
      child: Align(
        alignment: Alignment.center,
        child: TextField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          controller: cont,
          decoration: InputDecoration(
              hintText: "",
              focusedBorder: OutlineInputBorder(
                borderSide:  const BorderSide(color: Colors.blue,width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue,width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2.5)
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
    segundo = seconds < 10 ? "0$seconds" : seconds.toString();
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
        child: SizedBox(
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
                  const SizedBox(height: 50,),
                  //SizedBox(height: 30,),
                  Column(

                    children: [
                      const FractionallySizedBox(widthFactor: 1,),
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
                      const SizedBox(height: 10,),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MyWidgets.errorTextFormField(userController, 'Email',const Color(0xff0A1B4D),context,emailErrorOn,emailErrorMessage,_focus1),
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: MyWidgets.errorPasswordFormField(passwordController, 'Password' ,const Color(0xff0A1B4D),context, visible, passwordErrorOn, passwordErrorMessage, _focus2,(){
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
                                MyWidgets.navigateP(const SignVerify(), context);
                              }else{
                                currentUser = SpotMiiUser.convert(jsonDecode(jsonDecode(response)));
                                //print(await Database.conversionRates(currentUser!.currency));
                                //rates = ["result"];
                                if(currentUser!.type == "admin"){
                                  MyWidgets.navigatePR(const Admin(), context);
                                }else if(currentUser!.type == "merchant"){
                                  print("merchant");
                                  MyWidgets.navigatePR(const Merchant(), context);
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
                                            _time2 = Timer.periodic(const Duration(seconds: 1), (time) {
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

                                              decoration: const BoxDecoration(
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
                                                  const SizedBox(height: 10,),
                                                  FractionallySizedBox(
                                                    widthFactor: 0.8,
                                                    child: PinFieldAutoFill(
                                                        decoration: BoxTightDecoration(
                                                            textStyle: TextStyle(
                                                                fontSize: MF(20, context),
                                                                fontFamily: "Poppins",
                                                                color: const Color(0xff111111)
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
                                                  const SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.alarm,color: Colors.blue,size: 20,),
                                                      const SizedBox(width: 5,),
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
                                                      MyWidgets.text("Didn't receive OTP,", 17.0, FontWeight.normal,const Color(0xff111111),context,false),
                                                      TextButton(
                                                        onPressed: (){
                                                          if(!timer2On){
                                                            timer2On = true;
                                                            genCode = generate(6);

                                                            _time2 = Timer.periodic(const Duration(seconds: 1), (time) {

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
                                                            Timer(const Duration(seconds: 5),(){
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
                                                            return const Home();
                                                          }));
                                                        });
                                                      }else{
                                                        otpVisible = true;
                                                        Timer(const Duration(seconds: 5),(){
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
                                      return const Home();
                                    }));
                                  });
                                }

                              }
                            }else{
                              Navigator.pop(context);
                            }
                          },const Color(0xff04123B),context)
                      ),
                      const SizedBox(height: 15,),
                      TextButton(
                        onPressed: (){
                          MyWidgets.navigateP(const ForgotPassword(), context);
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: const Color(0xff111111),
                              fontSize: MF(18,context),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(height:25,),
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
                      MyWidgets.text("Don't have an account?", 17.0, FontWeight.normal, const Color(0xff111111),context,false),
                      TextButton(
                        onPressed: (){
                          MyWidgets.navigateP(const SignUp(), context);
                        },
                        child: MyWidgets.text("Sign Up", 19.0, FontWeight.bold, const Color(0xff111111),context,false),
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