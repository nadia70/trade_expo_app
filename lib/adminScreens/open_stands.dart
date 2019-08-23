import 'package:flutter/material.dart';
import 'package:expo_app/stands/stands.dart';
import 'package:expo_app/stands/bookstand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_stand.dart';

class OpenStand extends StatefulWidget {
  @override
  _OpenStandState createState() => _OpenStandState();
}

class _OpenStandState extends State<OpenStand> {
  Future getStands() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("receipt").getDocuments();
    return qn.documents;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddStand()));
        },
        child: new Icon(Icons.add),
      ),
      appBar: new AppBar(
        title: new Text('Booked stands'),

      ),
      body: new Center(
        child: new Column(
          children: <Widget>[

            new Flexible(
              child: FutureBuilder(
                  future: getStands(),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading... Please wait"),
                      );
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return new GestureDetector(

                            child: new Card(
                              child: Stack(
                                alignment: FractionalOffset.topRight,
                                children: <Widget>[
                                  new Stack(
                                    alignment: FractionalOffset.bottomCenter,
                                    children: <Widget>[

                                      new Container(
                                        height:100.0 ,
                                        color: Colors.transparent,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(8.0),

                                          child: Column(
                                            children: <Widget>[
                                              new SizedBox(
                                                height: 10.0,
                                              ),

                                              new Row(
                                                children: <Widget>[
                                                  new Text("Stand number ${snapshot.data[index].data["stand number"]}",
                                                    style: new TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16.0,
                                                        color: Colors.deepPurple),),

                                                ],
                                              ),
                                              new SizedBox(
                                                height: 10.0,
                                              ),
                                              new Row(
                                                children: <Widget>[
                                                  new Text("Booked by: ${snapshot.data[index].data["email"]}",
                                                    style: new TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 12.0,
                                                        color: Colors.deepPurple),),

                                                ],
                                              ),

                                              new SizedBox(
                                                height: 10.0,
                                              ),
                                              new Row(
                                                children: <Widget>[
                                                  new Text("Date: ${snapshot.data[index].data["date"]}",
                                                    style: new TextStyle(
                                                        color: Colors.red[500],
                                                        fontWeight: FontWeight.w400),),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );

                        },
                      );

                    }
                  }),)
          ],
        ),
      ),
    );
  }
}
