
import 'dart:async';

import 'package:expo_app/models/fbconn.dart';
import 'package:expo_app/tools/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'favorites.dart';
import 'help.dart';
import 'messages.dart';
import 'profile.dart';
import 'about.dart';
import 'itemdetails.dart';
import 'root_page.dart';
import 'package:expo_app/tools/authentication.dart';
import 'package:expo_app/adminScreens/admin_home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BuildContext context;

  PageController _pageController;
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  final userRef = FirebaseDatabase.instance.reference().child(AppData.userDB);
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription<Event> _msgSubscription;
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
    _pageController = new PageController();
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

    setState(() {
      nameController.text = fullName;
    });

    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        setState(() {
          _isSignedIn = false;
          fullName = null;
          profileImgUrl = null;
          email = null;
          nameController.text = null;
        });
      } else {
        setState(() {
          _isSignedIn = true;
          email = user.email;
          fullName = user.displayName;
          profileImgUrl = user.photoUrl;
          nameController.text = fullName;
        });
      }
    });

    _getUnReadMSG();
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
    ));
  }

  Future _getUnReadMSG() async {
    final msgRef = FirebaseDatabase.instance
        .reference()
        .child(AppData.messagesDB)
        .child(AppData.currentUserID);

    /*_msgSubscription = await msgRef.once().then((snapshot) {
      if (snapshot.value == null) {
        msgCount = 0;
        setState(() {});
        return;
      }
      setState(() {
        msgCount = 0;
      });
      Map valFav = snapshot.value;
      FbConn fbConn = new FbConn(valFav);
      for (int s = 0; s < fbConn.getDataSize(); s++) {
        if (fbConn.getMessageRead()[s] == false) {
          msgCount = msgCount + 1;
        }
      }
      if (msgCount > 0) {
        setState(() {
          createNotification();
          print(msgCount);
        });
      }
    });*/

    _msgSubscription = msgRef.onValue.listen((event) {
      if (event.snapshot.value == null) {
        msgCount = 0;
        setState(() {});
        return;
      }
      setState(() {
        msgCount = 0;
      });
      Map valFav = event.snapshot.value;
      FbConn fbConn = new FbConn(valFav);
      for (int s = 0; s < fbConn.getDataSize(); s++) {
        if (fbConn.getMessageRead()[s] == false &&
            fbConn.getMessageSenderIDasList()[s] != AppData.currentUserID) {
          msgCount = msgCount + 1;
        }
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _msgSubscription.cancel();
  }



  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Trade Expo"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search,
          color: Colors.white,)
              , onPressed: (){
                showSearch(context: context, delegate: DataSearch());
              }),
          new Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.chat,
                color: Colors.white,)
                  , onPressed: (){
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (BuildContext context) => new ExpoMessages()
                    ));
                  }),

            ],
          )
        ],
      ),
      body: Items(),
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


              


            ],
          ),
        ),
    );
  }
}

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  Future getData() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("appProducts").getDocuments();
    return qn.documents;

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading... Please wait"),
          );
        }else{
          return GridView.builder(gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new ItemDetail(

                    itemImage: snapshot.data[index].data["appProducts"][0],
                    itemName: snapshot.data[index].data["productTitle"],
                    itemPrice: snapshot.data[index].data["productPrice"],
                    itemRating: snapshot.data[index].data["productRating"],
                    itemDescription: snapshot.data[index].data["productDesc"],


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
                                    image: new NetworkImage(snapshot.data[index].data["appProducts"][0]))
                            ),

                          ),
                          new Container(
                            height:35.0 ,
                            color: Colors.black.withAlpha(100),
                            child: new Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text("${snapshot.data[index].data["productTitle"]
                                      .substring(0,10)}...",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.0,
                                        color: Colors.white),),
                                  new Text("KSH.${snapshot.data[index].data["productPrice"]}",
                                    style: new TextStyle(
                                        color: Colors.red[500],
                                        fontWeight: FontWeight.w400),),
                                ],
                              ),
                            ),
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
      }),

    );

  }
}


class DataSearch extends SearchDelegate<String>{
  List list;
  DataSearch({this.list});

  final category = [

    "shoes",
    "art",
    "crafts",
    "clothes",
    "shoes",
    "art",
    "crafts",
    "clothes",
    "shoes",
    "art",
    "crafts",
    "clothes",
    "shoes",
    "art",
    "crafts",
    "clothes",


  ];

  final recentSearch = [

    "shoes",
    "art",
    "crafts",
    "clothes",


  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for appbar
    return [ IconButton(icon: Icon(Icons.clear), onPressed: () {
      query="";
    }) ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading Icon
    return IconButton(icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
    ), onPressed: (){
      close(context, null);

    } );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Results
    return Card(

      color: Colors.red,
      child: Center(
        child: Text(query),
      ),

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions
    final suggestionList = query.isEmpty?recentSearch:category.where((p)=>p.startsWith(query)).toList();
    
    return ListView.builder(itemBuilder: (context,index) => ListTile(

      onTap: (){

        showResults(context);

      },

     leading: Icon(Icons.arrow_right),
      title: RichText(text: TextSpan(
        text: suggestionList[index].substring(0,query.length),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

        children: [TextSpan(
          text: suggestionList[index].substring(query.length),
          style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.normal)
        )]
      )),

    ),
    itemCount: suggestionList.length,

    );
    
  }

}