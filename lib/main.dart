// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: use_key_in_widget_constructors
import 'package:dio/dio.dart';
import 'package:first_app/app.dart';
import 'package:first_app/login_form_page.dart';
import 'package:first_app/named_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(App());
// final storage = new FlutterSecureStorage();

// class MyFirstFlutterApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Demo",
//       home: NamedRoutes(),
//     );
//   }
// }
// fetchData() async {
//     var response = await Dio().post("https://api.fasfafsa.fun/auth/sign-in",
//         data: {"email": "test@gmail.com", "password": "test"},
//         options: Options(
//             headers: {'Access-Control-Allow-Credentials': true},
//             extra: {"withCredentials": true}));
//     final cookies = response.headers.map['set-cookie'];
//     if (cookies != null) {
//       final authToken = cookies[0].split(";")[0];
//       await storage.write(key: "access", value: authToken);
//     }
//     final access = await storage.read(key: "access");
//     var res = await Dio().get("https://api.fasfafsa.fun/board/get",
//         options: Options(headers: {
//           // 'Access-Control-Allow-Credentials': true,
//           "Cookie": await storage.read(key: "access")
//         }));
//     print(res);
//   }