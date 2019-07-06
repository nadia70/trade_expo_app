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
      body: new Center(
        child: new Text("Expo Order history",style: new TextStyle(fontSize: 25.0),),
      ),
    );
  }
}
