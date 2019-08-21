import 'package:expo_app/tools/authentication.dart';
import 'package:expo_app/userScreens/exhibitor.dart';
import 'package:expo_app/userScreens/root_page.dart';
import 'package:flutter/material.dart';
import 'exhibitor/ex_reg.dart';
import 'models/applogin.dart';
import 'userScreens/myHomePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:expo_app/login/welcome_screen.dart';
import 'package:expo_app/login/sign_in_screen.dart';
import 'package:expo_app/login/sign_up_screen.dart';

void main(){

  FirebaseDatabase.instance.setPersistenceEnabled(true);
  FirebaseDatabase.instance.setPersistenceCacheSizeBytes(1000000000);
  FirebaseDatabase.instance.reference().keepSynced(true);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      routes: <String, WidgetBuilder>{

        '/signin': (BuildContext context) => new SignInScreen(),
        '/signup': (BuildContext context) => new SignUpScreen(),

      },

      title: 'Trade Expo',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new WelcomeScreen(),
    );
  }
}