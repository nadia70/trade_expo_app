import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expo_app/models/fbconn.dart';
import 'package:expo_app/models/progress.dart';
import 'package:expo_app/tools/app_data.dart';
import 'package:expo_app/tools/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:expo_app/login/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expo_app/login/user.dart';

class ExpoProfileSettings extends StatefulWidget {


  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<ExpoProfileSettings> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseUser user;
  FirebaseAuth _auth;

  String fullName;
  String email;
  String phone;
  String userid;
  String profileImgUrl;
  bool isLoggedIn;
  String _btnText;
  bool _isSignedIn = false;

  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();

  }

  Future _getCurrentUser() async {
    await _auth.currentUser().then((user) {
      //_getCartCount();
      if (user != null) {
        setState(() {

          email = user.email;
          fullName = user.displayName;
          profileImgUrl = user.photoUrl;
          userid = user.uid;
          user = user;
          //profileImgUrl = googleSignIn.currentUser.photoUrl;

//          UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
//          userUpdateInfo.photoUrl = "";
//          userUpdateInfo.displayName = "Esther Tony";
//          _auth.updateProfile(userUpdateInfo);
        });
      }
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        elevation: 0.5,
        title: Text("Profile Settings"),
        centerTitle: true,
      ),
      body: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.reference().child('userDB/' + userid),
          itemBuilder: (_, DataSnapshot snapshot,
              Animation<double> animation, int x) {
            return new ListTile(
              subtitle: new Text(snapshot.value.toString()),
            );
          }
      ),
    );
  }

  void _logOut() async {
    Auth.signOut();
  }
}