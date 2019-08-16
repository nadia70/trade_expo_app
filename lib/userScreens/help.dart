import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'messages.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpView();
  }
}

class HelpView extends StatefulWidget {
  @override
  _HelpViewState createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {


  @override
  void initState() {
    super.initState();
  }



  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Frequently asked questions"),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey.withOpacity(0.15),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    title: Text(
                      "When is the expo?",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text("The Expo will be pening from 30th august to 15th September 2019"),
                  )),


            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "How much does one pay for to book a stand?",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text("Our stands sell for a uniform price of 2500 and are booked on a first come first served basis."),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "How can one book Stand?",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text("To book Stand you have to pay the full amount straight from the app after which you receive a receipt to your email and then one of our staff members will contactyou with further details if need be."),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "Payment process?",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text("Click on available stands, select a stand, fill in your payment details, pay via mpesa or credit card. Receive your email receipt"),
                  ),

                  Divider(),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      "Where Is the expo going to takeplace?",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text("The expo will be held at te international stadium "),
                  ),

                  Divider(),
                  ListTile(
                    title: Text(
                      "Let's Talk",
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: (){
                      Navigator.of(context).push(new CupertinoPageRoute(
                          builder: (BuildContext context) => new ExpoMessages()
                      ));
                    },
                    trailing: new CircleAvatar(
                      child: new Icon(Icons.chat,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}