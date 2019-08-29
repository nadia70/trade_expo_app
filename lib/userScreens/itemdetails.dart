import 'dart:async';

import 'package:expo_app/tools/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expo_app/models/fbconn.dart';



class ItemDetail extends StatefulWidget {

  String itemName;
  String itemPrice;
  String itemSubName;
  String itemImage;
  String itemRating;
  String itemDescription;
  final FbConn fbConn;
  final String itemKey;
  final index;

  ItemDetail({

    this.itemName,
    this.itemPrice,
    this.itemSubName,
    this.itemImage,
    this.itemRating,
    this.itemDescription,
    this.fbConn,
    this.itemKey,
    this.index
  });



  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {

  int cartCount;
  bool isInCart = false;
  int defaultQuantity = 1;
  FirebaseUser user;
  FirebaseAuth _auth;
  String fullName;
  String email;
  String phone;
  String userid;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription<Event> _cartSubscription;
  void showInSnackBar(String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
  @override
  void initState() {
    super.initState();
    _getCartCount();
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
    _cartSubscription.cancel();
    super.dispose();
  }


  Future _getCartCount() async {
    if (AppData.currentUserID == "" || AppData.currentUserID == null) return;
    final cartRef = FirebaseDatabase.instance
        .reference()
        .child(AppData.cartDB)
        .child(AppData.currentUserID);

    _cartSubscription = cartRef.onValue.listen((event) {
      if (event.snapshot.value == null) {
        isInCart = false;
        cartCount = 0;
        setState(() {});
        return;
      }
      Map valFav = event.snapshot.value;
      FbConn fbConn = new FbConn(valFav);
      cartCount = fbConn.getDataSize();
      for (int s = 0; s < fbConn.getDataSize(); s++) {
        String key = fbConn.getKeyIDasList()[s];
        if (key == widget.itemKey) {
          isInCart = true;
        }
      }
      setState(() {});
    });
  }

  Future addToCart() async {
    await _auth.currentUser()
        .then((user)=> Firestore.instance
        .collection("cart")
        .document()
        .setData({
      "uid": user.uid,
      "email": user.email,
      "stand number": widget.itemName,
      "amount": widget.itemPrice,
      "image": widget.itemImage,
    })
        .catchError((err) => print(err)))
        .catchError((err) => print(err));
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text("Item Detail"),
        centerTitle: false,
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        shape: new CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: new Container(
          height: 50.0,
          decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              new Container(
                width: (screenSize.width - 20) / 2,
                child: new GestureDetector(
                  onTap: () {
                    addToCart();
                    showInSnackBar(
                      /*widget.fbConn.getProductNameAsList()[widget.index] +*/
                        " Added to your cart");
                    isInCart = true;
                    setState(() {});
                  },
                  child: new Container(
                    width: 180.0,
                    height: 50.0,
                    //color: Colors.white,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ),
                        new Text(
                          "ADD TO CART",
                          style: new TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ExpoCart()));
            },
            child: new Icon(Icons.shopping_cart),
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: new Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          new Container(
            height: 300.0,
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(100.0),
                  bottomLeft: new Radius.circular(100.0),
                ),
                image: new DecorationImage(
                    image: new NetworkImage(widget.itemImage),
                    fit: BoxFit.fitHeight)),
          ),
          new Container(
            height: 300.0,
            decoration: new BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: new BorderRadius.only(
                bottomRight: new Radius.circular(100.0),
                bottomLeft: new Radius.circular(100.0),
              ),
            ),
          ),
          new SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  height: 50.0,
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          widget.itemName,
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          "Item Sub name",
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Icon(
                                  Icons.star,
                                  color: Colors.blue,
                                  size: 20.0,
                                ),
                                new SizedBox(
                                  width: 5.0,
                                ),
                                new Text(
                                  "${widget.itemRating}",
                                  style: new TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                            new Text(
                              "KSH.${widget.itemPrice}",
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    height: 150.0,
                    child: new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return new Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              new Container(
                                margin:
                                new EdgeInsets.only(left: 5.0, right: 5.0),
                                height: 140.0,
                                width: 100.0,
                                child: new Image.network(widget.itemImage),
                              ),
                              new Container(
                                margin:
                                new EdgeInsets.only(left: 5.0, right: 5.0),
                                height: 140.0,
                                width: 100.0,
                                decoration: new BoxDecoration(
                                    color: Colors.grey.withAlpha(50)),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          "Description",
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          widget.itemDescription,
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}