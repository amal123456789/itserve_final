import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itservpfeapp/models/reponses.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/registrationAuthentification/SessionStorageService.dart';

class adminpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return adminpageState();
  }
}

Future<Map<String, String>> createAuthHeader() async {
  var sessionStorageService = await SessionStorageService.getInstance();
  var accessToken = sessionStorageService.retriveAccessToken();
  if (accessToken == null) {
    debugPrint("No access token in local storage found. Please log in.");
    return null;
  }
  return {"Authorization": "Bearer $accessToken"};
}

class adminpageState extends State<adminpage> {
  var datas = List<JwtResponse>.generate(200, (index) => null);

  Future<String> getDataSource() async {
    var data = await http.get(
      'http://165.227.228.41:8080/projetPfe/api/test/user',
      headers: <String, String>{"Content-Type": "application/json"},
    );

    var jsonData = json.decode(data.body);
    if (data.statusCode == 200) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(title: 'Backend Response', content: data.body);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;

    return Container(
      height: 350,
      width: 700,
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      actions: this.actions,
      content: Container(
        child: Text(
          this.content,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
