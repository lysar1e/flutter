import 'package:dio/dio.dart';
import 'package:first_app/home_page.dart';
import 'package:first_app/login_form_page.dart';
import 'package:first_app/register_form_page.dart';
import 'package:first_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  final storage = new FlutterSecureStorage();
  final URL = "https://api.fasfafsa.fun";

  Future<dynamic> check() async {
    try {
      var response = await Dio().get("https://api.fasfafsa.fun/auth/check",
          options: Options(headers: {
            'Access-Control-Allow-Credentials': true,
            "Cookie": await storage.read(key: "access")
          }));
      return await response.data;
    } catch (err) {
      if (err is DioError) {
        if (err.response?.statusCode == 401) {
          var st = await storage.read(key: "access");
          var rf = await storage.read(key: "refresh");
          String converted = st.toString() + "; " + rf.toString();
          var res = await Dio().post("${URL}/auth/refresh",
              options: Options(headers: {
                'Access-Control-Allow-Credentials': true,
                "Cookie": converted,
              }));
          print(res);
          final cookies = res.headers.map['set-cookie'];
          if (cookies != null) {
            final authToken = cookies[0].split(";")[0];
            final refreshToken = cookies[1].split(";")[0];
            await storage.write(key: "access", value: authToken);
            await storage.write(key: "refresh", value: refreshToken);
          }
          return check();
        } else {
          return null;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rest Auth",
      home: FutureBuilder(
        future: check(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            print(snapshot);
            return HomePage();
          } else {
            print(snapshot);
            return LoginFormPage();
          }
        },
      ),
      routes: {
        "/login": (context) => LoginFormPage(),
        "/register": (context) => RegisterFormPage(),
        "/homepage": (context) => HomePage(),
      },
    );
  }
}
