import 'package:flutter/material.dart';

class ExpoFavorites extends StatefulWidget {
  @override
  _ExpoFavoritesState createState() => _ExpoFavoritesState();
}

class _ExpoFavoritesState extends State<ExpoFavorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
       title: new Text("Favourites")
      ),
      body: new Center(
        child: new Text("My Favourites",style: new TextStyle(fontSize: 25.0),),
      ),

    );
  }
}
