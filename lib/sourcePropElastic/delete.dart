import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:itservpfeapp/models/SourcePropertiesModel.dart';
import 'package:itservpfeapp/sourcePropElastic/getalldata.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class delete extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteState();
  }
}

Future<SourcePropertiesModel> deletedatas(
    String value, String loginModif, String dateModif) async {
  var Url = "http://165.227.228.41:8080/projetPfe/apisourceproperty/deletesourcespop";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response = await http.delete(
    Url,
    headers: headers,
  );

  return SourcePropertiesModel.fromJson(jsonDecode(response.body));
}

class deleteState extends State<delete> {
  @override
  Widget build(BuildContext context) {
    return getalldata();
  }
}
