import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotmii/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:spotmii/blocs/user_bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotmii/database.dart';
import 'package:spotmii/screens/auth/fingerprint_login.dart';
import 'package:spotmii/screens/auth/login.dart';
import 'components/constants.dart';
import 'models/user_model.dart';

late final isLogin;
late final user;
late final password;
late SharedPreferences preferences;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  if(Platform.isIOS){
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top, // Shows Status bar and hides Navigation bar
      ],
    );
  }
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      )
  );
  var login = preferences.getBool("isLogin");
  isLogin = login == null ? false : true;
  user = preferences.getString("user");
  password = preferences.getString("password");
  if(isLogin){
    currentUser =  SpotMiiUser.convert(jsonDecode(jsonDecode(await Database(url: url).send({
      "req" : "signIn",
      "user" : user,
      "password" : password,
    }))));
  }else{
    currentUser = null;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            if(currentUser != null){
              return TransactionBloc()..add(InitTransaction(uid:currentUser!.userID));
            }else{
              return TransactionBloc();
            }
          },
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SpotMii',
        theme: ThemeData(
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.red.withOpacity(0)
            ),
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                  statusBarColor: Color(0xff050E29),
                )
            ),
            primarySwatch: Colors.blue,
            fontFamily: "Poppins"
        ),
        home: !isLogin  ? const Login() : FingerprintPage(),
      ),
    );
  }
}