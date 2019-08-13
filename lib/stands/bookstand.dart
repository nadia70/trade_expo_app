import 'package:expo_app/stands/stand_pay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'stands.dart';
import 'checkout.dart';




class BookStand extends StatefulWidget {
  String itemName;
  String itemImage;
  String itemLocation;
  String itemPrice;
  String itemRating;
  String itemStatus;

  BookStand(
      {this.itemName,
        this.itemImage,
        this.itemRating,
        this.itemPrice,
        this.itemLocation,
        this.itemStatus,});
  @override
  _BookStandState createState() => _BookStandState();
}

class _BookStandState extends State<BookStand> {



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

                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) => new PayStand(
                              itemImage: widget.itemImage,
                              itemName: widget.itemName,
                              itemLocation: widget.itemLocation,
                            )
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