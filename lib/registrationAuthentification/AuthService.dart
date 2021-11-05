import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:itservpfeapp/registrationAuthentification/ApiPath.dart';
import 'package:itservpfeapp/registrationAuthentification/SessionStorageService.dart';

class AuthService {
  static AuthService service;

  static Future<AuthService> getInstance() async {
    if (service == null) {
      service = AuthService();
    }
    return service;
  }

  Future<int> authenticateUser(String username, String password) async {
    var res =
        await http.post('http://165.227.228.41:8080/projetPfe/api/auth/signin',
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode(<String, String>{
              "username": username,
              "password": password,
            }));

    if (res.statusCode == 200) {
      var sessionStorageService = await SessionStorageService.getInstance();
      sessionStorageService.saveAccessToken(res.body);
      return res.statusCode;
    } else {
      debugPrint(
          "An Error Occurred during loggin in. Status code: ${res.statusCode} , body: ${res.body.toString()}");
      return res.statusCode;
    }
  }
}
