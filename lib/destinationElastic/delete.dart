import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/destinationElastic/getalldata.dart';
import 'package:itservpfeapp/models/DataDestinationModel.dart';
import 'dart:convert';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class delete extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteState();
  }
}

Future<DataDestinationModel> deletedatas(String ipAdressDestination,
    String portDestination, String descritpionDestination) async {
  var Url = "http://165.227.228.41:8080/projetPfe/apidatadest/deleteddatadest";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response = await http.delete(
    Url,
    headers: headers,
  );

  return DataDestinationModel.fromJson(jsonDecode(response.body));
}

class deleteState extends State<delete> {
  @override
  Widget build(BuildContext context) {
    return getalldata();
  }
}
