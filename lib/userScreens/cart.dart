import 'package:flutter/material.dart';

class ExpoCart extends StatefulWidget {
  @override
  _ExpoCartState createState() => _ExpoCartState();
}

class _ExpoCartState extends State<ExpoCart> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("My Cart")
      ),
      body: new Center(
        child: new Text("My Cart",style: new TextStyle(fontSize: 25.0),),
      ),
    );
  }
}
