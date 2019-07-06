import 'package:flutter/material.dart';

class ExpoNotifications extends StatefulWidget {
  @override
  _ExpoNotificationsState createState() => _ExpoNotificationsState();
}

class _ExpoNotificationsState extends State<ExpoNotifications> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Notifications")
      ),
      body: new Center(
        child: new Text("My Notifications",style: new TextStyle(fontSize: 25.0),),
      ),
    );
  }
}
