import 'package:itservpfeapp/models/PropertiesModel.dart';
import 'package:itservpfeapp/property/getall.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class delete extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteState();
  }
}

Future<PropertiesModel> deletedatas(String schemaUrl, String systemName,
    String systemCode, String descripion) async {
  var Url = "http://165.227.228.41:8080/projetPfe/deleteproperties";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response = await http.delete(
    Url,
    headers: headers,
  );

  return PropertiesModel.fromJson(jsonDecode(response.body));
}

class deleteState extends State<delete> {
  @override
  Widget build(BuildContext context) {
    return getalldata();
  }
}
