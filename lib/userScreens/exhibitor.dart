import 'package:expo_app/login/welcome_screen.dart';
import 'package:expo_app/userScreens/myHomePage.dart';
import 'package:expo_app/userScreens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expo_app/tools/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'about.dart';
import 'help.dart';
import 'todo.dart';
import 'dart:async';
import 'package:expo_app/stands/standlist.dart';

class Exhibitor extends StatefulWidget {
  Exhibitor({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _ExhibitorState();
}

class _ExhibitorState extends State<Exhibitor> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

  FirebaseUser user;
  FirebaseAuth _auth;

  bool _isEmailVerified = false;
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

    _checkEmailVerification();
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

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail(){
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resent link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  _onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] = Todo.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapshot(event.snapshot));
    });
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
      Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new WelcomeScreen()
      ));


    } catch (e) {
      print(e);
    }
  }

  _addNewTodo(String todoItem) {
    if (todoItem.length > 0) {

      Todo todo = new Todo(todoItem.toString(), widget.userId, false);
      _database.reference().child("todo").push().set(todo.toJson());
    }
  }

  _updateTodo(Todo todo){
    //Toggle completed
    todo.completed = !todo.completed;
    if (todo != null) {
      _database.reference().child("todo").child(todo.key).set(todo.toJson());
    }
  }

  _deleteTodo(String todoId, int index) {
    _database.reference().child("todo").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }

  _showDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add exhibition item',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    _addNewTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        }
    );
  }

  Widget _showTodoList() {
    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;
            String subject = _todoList[index].subject;
            bool completed = _todoList[index].completed;
            String userId = _todoList[index].userId;
            return Dismissible(
              key: Key(todoId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                _deleteTodo(todoId, index);
              },
              child: ListTile(
                title: Text(
                  subject,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: IconButton(
                    icon: (completed)
                        ? Icon(
                      Icons.done_outline,
                      color: Colors.green,
                      size: 20.0,
                    )
                        : Icon(Icons.done, color: Colors.grey, size: 20.0),
                    onPressed: () {
                      _updateTodo(_todoList[index]);
                    }),
              ),
            );
          });
    } else {
      return Center(child: Text("Welcome. Your list is empty",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),));
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(

          actions: <Widget>[
        new FlatButton(
        child: new Text('See available Stands',
            style: new TextStyle(fontSize: 17.0, color: Colors.white)),
        onPressed: (){
          Navigator.of(context).push(new CupertinoPageRoute(
              builder: (BuildContext context) => new ExpoStand()
          ));
        },),
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: (){
                  Navigator.of(context).push(new CupertinoPageRoute(
                      builder: (BuildContext context) => new WelcomeScreen()
                  ));
                },)
          ],
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
        body: new MyHomePage(),

    );
  }
}
