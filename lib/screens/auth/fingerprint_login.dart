import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import '../../main.dart';
import '../../models/localauth.dart';
import '../../user_type/admin/admin.dart';
import '../../user_type/merchant/merchant.dart';
import '../../widgets.dart';
import '../home.dart';
import 'login.dart';

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
                            final isAuthenticated = await LocalAuthApi.authenticate("Scan fingerprint to Login!");
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
      final isAuthenticated = await LocalAuthApi.authenticate("Scan fingerprint to Login!");

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