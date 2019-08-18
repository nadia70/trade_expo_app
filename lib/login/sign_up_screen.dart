import 'dart:core';
import 'package:expo_app/models/progress.dart';
import 'package:expo_app/tools/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'auth.dart';
import 'custom_alert_dialog.dart';
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
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

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
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create account"),
        ),
        body: Stack(
          children: [
            ListView(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    new SizedBox(
                      height: 30.0,
                    ),
                     Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Form(

                    key: _formKey,
                         autovalidate: _autoValidate,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            new TextFormField(
                                controller: _fullname,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderRadius:BorderRadius.circular(20.0)),
                                  hintText: 'Full Name',
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  String p = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
                                  RegExp regExp = new RegExp(p);

                                  if (regExp.hasMatch(value)) {
                                    // So, the email is valid
                                    return null;
                                  }

                                  // The pattern of the email didn't match the regex above.
                                  return 'Name is not valid';
                                }
                            ),

                            new SizedBox(
                              height: 20.0,
                            ),

                            new TextFormField(
                                controller: _number,
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  border: UnderlineInputBorder(
                                      borderRadius:BorderRadius.circular(20.0)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  String p = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
                                  RegExp regExp = new RegExp(p);

                                  if (regExp.hasMatch(value)) {
                                    // So, the email is valid
                                    return null;
                                  }
                                  // The pattern of the email didn't match the regex above.
                                  return 'number, should contain 10 digits ';
                                }
                            ),

                            new SizedBox(
                              height: 20.0,
                            ),

                            new TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  border: UnderlineInputBorder(
                                      borderRadius:BorderRadius.circular(20.0)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                                      "\\@" +
                                      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                                      "(" +
                                      "\\." +
                                      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                                      ")+";
                                  RegExp regExp = new RegExp(p);

                                  if (regExp.hasMatch(value)) {
                                    // So, the email is valid
                                    return null;
                                  }
                                  // The pattern of the email didn't match the regex above.
                                  return 'Email is not valid';
                                }
                            ),

                            new SizedBox(
                              height: 20.0,
                            ),

                            new TextFormField(
                                controller: _password,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  border: UnderlineInputBorder(
                                      borderRadius:BorderRadius.circular(20.0)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (value.length < 6) {
                                    return 'Must be atleast 6 charaters';
                                  }
                                  String p = r'^(?=.*?[A-Z])(?=.*?[a-z])';
                                  RegExp regExp = new RegExp(p);

                                  if (regExp.hasMatch(value)) {
                                    // So, the email is valid
                                    return null;
                                  }
                                  // The pattern of the email didn't match the regex above.
                                  return 'Password should contain atleast one capital letter';
                                }
                            ),

                            new SizedBox(
                              height: 20.0,
                            ),


                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: RaisedButton(
                                onPressed: () { createUserAccount(); },
                                child: Text('Create account'),
                              ),
                            ),
                          ],
                        ),
                    ),
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
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }

    showDialog(
      context: context,
      child: progress,
    );

    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
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
    }  catch (e) {
      print("Error in email sign in: $e");
      String exception = Auth.getExceptionText(e);
      _showErrorAlert(
        title: "Login failed",
        content: exception,

      );
    }

  }



  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: () {
          Navigator.of(context).pop();
        },
        );
      },
    );
  }
}

