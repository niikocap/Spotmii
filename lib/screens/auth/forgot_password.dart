import 'dart:math';
import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../../database.dart';
import '../../widgets.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var controller = TextEditingController();
  String verCode = "";
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
      appBar: MyWidgets.appbar1("Forgot Password", context),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
                //MyWidgets.text("Spotmii", 53.0, FontWeight.bold)
                const SizedBox(height: 40,),
                IconButton(
                  icon: Image.asset('assets/4.png'),
                  iconSize: 100,
                  onPressed: () {},
                ),
                const SizedBox(height: 40,),
                SizedBox(
                  width:MediaQuery.of(context).size.width * 0.8,
                  child:MyWidgets.text("Enter your email and we'll send you a link to change a new password", 15.0, FontWeight.normal,const Color(0xff111111),context,false),
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  width:MediaQuery.of(context).size.width * 0.8,
                  child:MyWidgets.textFormField(controller, "Email",const Color(0xff0A1B4D),(value){
                    if(value == ""){
                      return "This field cannot be empty";
                    }
                  },context),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width *0.8,
                  height: 40,
                  child:   MyWidgets.button("Submit",()async{
                    var db = Database(url: "https://app.spotmii.com.au/mail/sendmail.php");
                    verCode = generate(6);
                    await Database(url: url).send(
                      {
                        "req" : "resetPass",
                        "email" : controller.text.trim(),
                        "code" : verCode
                      }
                    );
                    await db.send({
                      "email" : "spotmiiapp@gmail.com",
                      "password" : "avqiwruhgwqifkog",
                      "target" : controller.text.trim(),
                      "subject" : "SpotMii App Verification",
                      "body" : "To continue signing up on SpotMii your verification code is $verCode."
                    });
                    MyWidgets.navigateP(SendAuth(sender:controller.text.trim()), context);
                  },button,context),
                ),
             ]
        ),
      ),
      )
    );

  }
}

class SendAuth extends StatefulWidget {
  final sender;
  const SendAuth({super.key, required this.sender});

  @override
  State<SendAuth> createState() => _SendAuthState();
}

class _SendAuthState extends State<SendAuth> {
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar1("Verification Code",context),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [

            const SizedBox(height:40),
            IconButton(
              icon: Image.asset('assets/4.png',),
              iconSize: 100,
              onPressed: () {},
            ),
            const SizedBox(height:40),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child:  MyWidgets.text("Enter the verification code we send in your email to reset your password.", 15.0, FontWeight.normal,const Color(0xff111111),context,false),
            ),
            const SizedBox(height:15),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child:MyWidgets.textFormField(controller, "Verification Code",const Color(0xff0A1B4D),(value){
                if(value == ""){
                  return "This field cannot be empty";
                }
              },context),
            ),
            const SizedBox(height:20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 40,
              child: MyWidgets.button("Submit", ()async{
                  var res = await Database(url: url).send({
                      "req" : "resetPassCheck",
                      "code" : controller.text.trim(),
                      "email" : widget.sender
                    }
                  );

                  print(res);
                  //print("is response = to success: " + (response.runtimeType).toString());


                  if(res == "\"success\""){
                    MyWidgets.navigateP(ResetPassword(who:widget.sender), context);
                  }else{

                    //todo show error
                  }
                //
              },const Color(0xff04123B),context),
            ),




          ]
        ),
      ),
    );
  }
}

class VerifyAuth extends StatefulWidget {
  const VerifyAuth({Key? key}) : super(key: key);

  @override
  State<VerifyAuth> createState() => _VerifyAuthState();
}

class _VerifyAuthState extends State<VerifyAuth> {
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //MyWidgets.text1("OTP Verification", 40.0, FontWeight.bold),
            const SizedBox(height:40),
            IconButton(
              icon: Image.asset('assets/3.png'),
              iconSize: 100,
              onPressed: () {},
            ),
            const SizedBox(height:40),
            //MyWidgets.text1("Verification Code", 23.0, FontWeight.normal),
            const SizedBox(height:10),
            //MyWidgets.text1("Enter OTP sent to", 18.0, FontWeight.bold),
            const SizedBox(height:10),
            //MyWidgets.text1("+1 2345678", 18.0, FontWeight.bold),
            const SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.blueAccent,width: 2)
                  ),
                  child: MyWidgets.text(
                    "1",20.0,FontWeight.bold,Colors.black,context
                      ,false),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent,width: 2)
                  ),
                  child: MyWidgets.text(
                      "1",20.0,FontWeight.bold,Colors.black,context
                      ,false),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent,width: 2)
                  ),
                  child: MyWidgets.text(
                      "1",20.0,FontWeight.bold,Colors.black,context
                      ,false),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent,width: 2)
                  ),
                  child: MyWidgets.text(
                      "1",20.0,FontWeight.bold,Colors.black,context
                      ,false      ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.alarm,color: Colors.blue,),
                Text(
                  "0:23s",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,

                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //MyWidgets.text1("Didn't receive OTP?", 20.0, FontWeight.normal),
                TextButton(
                  onPressed: (){},
                  child: const Text(
                    "RESEND OTP",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.85,
              child: MyWidgets.button("Submit", (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResetPassword(who: "",)),
                );
              },Colors.black,context),
            )
          ]
      ),
    );
  }
}

class ResetPassword extends StatefulWidget {
  final String who;
  const ResetPassword({super.key, required this.who});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var newPassController = TextEditingController();
  var cNewPassController = TextEditingController();
  bool visible = true;
  bool visible1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar1("Reset Password", context),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            //MyWidgets.text1("Reset Password", 43.0, FontWeight.bold),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                IconButton(
                  icon: Image.asset('assets/1(1).png'),
                  iconSize: 100,
                  onPressed: () {},
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyWidgets.text("New Password", 18.0, FontWeight.bold,const Color(0xff111111),context,false),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyWidgets.passwordFormField(newPassController, 'Password',const Color(0xff0A1B4D),(value){
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty!';
                      }else if(value.length < 9){
                        return 'Password cannot be less than 8 characters!';
                      }
                    },visible,(){
                      setState(() {
                        visible = !visible;
                      });
                    },context)
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyWidgets.passwordFormField(cNewPassController, 'Password',const Color(0xff0A1B4D),(value){
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty!';
                      }else if(value.length < 9){
                        return 'Password cannot be less than 8 characters!';
                      }
                    },visible1,(){
                      setState(() {
                        visible1 = !visible1;
                      });
                    },context),
                  ),
                ),


              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.8,
              child:  MyWidgets.button("Change Password", ()async{
                var response = await Database(url:url).send(
                  {
                    "req" : "passReset",
                    "pass" : newPassController.text.trim(),
                    "email" : widget.who,
                  }
                );
                print(response);
                if(response == "\"success\""){
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => MyWidgets.congratulation("Congratulations","Your Password has been Reset Sucessfully.",(){
                        MyWidgets.navigatePR(const Login(), context);
                      },context,"Sign in"),
                    ),
                  );
                }

              },const Color(0xff04123B),context),
            )
          ],
        ),
      ),
    );
  }
}

