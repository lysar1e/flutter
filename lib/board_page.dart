// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: use_key_in_widget_constructors
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  final storage = new FlutterSecureStorage();
  var _board = {};
  @override
  Widget build(BuildContext context) {
    Future<dynamic> getBoard() async {
      final boardId = ModalRoute.of(context)!.settings.arguments as int;
      String? accessToken = await storage.read(key: "access");
      var response =
          await Dio().get("https://api.fasfafsa.fun/board/${boardId}",
              options: Options(headers: {
                'Access-Control-Allow-Credentials': true,
                "Cookie": accessToken,
              }));
      setState(() async {
        _board = await response.data;
      });
      return await response.data;
    }

    @override
    Widget Board() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Страница доски"),
        ),
        body: Stack(
          children: <Widget>[
            Text(_board["name"]),
          ],
        ),
      );
    }

    return MaterialApp(
      title: "Board page",
      home: FutureBuilder(
        future: getBoard(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            // print(snapshot);
            return BoardPage();
          } else {
            return BoardPage();
          }
        },
      ),
    );
  }
}
