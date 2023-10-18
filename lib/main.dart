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
import 'package:device_preview/device_preview.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences;
  preferences = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      )
  );
  if(Platform.isIOS){
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top, // Shows Status bar and hides Navigation bar
      ],
    );
  }
  isLogin = preferences.getBool("isLogin") == null ? false : true;
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
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MultiBlocProvider(
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
          //
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          //
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
      ),
    )
  );
}