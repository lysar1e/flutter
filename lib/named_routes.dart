// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: use_key_in_widget_constructors
import 'package:first_app/home_page.dart';
import 'package:first_app/login_form_page.dart';
import 'package:first_app/register_form_page.dart';
import 'package:flutter/material.dart';

class NamedRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: "/login", routes: {
      "/login": (context) => LoginFormPage(),
      "/register": (context) => RegisterFormPage(),
      "/homepage": (context) => HomePage(),
    });
  }
}
