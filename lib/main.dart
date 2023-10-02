import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotmii/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:spotmii/blocs/user_bloc/user_bloc.dart';
import 'package:spotmii/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotmii/database.dart';
import 'package:spotmii/screens/login.dart';
import 'blocs/currency_bloc/currency_bloc.dart';
import 'models/user_model.dart';

late final isLogin;
late final user;
late final password;
late SpotMiiUser? currentUser;
var rates;
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
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      )
  );
  var login = await preferences.getBool("isLogin");
  isLogin = login == null ? false : true;
  user = await preferences.getString("user");
  password = await preferences.getString("password");
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
//test
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
        BlocProvider(
          create: (context)=>CurrencyBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SpotMii',
        theme: ThemeData(
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.red.withOpacity(0)
            ),
            appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                  statusBarColor: Color(0xff050E29),
                )
            ),
            primarySwatch: Colors.blue,
            fontFamily: "Poppins"
        ),
        home: !isLogin  ? Login() : FingerprintPage(),
      ),
    );
  }
}