import 'dart:core';
import 'package:expo_app/models/progress.dart';
import 'package:expo_app/tools/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "custom_text_field.dart";
import 'validator.dart';
import 'package:flutter/services.dart';
import 'package:expo_app/login/welcome_screen.dart';


class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullname = new TextEditingController();
  final TextEditingController _number = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final userRef = FirebaseDatabase.instance.reference().child(AppData.userDB);
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  CustomTextField _nameField;
  CustomTextField _phoneField;
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;
  FirebaseUser user;
  FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    onBackPress = () {
      Navigator.of(context).pop();
    };

    _nameField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _fullname,
      hint: "Full Name",
      validator: Validator.validateName,
    );
    _phoneField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _number,
      hint: "Phone Number",
      validator: Validator.validateNumber,
      inputType: TextInputType.number,
    );
    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      hint: "E-mail Adress",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      hint: "Password",
      validator: Validator.validatePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                      child: Text(
                        "Create new account",
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.indigo,
                          decoration: TextDecoration.none,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "OpenSans",
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: _nameField,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _phoneField,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _emailField,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _passwordField,
                    ),
                    new InkWell(
                      onTap: () {
                        createUserAccount();
                      },
                      child: new Container(
                        height: 60.0,
                        margin: new EdgeInsets.only(top: 5.0),
                        child: new Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Container(
                            margin: new EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 2.0),
                            height: 60.0,
                            decoration: new BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(20.0))),
                            child: new Center(
                                child: new Text(
                                  "Create Account",
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: onBackPress,
                  ),
                ),
              ],
            ),
            Offstage(
              offstage: !_blackVisible,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedOpacity(
                  opacity: _blackVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
    ));
  }

  var progress = new ProgressBar(
    backgroundColor: Colors.black12,
    color: Colors.white,
    borderRadius: 5.0,
    text: 'Signing up...',
  );


  Future createUserAccount() async {
    if (_fullname.text == "") {
      showInSnackBar("Name cannot be empty");
      return;
    }

    if (_number.text == "") {
      showInSnackBar("Mobile cannot be empty");
      return;
    }

    if (_email.text == "") {
      showInSnackBar("Email cannot be empty");
      return;
    }

    if (_password.text == "") {
      showInSnackBar("Password cannot be empty");
      return;
    }

    showDialog(
      context: context,
      child: progress,
    );

    try {
      await _auth
          .createUserWithEmailAndPassword(
          email: _email.text, password: _password.text)
          .then((loggedUser) {
        Map userMap = new Map();
        userMap[AppData.fullName] = _fullname.text;
        userMap[AppData.phoneNumber] = _number.text;
        userMap[AppData.email] = _email.text;
        userMap[AppData.password] = _password.text;
        userMap[AppData.profileImgURL] = loggedUser.photoUrl;
        userMap[AppData.deliveryAddress] = "";
        userMap[AppData.userID] = loggedUser.uid;
        userRef.child(loggedUser.uid).set(userMap);
        user = loggedUser;

        _auth.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
        Navigator.of(context).push(new CupertinoPageRoute(
            builder: (BuildContext context) => new WelcomeScreen()
        ));
      });
    } on PlatformException catch (e) {
      Navigator.of(context).pop();
      showInSnackBar(e.message);
    }

//    setState(() {});
//
//    if (user != null) {
//      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
//      userUpdateInfo.photoUrl = "";
//      userUpdateInfo.displayName = _nameController.text;
//      _auth.updateProfile(userUpdateInfo);
//    }
  }
}


