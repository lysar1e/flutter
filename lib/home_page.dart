// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: use_key_in_widget_constructors
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();
  var _boards = [];
  logout() async {
    try {
      var st = await storage.read(key: "access");
      var rf = await storage.read(key: "refresh");
      String converted = st.toString() + "; " + rf.toString();
      var response = await Dio().post("https://api.fasfafsa.fun/auth/logout");
      await storage.deleteAll();
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    } catch (err) {
      if (err is DioError) {
        print(err);
      }
    }
  }

  Future<dynamic> getUserBoards() async {
    var response = await Dio().get("https://api.fasfafsa.fun/board/get",
        options: Options(headers: {
          'Access-Control-Allow-Credentials': true,
          "Cookie": await storage.read(key: "access")
        }));
    // setState(() async {
    //   this._boards = await response.data;
    // });
    this._boards = await response.data["boards"];
    print(await response.data["boards"]);
    // print("get ${this._boards}");
    return await response.data;
  }

  @override
  Widget Boards() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Board Page"),
        actions: <Widget>[
          IconButton(onPressed: () => logout(), icon: Icon(Icons.logout)),
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    // for (var name in _boards) Text(name["name"]),
                    for (int i = 0; i < _boards.length; i++)
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        padding: EdgeInsets.only(
                            top: 50, right: 50, left: 50, bottom: 0),
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.blue),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                                // margin: EdgeInsets.only(top: 50.0),
                                child: Stack(children: [
                              Text(_boards[i]["name"],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              Container(
                                  margin: EdgeInsets.only(bottom: 0, top: 50.0),
                                  child: TextButton(
                                    child: Text("ПЕРЕЙТИ К ДОСКЕ",
                                        style: TextStyle(color: Colors.orange)),
                                    onPressed: () => null,
                                    style: TextButton.styleFrom(
                                        minimumSize: Size(100, 20),
                                        alignment: Alignment.bottomLeft),
                                  ))
                            ]))
                          ],
                        ),
                        // color: Colors.white,
                      )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserBoards(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return Boards();
          } else {
            return Boards();
          }
        });
  }
}
