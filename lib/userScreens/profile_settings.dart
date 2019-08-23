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
      body: userDetail(),
    );
  }

  void _logOut() async {
    Auth.signOut();
  }
}
class userDetail extends StatefulWidget {
  @override
  _userDetailState createState() => _userDetailState();
}

class _userDetailState extends State<userDetail> {

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

  Future<String> inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();

    return uid;

  }

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
  }

  Future getData() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = firestore.collection('users').where('name', isEqualTo: userid).limit(1)
        .getDocuments() as QuerySnapshot;
    return qn.documents;
  }

  CollectionReference collectionReference =
  Firestore.instance.collection("users");


  Future _getCurrentUser() async {
    await _auth.currentUser().then((user) {
      //_getCartCount();
      if (user != null) {
        setState(() {
          _btnText = "Logout";
          _isSignedIn = true;
          email = user.email;
          fullName = user.displayName;
          profileImgUrl = user.photoUrl;
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
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: collectionReference.where("email", isEqualTo:
          email).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data.documents.map((doc) {
                  return ListTile(
                    title: Text( "First Name:${doc.data['fname']}" ),
                    subtitle: Text("Sur name: ${doc.data['surname']}. \n Email: ${doc.data['email']}"),
                    isThreeLine: true,
                  );
                }).toList(),
              );
            } else {
              return SizedBox();
            }
          }),

    );

  }
}