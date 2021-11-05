import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/datasource/getDataSource.dart';
import 'package:itservpfeapp/elasticdatasource/getDSElastic.dart';
import 'package:itservpfeapp/models/DatasourceModel.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class deleteDSe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteDSeState();
  }
}

Future<DatasourceModel> deletedatas(String schemaUrl, String systemName,
    String systemCode, String descripion) async {
  var Url = "http://165.227.228.41:8080/projetPfe/apidatasource/deleteds";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response = await http.delete(
    Url,
    headers: headers,
  );

  return DatasourceModel.fromJson(jsonDecode(response.body));
}

class deleteDSeState extends State<deleteDSe> {
  @override
  Widget build(BuildContext context) {
    return getDSElastic();
  }
}
