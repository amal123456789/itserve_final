import 'dart:convert';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/datasource/getDataSource.dart';
import 'package:itservpfeapp/models/DatasourceModel.dart';

class deletedatasource extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deletedatasourceState();
  }
}

Future<DatasourceModel> deletedatas(String schemaUrl, String systemName,
    String systemCode, String descripion) async {
  var Url = "http://165.227.228.41:8080/projetPfe/deletedatasource";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response = await http.delete(
    Url,
    headers: headers,
  );

  return DatasourceModel.fromJson(jsonDecode(response.body));
}

class deletedatasourceState extends State<deletedatasource> {
  @override
  Widget build(BuildContext context) {
    return getDataSource();
  }
}
