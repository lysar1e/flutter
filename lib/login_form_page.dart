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
  void login() async {
    var response = await Dio().post("https://api.fasfafsa.fun/auth/sign-in",
        data: {"email": "test@gmail.com", "password": "test"},
        options: Options(
            headers: {'Access-Control-Allow-Credentials': true},
            extra: {"withCredentials": true}));
    final cookies = response.headers.map['set-cookie'];
    if (cookies != null) {
      final authToken = cookies[0].split(";")[0];
      final refreshToken = cookies[1].split(";")[0];
      await storage.write(key: "access", value: authToken);
      await storage.write(key: "refresh", value: refreshToken);
      Navigator.pushNamedAndRemoveUntil(context, "/homepage", (route) => false);
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
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Password", hintText: "password"),
                obscureText: true,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: <Widget>[
                      MaterialButton(
                        child: Text("Войти"),
                        onPressed: () => login(),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                      TextButton(
                          child: Text("Нет аккаунта ?",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () =>
                              Navigator.pushNamed(context, "/register"),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.only(left: 12.0))),
                      TextButton(
                          child: Text("Забыли пароль ?",
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
