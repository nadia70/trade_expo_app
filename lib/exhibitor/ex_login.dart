import 'package:expo_app/stands/standlist.dart';
import 'package:expo_app/userScreens/exhibitor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ex_reg.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email*', hintText: "john.doe@gmail.com"),
                        controller: emailInputController,
                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password*', hintText: "********"),
                        controller: pwdInputController,
                        obscureText: true,
                        validator: pwdValidator,
                      ),
                      RaisedButton(
                        child: Text("Login"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_loginFormKey.currentState.validate()) {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: emailInputController.text,
                                password: pwdInputController.text)
                                .then((currentUser) => Firestore.instance
                                .collection("exibitor")
                                .where('uid', isEqualTo: currentUser.uid)
                                .where('approval', isEqualTo: true)
                                .getDocuments()
                                .then((querySnap) =>  Navigator.of(context).push(new CupertinoPageRoute(
                                builder: (BuildContext context) => new  Exhibitor()
                            )))
                                .catchError((err) => print(err)))
                                .catchError((err) => print(err));
                                }
                        },
                      ),
                      Text("Don't have an account yet?"),
                      FlatButton(
                        child: Text("Register here!"),
                        onPressed: () {
                          Navigator.of(context).push(new CupertinoPageRoute(
                              builder: (BuildContext context) => new  RegisterPage()
                          ));
                        },
                      )
                    ],
                  ),
                ))));
  }
}