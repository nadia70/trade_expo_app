import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expo_app/userScreens/receipt_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpoHistory extends StatefulWidget {
  @override
  _ExpoHistoryState createState() => _ExpoHistoryState();
}

class _ExpoHistoryState extends State<ExpoHistory> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Expo History")
      ),
      body: Receipts()
    );
  }
}

class Receipts extends StatefulWidget {
  @override
  _ReceiptsState createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
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

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
  }

  Future getData() async{

    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("receipt").getDocuments();
    return qn.documents;

  }

  CollectionReference collectionReference =
  Firestore.instance.collection("receipt");


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
                  return new GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new ReceiptDetail(

                        itemEmail: doc.data["email"],
                        itemStatus: doc.data["status"],
                        itemNumber: doc.data["stand number"],
                        itemDate: doc.data["date"].toString().substring(0,10),
                        itemAmount: doc.data["amount"],


                      )));
                    },
                    child: new Card(
                      child: Stack(
                        alignment: FractionalOffset.topLeft,
                        children: <Widget>[
                          new Stack(
                            alignment: FractionalOffset.bottomCenter,
                            children: <Widget>[

                              new Container(
                                height:100.0 ,
                                color: Colors.transparent,
                                child: new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:  new ListTile(
                                    leading: new CircleAvatar(
                                      child: new Icon(Icons.attach_money,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                    title: new Text(":${doc.data["amount"]}"),
                                    subtitle: new Text("Transaction date: ${doc.data["date"].toString().substring(0,10)}"),


                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
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

