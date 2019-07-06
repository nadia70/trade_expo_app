import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class CheckOut extends StatefulWidget {
  String itemName;
  String itemImage;
  String itemSubName;
  String itemLocation;
  String itemPrice;
  String itemRating;
  String itemStatus;

  CheckOut(
      {this.itemName,
        this.itemImage,
        this.itemRating,
        this.itemPrice,
        this.itemLocation,
        this.itemSubName,
        this.itemStatus});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                child: new Text(
                  "BOOK NOW",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),

            ],
          ),
        ),
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
                                      style: new TextStyle(color: Colors.black, fontSize: 20.0,),
                                    )
                                  ],
                                ),
                                new Text(
                                  widget.itemName,
                                  style: new TextStyle(
                                      fontSize: 20.0,
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
                                      "Stand location",
                                      style: new TextStyle(color: Colors.black, fontSize: 20.0),
                                    )
                                  ],
                                ),
                                new Text(
                                  widget.itemLocation,
                                  style: new TextStyle(

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
                                      "Total",
                                      style: new TextStyle(color: Colors.black, fontSize: 20.0),
                                    )
                                  ],
                                ),
                                new Text(
                                  "KSH.${widget.itemPrice}",
                                  style: new TextStyle(

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
                              "Payment",
                              style: new TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Text(
                              "Pay Now to book your stand or pay later at your own convinience. Remember the longer you wait the higher your chances of losing your slot",
                              style: new TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                            new SizedBox(
                              height: 10.0,
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
                                    const SizedBox(height: 30),
                                    RaisedButton(
                                      textColor: Colors.white,
                                      onPressed: (){ bookStand(context);
                                      widget.createState();
                                      },
                                      padding: const EdgeInsets.all(0.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red
                                        ),
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                        const Text('Pay now', style: TextStyle(fontSize: 20)),
                                      ),
                                    ),
                                  ],
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
        ],
      ),


    );
  }
}

void bookStand(BuildContext context) {

  var alertDialog = AlertDialog(
    title: Text("Stand Booked Successfully"),
    content: Text("We cannot wait to host you"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog);
}


