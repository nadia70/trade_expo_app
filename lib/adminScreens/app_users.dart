import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUsers extends StatefulWidget {

  @override
  _AppUsersState createState() => _AppUsersState();
}

class _AppUsersState extends State<AppUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Users"),),
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
                      "See Registered Users",
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
                    builder: (BuildContext context) => new  Users()
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
                          "Users",
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
                    builder: (BuildContext context) => new  Ex()
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
                          "Exhibitors",
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

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Future getUsers() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("users").getDocuments();
    return qn.documents;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users"),centerTitle: true,),
      body: Container(
        child: new Column(
          children: <Widget>[

            new Flexible(
              child: FutureBuilder(
                  future: getUsers(),
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
                            onTap: (){},
                            child: new Card(
                              child: Stack(
                                alignment: FractionalOffset.topLeft,
                                children: <Widget>[
                                  new ListTile(
                                    leading: new CircleAvatar(
                                      child: new Text("${snapshot.data[index].data["fname"]
                                          .substring(0,1)}".toUpperCase(),
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.0,
                                            color: Colors.white),),
                                    ),
                                    title: new Text("${snapshot.data[index].data["fname"]}${snapshot.data[index].data["surname"]}",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0,
                                          color: Colors.deepPurple),),
                                    subtitle: new Text("${snapshot.data[index].data["email"]}",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.0,
                                          color: Colors.deepPurple),),
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
      )
    );
  }
}


class Ex extends StatefulWidget {
  @override
  _ExState createState() => _ExState();
}

class _ExState extends State<Ex> {
  Future getExhibitors() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("exhibitor").getDocuments();
    return qn.documents;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Exhibitors"),centerTitle: true,),
        body: Container(
          child: new Column(
            children: <Widget>[

              new Flexible(
                child: FutureBuilder(
                    future: getExhibitors(),
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
                              onTap: (){},
                              child: new Card(
                                child: Stack(
                                  alignment: FractionalOffset.topLeft,
                                  children: <Widget>[
                                    new ListTile(
                                      trailing: new CircleAvatar(
                                        child: new Text("${snapshot.data[index].data["fname"]
                                            .substring(0,1)}".toUpperCase(),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.0,
                                              color: Colors.white),),
                                      ),
                                      title: new Text("${snapshot.data[index].data["fname"]}${snapshot.data[index].data["surname"]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.0,
                                            color: Colors.deepPurple),),
                                      subtitle: new Text("${snapshot.data[index].data["email"]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.0,
                                            color: Colors.deepPurple),),
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
        )
    );
  }
}
