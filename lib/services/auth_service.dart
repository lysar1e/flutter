import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final storage = new FlutterSecureStorage();
  final URL = "https://api.fasfafsa.fun";
  // static Future<Map<String, dynamic>> getToken() async {
  //   return await SESSION.get('tokens');
  // }
  login(String email, String password) async {
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
    }
  }

  Future<dynamic> check() async {
    var response = await Dio().post("https://api.fasfafsa.fun/auth/check",
        options: Options(headers: {
          'Access-Control-Allow-Credentials': true,
          "Cookie": await storage.read(key: "access")
        }));
    print(response);
    if (response.data) {
      return await true;
    }
  }
}
