import 'package:expo_app/adminScreens/admin%20_login.dart';
import 'package:expo_app/exhibitor/ex_reg.dart';
import 'package:expo_app/user/user_reg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      resizeToAvoidBottomPadding: true,
      body: new ListView(

        children: <Widget>[
          new Container(
            height: 250.0,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      margin: new EdgeInsets.only(top: 20.0, bottom: 0.0),
                      height: 100.0,
                      width: 100.0,
                      child: new Hero(
                        tag: 'hero',
                        child: FlutterLogo(size: 200.0),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Welcome to the Rwanda trade expo. Login As User Exhibitor or Admin",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),

                ],
              ),
            ),
            decoration: new BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: new BorderRadius.only(
                    bottomLeft: new Radius.circular(20.0),
                    bottomRight: new Radius.circular(20.0))),

          ),

          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
           child: new InkWell(
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new  UserReg()
                ));
              },
              child: new Container(
                height: 60.0,
                margin: new EdgeInsets.only(top: 5.0),
                child: new Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Container(
                    margin: new EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 2.0),
                    height: 60.0,
                    decoration: new BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(20.0))),
                    child: new Center(
                        child: new Text(
                          "User",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        )),
                  ),
                ),
              ),
            ),

          ),

          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: new InkWell(
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new  RegisterPage()
                ));
              },
              child: new Container(
                height: 60.0,
                margin: new EdgeInsets.only(top: 5.0),
                child: new Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Container(
                    margin: new EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 2.0),
                    height: 60.0,
                    decoration: new BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(20.0))),
                    child: new Center(
                        child: new Text(
                          "Exhibitor",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        )),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: new InkWell(
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new  AdminLogin()
                ));
              },
              child: new Container(
                height: 60.0,
                margin: new EdgeInsets.only(top: 5.0),
                child: new Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Container(
                    margin: new EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 2.0),
                    height: 60.0,
                    decoration: new BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(20.0))),
                    child: new Center(
                        child: new Text(
                          "Admin",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}