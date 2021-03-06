// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: use_key_in_widget_constructors
import 'package:dio/dio.dart';
import 'package:first_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginFormPage extends StatefulWidget {
  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final storage = new FlutterSecureStorage();
  final URL = "https://api.fasfafsa.fun";
  String _email = "";
  String _password = "";
  String _loginErr = "";
  void login() async {
    try {
      var response = await Dio().post("https://api.fasfafsa.fun/auth/sign-in",
          data: {"email": _email, "password": _password},
          options: Options(
              headers: {'Access-Control-Allow-Credentials': true},
              extra: {"withCredentials": true}));
      final cookies = response.headers.map['set-cookie'];
      if (cookies != null) {
        final authToken = cookies[0].split(";")[0];
        final refreshToken = cookies[1].split(";")[0];
        await storage.write(key: "access", value: authToken);
        await storage.write(key: "refresh", value: refreshToken);
        Navigator.pushNamedAndRemoveUntil(
            context, "/homepage", (route) => false);
      }
    } catch (err) {
      if (err is DioError) {
        setState(() {
          this._loginErr = err.response?.data["message"];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
          centerTitle: true,
        ),
        body: Form(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextField(
                decoration:
                    InputDecoration(labelText: "Email", hintText: "email"),
                onChanged: (value) => setState(() {
                  this._email = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Password", hintText: "password"),
                obscureText: true,
                onChanged: (value) => setState(() {
                  this._password = value;
                }),
              ),
              this._loginErr != ""
                  ? Text(
                      _loginErr,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )
                  : Container(),
              Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: <Widget>[
                      MaterialButton(
                        child: Text("??????????"),
                        onPressed: () => login(),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                      TextButton(
                          child: Text("?????? ???????????????? ?",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () =>
                              Navigator.pushNamed(context, "/register"),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.only(left: 12.0))),
                      TextButton(
                          child: Text("???????????? ???????????? ?",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () => null,
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.only(left: 12.0))),
                    ],
                  )),
            ],
          ),
        ));
  }
}
