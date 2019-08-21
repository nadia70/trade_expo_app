import 'package:expo_app/login/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'add_products.dart';
import 'package:expo_app/userScreens/messages.dart';

import 'app_users.dart';
import 'open_stands.dart';

class AdminHome extends StatefulWidget {
    @override
    _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
    Size screenSize;
    @override
    Widget build(BuildContext context) {
        screenSize = MediaQuery.of(context).size;
        return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: new AppBar(
                title: new Text("App Admin"),
                centerTitle: true,
                elevation: 0.0,
            ),
            //drawer: new Drawer(),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: new Column(
                    children: <Widget>[
                        new SizedBox(
                            height: 20.0,
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[

                                new GestureDetector(
                                    onTap: () {
                                        Navigator.of(context).push(new CupertinoPageRoute(
                                            builder: (context) => AppUsers()));
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(Icons.person),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text("App Users"),
                                            ],
                                        ),
                                    ),
                                ),
                            ],
                        ),

                        new SizedBox(
                            height: 20.0,
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(new CupertinoPageRoute(
                                      builder: (context) => ExpoMessages()));
                                },
                                child: new CircleAvatar(
                                  maxRadius: 70.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(Icons.chat),
                                      new SizedBox(
                                        height: 10.0,
                                      ),
                                      new Text("App Messages"),
                                    ],
                                  ),
                                ),
                              ),
                                GestureDetector(
                                    onTap: () {
                                        Navigator.of(context).push(new CupertinoPageRoute(
                                            builder: (context) => AddProducts()));
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(Icons.add),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text("Add Expo"),
                                            ],
                                        ),
                                    ),
                                ),
                            ],
                        ),
                      new SizedBox(
                        height: 20.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(new CupertinoPageRoute(
                                  builder: (context) => OpenStand()));
                            },
                            child: new CircleAvatar(
                              maxRadius: 70.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(Icons.table_chart),
                                  new SizedBox(
                                    height: 10.0,
                                  ),
                                  new Text("Stands"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      new SizedBox(
                        height: 20.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(new CupertinoPageRoute(
                                  builder: (BuildContext context) => new WelcomeScreen()
                              ));
                            },
                            child: new CircleAvatar(
                              maxRadius: 20.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(Icons.lock),
                                  new SizedBox(
                                    height: 10.0,
                                  ),
                                  new Text("LOGOUT"),
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
    }
}