import 'package:expo_app/login/welcome_screen.dart';
import 'package:expo_app/userScreens/about.dart';
import 'package:expo_app/userScreens/help.dart';
import 'package:expo_app/userScreens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'stands.dart';
import 'bookstand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpoStand extends StatefulWidget {
  @override
  _ExpoStandState createState() => _ExpoStandState();
}

class _ExpoStandState extends State<ExpoStand> {

  FirebaseUser user;
  FirebaseAuth _auth;
  int msgCount = 0;

  String fullName;
  String email;
  String phone;
  String userid;
  String profileImgUrl;
  bool isLoggedIn;
  String _btnText;
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
  }

  Future _getCurrentUser() async {
    await _auth.currentUser().then((user) {
      //_getCartCount();
      if (user != null) {
        setState(() {
          _btnText = "Logout";
          _isSignedIn = true;
          email = user.email;
          fullName = user.displayName;
          profileImgUrl = user.photoUrl;
          user = user;
          //profileImgUrl = googleSignIn.currentUser.photoUrl;

//          UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
//          userUpdateInfo.photoUrl = "";
//          userUpdateInfo.displayName = "Esther Tony";
//          _auth.updateProfile(userUpdateInfo);
        });
      }
    });
  }
  Future getStands() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("stand").getDocuments();
    return qn.documents;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
appBar: AppBar(
  title: Text("Available stands"),
),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: Text(email != null ? email : email = "you@email.com"),
              currentAccountPicture: new CircleAvatar(backgroundColor: Colors.white,
                child: new Icon(Icons.person) ,)
              ,),

            new Divider(),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(Icons.person,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Profile settings"),
              onTap: (){
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new ExpoProfile()
                ));
              },
            ),

            new Divider(),
            new ListTile(
              trailing: new CircleAvatar(
                child: new Icon(Icons.border_color,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("About us"),
              onTap: (){
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new ExpoAbout()
                ));
              },
            ),

            new Divider(),
            new ListTile(
              trailing: new CircleAvatar(
                child: new Icon(Icons.help,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Help"),
              onTap: (){
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new HelpPage()
                ));
              },
            ),
            new Divider(),
            new ListTile(
              trailing: new CircleAvatar(
                child: new Icon(Icons.lock,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("logout"),
              onTap: (){
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new WelcomeScreen()
                ));
              },
            ),






          ],
        ),
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
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new BookStand(


                        itemImage: snapshot.data[index].data["image"],
                        itemName: snapshot.data[index].data["standno"],
                        itemPrice: snapshot.data[index].data["price"],
                        itemRating: snapshot.data[index].data["rating"],
                        itemLocation: snapshot.data[index].data["location"],
                        itemStatus: snapshot.data[index].data["status"],


                      )));
                    },
                    child: new Card(
                      child: Stack(
                        alignment: FractionalOffset.topLeft,
                        children: <Widget>[
                          new Stack(
                            alignment: FractionalOffset.bottomCenter,
                            children: <Widget>[
                              new Container(
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                        fit: BoxFit.fitWidth ,
                                        image: new NetworkImage(snapshot.data[index].data["image"]))
                                ),
                              ),

                              new Container(
                                height:50.0 ,
                                color: Colors.transparent,
                                child: new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Text("${snapshot.data[index].data["standno"]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.0,
                                            color: Colors.deepPurple),),
                                      new Text("${snapshot.data[index].data["location"]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0,
                                            color: Colors.deepPurple),),
                                      new Text("KSH.${snapshot.data[index].data["price"]}",
                                        style: new TextStyle(
                                            color: Colors.red[500],
                                            fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                ),
                              ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                              new Container(
                              height: 30.0,
                              width: 60.0,
                              child: new Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                              new Text(
                              "${snapshot.data[index].data["status"]}",
                              style: new TextStyle(color: Colors.white),
                              )
                              ],
                              ),
                              ),

                              ],
                              )
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
