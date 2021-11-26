// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register Page"),
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
                        child: Text("Регистрация"),
                        onPressed: () {},
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                      TextButton(
                          child: Text("Уже есть аккаунт ?",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () => Navigator.pop(context, "/login"),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.only(left: 5.0))),
                      TextButton(
                          child: Text("Забыли пароль ?",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.only(left: 12.0))),
                    ],
                  )),
            ],
          ),
        ));
  }
}
