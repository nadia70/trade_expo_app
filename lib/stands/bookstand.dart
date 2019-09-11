import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expo_app/mpesa_pay/mpesa_flutter_plugin.dart';
import 'package:expo_app/stands/stand_pay.dart';
import 'package:expo_app/userScreens/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'stands.dart';
import 'checkout.dart';
import 'mpesa.dart';




class BookStand extends StatefulWidget {
  String itemName;
  String itemImage;
  String itemLocation;
  String itemPrice;
  String itemRating;
  String itemStatus;
  String itemID;

  BookStand(
      {this.itemName,
        this.itemImage,
        this.itemRating,
        this.itemPrice,
        this.itemLocation,
        this.itemStatus,
        this.itemID,});
  @override
  _BookStandState createState() => _BookStandState();
}

class _BookStandState extends State<BookStand> {
  FirebaseUser user;
  FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    
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
          .collection("receipt")
          .document()
          .setData({
        "uid": user.uid,
        "email": user.email,
        "transaction ": transactionInitialisation.toString(),
        "status": "payment made to RTIF",
        "stand number": widget.itemName,
        "amount": widget.itemPrice,
        "date" : DateTime.now(),
      })
          .then((result) =>
          Navigator.of(context).push(new CupertinoPageRoute(
              builder: (BuildContext context) => new  Detailed(
                itemNumber: widget.itemName,
                itemAmount: widget.itemPrice,

              )
          )))

          .catchError((err) => print(err)))
          .catchError((err) => print(err));


      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());
      return Text(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text("Item Detail"),
        centerTitle: false,
      ),


      body: new Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            children: <Widget>[

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
                              widget.itemLocation,
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
                              "An exhibition, in the most general sense, is an organised presentation and display of a selection of items. In practice, exhibitions usually occur within a cultural or educational setting such as a museum, art gallery, park, library, exhibition hall, or World's fairs. Exhibitions can include many things such as art in both major museums and smaller galleries, interpretive exhibitions, natural history museums and history museums, and also varieties such as more commercially focused exhibitions and trade fairs.",
                              style: new TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            const SizedBox(height: 30),
                            RaisedButton(
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
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child:
                                const Text('Book and pay now', style: TextStyle(fontSize: 20)),
                              ),
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
        ],
      ),
    );
  }


}

class Detailed extends StatefulWidget {


  String itemNumber;
  String itemAmount;

  Detailed({

    this.itemNumber,
    this.itemAmount,
  });



  @override
  _DetailedState createState() => _DetailedState();
}

class _DetailedState extends State<Detailed> {

  FirebaseUser user;
  FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text("Item Detail"),
        centerTitle: false,
      ),

      body: new Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
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
                        Center(
                          child: new Text(
                            "Payment receipt",
                            style: new TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
                          ),
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
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new SizedBox(
                                  width: 5.0,
                                ),
                                new Text(
                                  "Stand number",
                                  style: new TextStyle(color: Colors.black, fontSize: 18.0,),
                                )
                              ],
                            ),
                            new Text(
                              widget.itemNumber,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
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
                                new SizedBox(
                                  width: 5.0,
                                ),
                                new Text(
                                  "Amount",
                                  style: new TextStyle(color: Colors.black, fontSize: 18.0,),
                                )
                              ],
                            ),
                            new Text(
                              widget.itemAmount,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
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
                                new SizedBox(
                                  width: 5.0,
                                ),
                                new Text(
                                  "Status",
                                  style: new TextStyle(color: Colors.black, fontSize: 18.0,),
                                )
                              ],
                            ),
                            new Text(
                              "Successful payment made to RTIF",
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.indigo,
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

              ],
            ),
          ),
        ],
      ),
    );
  }
}
