import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spotmii/widgets.dart';
import '../../components/constants.dart';
import '../../database.dart';
import 'login.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late Timer _time1, _time2;
  int time1 = 0, time2 = 0;
  var fName = TextEditingController(), lName = TextEditingController(), userName = TextEditingController(), email = TextEditingController(), number = TextEditingController(), password = TextEditingController(), retypePassword = TextEditingController(), emailVerification = TextEditingController(), mobileVerification = TextEditingController();
  final FocusNode _focus1 = FocusNode(), _focus2 = FocusNode(), _focus3 = FocusNode(),_focus4 = FocusNode(), _focus5 = FocusNode(), _focus6 = FocusNode(), _focus7 = FocusNode(), _focus8 = FocusNode(),_focus9 = FocusNode();
  bool emailErrorOn = false,passwordErrorOn = false, usernameErrorOn = false, cPasswordErrorOn = false, numberErrorOn = false, fNameErrorOn = false, lNameErrorOn = false, mVerErrorOn = false, eVerErrorOn = false,timer1On = false, timer2On = false, visible = true, visible1 = true, isChecked = true;
  String emailErrorMessage = "", passwordErrorMessage = "", fNameErrorMessage = "",cPasswordErrorMessage = "", numberErrorMessage = "", usernameErrorMessage = "",lNameErrorMessage = "",mVerErrorMessage = "", eVerErrorMessage = "", verCode1 = "", verCode2 = "",code = "+63", verCode = "";
  final countryPicker  = const FlCountryCodePicker(), _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _focus1.addListener(_onFocusChange1);_focus2.addListener(_onFocusChange2);_focus3.addListener(_onFocusChange3);_focus4.addListener(_onFocusChange4);_focus5.addListener(_onFocusChange5);_focus6.addListener(_onFocusChange6);_focus7.addListener(_onFocusChange7);_focus8.addListener(_onFocusChange8);_focus9.addListener(_onFocusChange9);
  }
  @override
  void dispose() {
    super.dispose();
    _focus1.removeListener(_onFocusChange1);_focus2.removeListener(_onFocusChange2);_focus3.removeListener(_onFocusChange3);_focus4.removeListener(_onFocusChange4);_focus5.removeListener(_onFocusChange5);_focus6.removeListener(_onFocusChange6);_focus7.removeListener(_onFocusChange7);_focus8.removeListener(_onFocusChange8);_focus9.removeListener(_onFocusChange9);
    _focus1.dispose();_focus2.dispose();_focus3.dispose();_focus4.dispose();_focus5.dispose();_focus6.dispose();_focus7.dispose();_focus8.dispose();_focus9.dispose();
  }
  void _onFocusChange1() {
    setState(() {
      fNameErrorOn = false;
    });
  }
  void _onFocusChange2() {
    setState(() {
      usernameErrorOn = false;
    });
  }
  void _onFocusChange3() {
    setState(() {
      emailErrorOn = false;
    });
  }
  void _onFocusChange4() {
    setState(() {
      numberErrorOn = false;
    });
  }void _onFocusChange5() {
    setState(() {
      passwordErrorOn = false;
    });
  }
  void _onFocusChange6() {
    setState(() {
      cPasswordErrorOn = false;
    });
  }
  void _onFocusChange7() {
    setState(() {
      lNameErrorOn = false;
    });
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
    segundo = seconds < 10 ? "0$seconds" : seconds.toString();
    return "$minutes:$segundo";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar1("Sign Up", context),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyWidgets.text("Create an Account", 23.0, FontWeight.bold, const Color(0xff111111),context,false)
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: MyWidgets.errorTextFormField(fName, "First Name",const Color(0xff0A1B4D),context,fNameErrorOn,fNameErrorMessage,_focus1),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: MyWidgets.errorTextFormField(lName, "Last Name",const Color(0xff0A1B4D),context,lNameErrorOn,lNameErrorMessage,_focus7),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: MyWidgets.errorTextFormField(userName, "Username",const Color(0xff0A1B4D),context,usernameErrorOn,usernameErrorMessage,_focus2),
                    ),

                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: MyWidgets.errorTextFormField(email, "Email Address",const Color(0xff0A1B4D),context,emailErrorOn,emailErrorMessage,_focus3),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            TextFormField(
                              focusNode: _focus4,
                              controller: number,
                              style: TextStyle(
                                  color: const Color(0xff0A1B4D),
                                  fontSize: MF(17, context),
                                  fontFamily: "Poppins"
                              ),
                              decoration:  InputDecoration(
                                prefixIcon: TextButton(
                                  onPressed: ()async{
                                    final code1 = await countryPicker.showPicker(context: context);
                                    setState(() {
                                      code = code1!.dialCode;
                                      print(code);
                                    });
                                  },
                                  child: MyWidgets.text("$code | ", 17, FontWeight.normal, const Color(0xff0A1B4D), context, false),
                                ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:  const BorderSide(color: Color(0xff0A1B4D), width: 1.5,),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:  const BorderSide(color: Color(0xff0A1B4D), width: 1.5,),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:  const BorderSide(color: Color(0xff0A1B4D), width: 1.5,),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:  const BorderSide(color: Color(0xff0A1B4D), width: 1.5,),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                fillColor: Colors.white,
                                hintText: "Mobile Number",
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                hintStyle: TextStyle(
                                    color: const Color(0xff0A1B4D),
                                    fontSize: MF(17, context),
                                    fontFamily: "Poppins"
                                ),
                              ),
                            ),
                            Positioned(
                              right: ( MediaQuery.of(context).size.width / 20 ),
                              //top: 12.5,
                              child: Visibility(
                                visible: numberErrorOn,
                                child: Text(
                                  numberErrorMessage,
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
                      ),
                    ),
                    /*


                    SizedBox(
                      width: MediaQuery.of(context).size.width *  0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // Show the country code picker when tapped.
                              final code1 = await countryPicker.showPicker(context: context);
                              setState(() {
                                code = code1!.dialCode;
                                print(code);
                              });

                            },
                            child: Container(

                              padding: const  EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 6.0),
                              decoration: const  BoxDecoration(
                                  color: Color(0xff04123B),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
                              child: Text(code, style: const  TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: MyWidgets.errorTextFormField(number, "Mobile Number",Color(0xff0A1B4D),context,numberErrorOn,numberErrorMessage,_focus4),
                          ),
                        ],
                      ),
                    ),
                    */

                    const SizedBox(height: 5),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: MyWidgets.errorPasswordFormField(password, "Password",const Color(0xff0A1B4D),context,visible,passwordErrorOn,passwordErrorMessage,_focus5,(){
                          setState(() {
                            visible = !visible;
                          });
                        })
                    ),

                    const SizedBox(height: 5),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: MyWidgets.errorPasswordFormField(retypePassword, "Retype Password",const Color(0xff0A1B4D),context,visible1,cPasswordErrorOn,cPasswordErrorMessage,_focus6,(){
                          setState(() {
                            visible1 = !visible1;
                          });
                        },)
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            checkColor: isChecked? Colors.white : const Color(0xff0A1B4D),
                            fillColor: MaterialStateProperty.resolveWith((states) => const Color(0xff0A1B4D)),
                            value: isChecked,
                            shape: const CircleBorder(),
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Column(
                            children: [
                              MyWidgets.text("By Signing up, you agree to our ", 17.0, FontWeight.normal, const Color(0xff111111),context,false),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){},
                                    child: MyWidgets.text("Privacy Policy", 19.0, FontWeight.bold, const Color(0xff111111),context,false),
                                  ),
                                  MyWidgets.text(" and ", 17.0, FontWeight.normal, const Color(0xff111111),context,false),
                                  GestureDetector(
                                    onTap: (){},
                                    child: MyWidgets.text("Terms of Use.", 19.0, FontWeight.bold, const Color(0xff111111),context,false),
                                  ),
                                ],
                              )

                            ],
                          )

                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.8,
                      height: 40,
                      child:   MyWidgets.button("Sign Up",()async{
                        showDialog(barrierDismissible:false,context: context, builder: (context){
                          return MyWidgets.showLoading();
                        });
                        tryAuth()async{
                          var db = Database(url: "https://app.spotmii.com.au/mail/sendmail.php");
                          verCode1 = generate(6);
                          verCode2 = generate(6);
                          timer1On = true;
                          timer2On = true;
                          _time1 = Timer(const Duration(minutes: 5),(){
                            timer1On = false;
                            _time1.cancel();
                            eVerErrorOn = true;
                            eVerErrorMessage = "Verification Code Expired!";
                          });
                          _time2 = Timer(const Duration(minutes: 5),(){
                            timer2On = false;
                            _time2.cancel();
                            mVerErrorOn = true;
                            mVerErrorMessage = "Verification Code Expired!";
                          });
                          await Database(url: url).send({
                            "req" : "signUp",
                            "fname" : fName.text.trim(),
                            "lname": lName.text.trim(),
                            "username" : userName.text.trim(),
                            "email" : email.text.trim(),
                            "number" : code +
                                number.text.trim(),
                            "password" : password.text.trim(),
                            "everification" : verCode1,
                            "mverification" : verCode2,
                          });
                          await db.send({
                            "email" : "spotmiiapp@gmail.com",
                            "password" : "avqiwruhgwqifkog",
                            "target" : email.text.trim(),
                            "subject" : "SpotMii App Verification",
                            "body" : "To continue signing up on SpotMii your verification code is $verCode1."
                          });
                          await db.sendSMS("SpotMii Verification: $verCode2", number.text.trim());
                          showModalBottomSheet(
                              isDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
                                      color: Colors.white
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.6,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Container(
                                        width: 75,
                                        height: 5,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(99)
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      Center(child: MyWidgets.text("Verification Code", 25.0, FontWeight.bold, const Color(0xff111111), context,false)),
                                      const SizedBox(height: 40,),
                                      FractionallySizedBox(widthFactor:0.7,child: Center(child: MyWidgets.text(" For verification purposes please enter the verification code we sent in your email and mobile number to verify your identity.", 15.0, FontWeight.normal, const Color(0xff111111), context,false))),
                                      const SizedBox(height: 20,),
                                      FractionallySizedBox(
                                        widthFactor:0.8,
                                        child: MyWidgets.errorTextFormField(emailVerification, "Email Verification Code", const Color(0xff111111),context,eVerErrorOn,eVerErrorMessage,_focus8),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          MyWidgets.text("Didn't receive the OTP? ", 15.0, FontWeight.normal, const Color(0xff111111), context,false),
                                          TextButton(
                                            onPressed: ()async{
                                              if(!timer1On){
                                                timer1On = true;
                                                verCode2 = generate(6);
                                                var checking = await db.send({
                                                  "req" : "tryverify",
                                                  "email" :currentUser!.email,
                                                  "code1" : verCode1,
                                                  "code2" : verCode2,
                                                });
                                                await Database(url: "https://app.spotmii.com.au/mail/sendmail.php").send({
                                                  "email" : "spotmiiapp@gmail.com",
                                                  "password" : "avqiwruhgwqifkog",
                                                  "target" :currentUser!.email,
                                                  "subject" : "SpotMii App Verification",
                                                  "body" : "To continue signing up on SpotMii your Email verification code is $verCode1."
                                                });
                                                print(checking);
                                                _time1 = Timer.periodic(const Duration(seconds: 1), (time) {
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
                                                MyWidgets.message("Verification already sent! $time1", context);
                                              }
                                            },
                                            child: MyWidgets.text("RESEND OTP", 16.0, FontWeight.bold, const Color(0xff04123B), context,false),
                                          ),
                                          MyWidgets.text(simplifyTime(time1), 17.0, FontWeight.bold, Colors.red, context,false),
                                        ],
                                      ),
                                      FractionallySizedBox(
                                        widthFactor:0.8,
                                        child: MyWidgets.errorTextFormField(mobileVerification, "Mobile Verification Code", const Color(0xff111111),context,eVerErrorOn,mVerErrorMessage,_focus9),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          MyWidgets.text("Didn't receive the OTP? ", 15.0, FontWeight.normal, const Color(0xff111111), context,false),
                                          TextButton(
                                            onPressed: ()async{
                                              if(!timer2On){
                                                timer2On = true;
                                                verCode1 = generate(6);
                                                await db.send({
                                                  "req" : "tryverify",
                                                  "email" :currentUser!.email,
                                                  "code1" : verCode1,
                                                  "code2" : verCode2,
                                                });
                                                await db.sendSMS("SpotMii Verification: $verCode2", number.text.trim());
                                                _time2 = Timer.periodic(const Duration(seconds: 1), (time) {
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
                                            child: MyWidgets.text("RESEND OTP", 16.0, FontWeight.bold, const Color(0xff04123B), context,false),
                                          ),
                                          MyWidgets.text(simplifyTime(time2), 17.0, FontWeight.bold, Colors.red, context,false),
                                        ],
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        height: 40,
                                        child: MyWidgets.button("Submit", ()async{
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context, builder: (context){
                                            return MyWidgets.showLoading();
                                          });
                                          //check for the codes if correct
                                          if(emailVerification.text.trim() == verCode1.toString() && mobileVerification.text.trim() == verCode2.toString()){
                                            await Database(url: url).send({
                                              "req" : "verified",
                                              "code1" : verCode1,
                                              "code2" : verCode2
                                            });
                                            Navigator.pop(context);
                                            MyWidgets.navigateP(MyWidgets.congratulation("Congratulations", "Your account has been successfully created!", (){
                                              MyWidgets.navigateP(const Login(), context);
                                            }, context, "Sign In"), context);
                                          }else{
                                            setState(() {
                                              eVerErrorOn = true;
                                              eVerErrorMessage = "Wrong Verification Code";
                                              mVerErrorOn = true;
                                              mVerErrorMessage = "Wrong Verification Code";
                                            });
                                            Navigator.pop(context);
                                          }
                                        }, const Color(0xff04123B), context),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                        var checkUser = await Database(url:url).check("username",userName.text.trim());
                        var checkEmail = await Database(url:url).check("email",email.text.trim());
                        var checkNumber = await Database(url:url).check("number",number.text.trim());
                        if (isChecked) {
                          setState((){
                            //first name check
                            if(fName.text.trim() == ""){
                              fNameErrorOn = true;
                              fNameErrorMessage = "First Name is required";
                            }
                            //last name check
                            if(lName.text.trim() == ""){
                              lNameErrorOn = true;
                              lNameErrorMessage = "Last Name is required";
                            }
                            //username check
                            if(userName.text.trim() == ""){
                              usernameErrorOn = true;
                              usernameErrorMessage = "Username is required";
                            }else if(userName.text.trim().length < 8 || userName.text.trim().length > 16){
                              usernameErrorOn = true;
                              usernameErrorMessage = "Should Be 8-16 Characters";
                            }else if(checkUser == "false"){
                              usernameErrorOn = true;
                              usernameErrorMessage = "Username is already taken";
                            }
                            //email check
                            if(email.text.trim() == ""){
                              emailErrorOn = true;
                              emailErrorMessage = "Email is required";
                            }else if(!email.text.trim().contains("@") && !email.text.trim().contains(".") ){
                              emailErrorOn = true;
                              emailErrorMessage = "Email is invalid!";
                            }else if(checkEmail == "false"){
                              emailErrorOn = true;
                              emailErrorMessage = "Email is already taken";
                            }
                            //mobile number check
                            if(number.text.trim() == ""){
                              numberErrorOn = true;
                              numberErrorMessage = "Mobile Number is required";
                            }else if(checkNumber == "false"){
                              numberErrorOn = true;
                              numberErrorMessage = "Mobile Number is taken";
                            }
                            //password check
                            if(password.text.trim() == ""){
                              passwordErrorOn = true;
                              passwordErrorMessage = "Password is required";
                            }else if(password.text.trim().length < 8 || password.text.trim().length > 16){
                              passwordErrorOn = true;
                              passwordErrorMessage = "Should Be 8-16 Characters";
                            }
                            //retype password check
                            if(retypePassword.text.trim() != password.text.trim()){
                              cPasswordErrorOn = true;
                              cPasswordErrorMessage = "Password doesn't match";
                            }
                          });
                          fNameErrorOn ? null : lNameErrorOn ? null : usernameErrorOn ? null : emailErrorOn ? null : numberErrorOn? null : passwordErrorOn? null: cPasswordErrorOn? null : tryAuth();
                        }else if(_formKey.currentState!.validate()){
                          MyWidgets.message("Agree to our terms and condition if you want to signup!", context);
                        }
                        Navigator.pop(context);
                      },const Color(0xff0A1B4D),context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Have an account? ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MF(17, context),
                        fontFamily: "Poppins"
                    )
                    ,),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Login(),
                        ),
                      );
                    },
                    child: Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MF(19, context),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                        )
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}