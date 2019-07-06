import 'package:flutter/material.dart';

class ExpoAddress extends StatefulWidget {
  @override
  _ExpoAddressState createState() => _ExpoAddressState();
}

class _ExpoAddressState extends State<ExpoAddress> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("My delivery Detais")
      ),
      body: new Center(
        child: new Text("Delivery address",style: new TextStyle(fontSize: 25.0),),
      ),
    );
  }
}
