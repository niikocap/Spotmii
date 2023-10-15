import 'package:flutter/material.dart';
import 'package:spotmii/widgets.dart';
import '../../components/constants.dart';
import '../../database.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool bioSwitch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Biometrics", context),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Container(


              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                  color: const Color(0xff04123B),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyWidgets.text("Biometrics", 19, FontWeight.bold, Colors.white, context,false),
                  Switch(
                    // This bool value toggles the switch.
                    value: bioSwitch,
                    activeColor: Colors.white,
                    onChanged: (bool value) async{
                      setState(() {
                        bioSwitch = value;
                      });

                    },
                  ),
                  //text field
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool light = currentUser!.twoFactor == "true";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("2FA Security", context),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Container(
    

              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                color: const Color(0xff04123B),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyWidgets.text("2FA Security", 19, FontWeight.bold, Colors.white, context,false),
                  Switch(
                    // This bool value toggles the switch.
                    value: light,
                    activeColor: Colors.white,
                    onChanged: (bool value) async{
                      if(light) {
                        var resu = await Database(url: url).send({
                        "req": "toogleSwitch",
                          "val": "false",
                          "id" : currentUser!.userID
                        });
                        print(resu);
                      }else{
                        var resu = await Database(url: url).send({
                          "req": "toogleSwitch",
                          "val": "true",
                          "id" : currentUser!.userID
                        });
                        print(resu);
                      }

                      setState(() {
                        light = value;
                      });
                    },
                  ),
                  //text field
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResetPassword1 extends StatefulWidget {
  const ResetPassword1({Key? key}) : super(key: key);

  @override
  State<ResetPassword1> createState() => _ResetPassword1State();
}

class _ResetPassword1State extends State<ResetPassword1> {
  var newPassController = TextEditingController();
  var cNewPassController = TextEditingController();
  var oldPassController = TextEditingController();
  bool visible = true;
  bool visible1 = true;
  bool visible2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Reset Password", context),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            //MyWidgets.text1("Reset Password", 43.0, FontWeight.bold),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyWidgets.text("Old Password", 18.0, FontWeight.bold,const Color(0xff111111),context,false),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyWidgets.passwordFormField(oldPassController, 'Old password.',const Color(0xff0A1B4D),(value){
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty!';
                        }else if(value.length < 9){
                          return 'Password cannot be less than 8 characters!';
                        }
                      },visible2,(){
                        setState(() {
                          visible2 = !visible2;
                        });
                      },context)
                  ),
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
                      child: MyWidgets.passwordFormField(newPassController, 'New password.',const Color(0xff0A1B4D),(value){
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
                    child: MyWidgets.passwordFormField(cNewPassController, 'Confirm new password.',const Color(0xff0A1B4D),(value){
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
              height: 30,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.8,
              child:  MyWidgets.button("Change Password", (){
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MyWidgets.congratulation("Congratulations","Your Password has been Reset Sucessfully.",(){
                      //MyWidgets.navigatePR(Login(), context);
                    },context,"Sign in"),
                  ),
                );
              },const Color(0xff04123B),context),
            )
          ],
        ),
      ),
    );
  }
}
