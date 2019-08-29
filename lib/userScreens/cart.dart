import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expo_app/mpesa_pay/initializer.dart';
import 'package:expo_app/mpesa_pay/payment_enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expo_app/tools/app_data.dart';
import 'package:expo_app/main.dart';
import 'package:expo_app/models/fbconn.dart';

import 'itemdetails.dart';

class ExpoCart extends StatefulWidget {
  @override
  _ExpoCartState createState() => new _ExpoCartState();
}

class _ExpoCartState extends State<ExpoCart> {
  BuildContext context;
  var refreshMenuKey = GlobalKey<RefreshIndicatorState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseUser user;
  FirebaseAuth _auth;

  String fullName;
  String email;
  String phone;
  String userid;
  int counter ;

  @override
  void initState() {
    // TODO: implement initState
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
  void dispose() {
    super.dispose();
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  var listDialog = new SimpleDialog(
    //title: const Text('Select assignment'),
    children: <Widget>[
      new SimpleDialogOption(
        onPressed: () {},
        child: const Text('Copy'),
      ),
      new Divider(),
      new SimpleDialogOption(
        onPressed: () {},
        child: const Text('Edit'),
      ),
      new Divider(),
      new SimpleDialogOption(
        onPressed: () {},
        child: const Text('Hide'),
      ),
      new Divider(),
      new SimpleDialogOption(
        onPressed: () {},
        child: const Text('Delete'),
      ),
    ],
  );

  listAlertDialog() {
    showDialog(context: context, child: listDialog);
  }

  void addQuantity(String keyIDasList, int itemQuantityAsList) {
    FirebaseDatabase.instance
        .reference()
        .child(AppData.cartDB)
        .child(AppData.currentUserID)
        .child(keyIDasList)
        .update({AppData.itemQuantity: itemQuantityAsList + 1});
  }

  void removeQuantity(String keyIDasList, int itemQuantityAsList) {
    if (itemQuantityAsList == 1) return;
    FirebaseDatabase.instance
        .reference()
        .child(AppData.cartDB)
        .child(AppData.currentUserID)
        .child(keyIDasList)
        .update({AppData.itemQuantity: itemQuantityAsList - 1});
  }

  var number = TextEditingController();

  ///Mpesa Checkout method
  ///This method requires the parameters User Phone and  the amount
  Future<void> startCheckout({String userPhone, int amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;

    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,

          ///Place the amount here
          amount: double.parse(amount.toString()),
          partyA: userPhone,
          partyB: "174379",
          callBackURL: Uri.parse("https://sandbox.safaricom.co.ke/"),
          accountReference: "Trade Expo",
          phoneNumber: userPhone,
          baseUri: Uri.parse("https://sandbox.safaricom.co.ke/"),
          transactionDesc: "purchase",
          passKey:
          "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());
      await _auth.currentUser()
          .then((user)=> Firestore.instance
          .collection("payments")
          .document()
          .setData({
        "uid": user.uid,
        "email": user.email,
        "transaction ": transactionInitialisation.toString(),
        "status": "payment made to RTIF",
        "date" : DateTime.now(),
      })

          .catchError((err) => print(err)))
          .catchError((err) => print(err));
      collectionReference.where("email", isEqualTo:
      email).getDocuments().then((snapshot)
      {
        return snapshot.documents.map((doc) {
          doc.reference.delete();
        });});


      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());
      return Text(e.toString());
    }
  }

  CollectionReference collectionReference =
  Firestore.instance.collection("cart");

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;


    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new GestureDetector(
          child: new Text(
            "Cart",
            style: new TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          SizedBox(height: 20.0),
          StreamBuilder<QuerySnapshot>(
              stream: collectionReference.where("email", isEqualTo:
          email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final int cardLength = snapshot.data.documents.length;
                  return Column(
                    children: <Widget>[
                      Column(
                        children: snapshot.data.documents.map((doc) {
                          return ListTile(
                            title: Text(doc.data['stand number']),
                            subtitle: Text(doc.data['amount']),
                            leading: new Container(
                              height: 96.0, width: 96.0,
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                      fit: BoxFit.fitWidth ,
                                      image: new NetworkImage(doc.data['image']))
                              ),

                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () async {
                                await
                                collectionReference
                                    .document(doc.documentID)
                                    .delete();

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Deleted"),
                                        content: Text("Removed from Cart"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                            ),
                          );
                        }).toList(),

                      ),
                      SizedBox(height: 30.0),
                    Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration:
                    new BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(20.0),)
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 150,
                          alignment: Alignment.bottomCenter,
                          decoration:
                          new BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                bottomLeft: const Radius.circular(20.0),)
                          ),
                          child: Column(
                            children: <Widget>[
                              new Text ("Total",
                                style: new TextStyle(fontSize: 10.0, color: Colors.blueGrey),),
                              new Text ("${cardLength*2500}",
                                      style: new TextStyle(fontSize: 24.0, color: Colors.black),),
                            ],
                          ),
                        ),
                        new RaisedButton(
                          onPressed: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoActionSheet(
                                      title: Text(
                                          "Enter your number in the format defined"),
                                      message: CupertinoTextField(
                                        controller: number,
                                        placeholder: '2547XXXXXXXX',
                                      ),
                                      actions: <Widget>[
                                        CupertinoButton(
                                          child: Text("Proceed"),
                                          onPressed: () {
                                            startCheckout(
                                                userPhone: number.text,
                                                amount: 1);
                                          },
                                        )
                                      ],
                                    ));

                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: 170,
                            decoration: const BoxDecoration(
                              color: Colors.deepPurpleAccent,
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child:
                            const Text('Book and pay now', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                    ),

                    ],
                  );
          }if(snapshot.data.documents.length == 0) {
            return new Container(
              constraints: const BoxConstraints(maxHeight: 500.0),
              child: new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          margin: new EdgeInsets.only(top: 00.0, bottom: 0.0),
                          height: 150.0,
                          width: 150.0,
                          child: new Image.network(
                            'https://static05.jockeyindia.com/uploads/images/img-no-cartitems.png',
                          )
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: new Text(
                          "You have no item in your cart....",
                          style: new TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      ),
                    ],
                  )),
            );
          } else {
            return new Center(
                child: new Center(child: new CircularProgressIndicator()));
          }
        }
          ),



        ],
      ),
    );
  }
}