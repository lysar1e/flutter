// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Board Page"),
      ),
      body: Stack(
        children: <Widget>[
          Text("This is a board page",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
