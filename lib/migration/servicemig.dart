import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class servicemig {
  static const migrateDatasource =
      'http://165.227.228.41:8080/projetPfe//apilogsmigration/migrate';
  static const MigrateLogs = 'http://165.227.228.41:8080/projetPfe/getallemployees';
// migrate from 2 source of data
  static Future<String> getMigration() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get('http://165.227.228.41:8080/projetPfe/apilogsmigration/migrate',
        headers: headers);
    // var jsonData = json.decode(data.body);
    // String responseString = data.body;
    if (data.statusCode == 200) {
      return 'data sucessufulley migrated';
    }
    return "data can not be migratetd";
  }
// migrate from source number 1
  static Future<String> getMigrationSOne() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get('http://165.227.228.41:8080/projetPfe/apilogsmigration/migratesourceone',
        headers: headers);
    // var jsonData = json.decode(data.body);
    // String responseString = data.body;
    if (data.statusCode == 200) {
      return 'data sucessufulley migrated';
    }
    return "data can not be migratetd";
  }// migrate from sourcenumber 2
  static Future<String> getMigrationSTwo() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get('http://165.227.228.41:8080/projetPfe/apilogsmigration/migratesourcetwo',
        headers: headers);
    // var jsonData = json.decode(data.body);
    // String responseString = data.body;
    if (data.statusCode == 200) {
      return 'data sucessufulley migrated';
    }
    return "data can not be migratetd";
  }
  static Future<String> getfileforMigration() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get('http://165.227.228.41:8080/projetPfe/apilogsmigration/getfile',
        headers: headers);
    var jsonData = json.encode(data.body);
    String responseString = data.body;
    if (data.statusCode == 200) {
      return 'file sucessufulley getted';
    }
    return "file can not be getted";
  }
// migration from one file 
static Future<String> getfileforMigrationOne() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get('http://165.227.228.41:8080/projetPfe/apilogsmigration/getfileonesource',
        headers: headers);
    var jsonData = json.encode(data.body);
    String responseString = data.body;
    if (data.statusCode == 200) {
      return 'file sucessufulley getted';
    }
    return "file can not be getted";
  }

/* static Future<List<input>> getInputs() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get(
        'http://165.227.228.41:8080/projetPfe//apilogsmigration/gettfile',
        headers: headers);
    var jsonData = json.decode(data.body);

    List<input> employee = [];
    for (var e in jsonData) {
      input employees = new input();
      employees.all = e["all"];
      employee.add(employees);
    }
    return employee;
  }*/

  /*static Future<List<input>> getThefiles() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get('http://165.227.228.41:8080/projetPfe//apilogsmigration/aa',
        headers: headers);
    var jsonData = json.decode(data.body);

    List<input> employee = [];
    for (var e in jsonData) {
      input employees = new input();
      employees.all = e.toString();
      employee.add(employees);
    }
    return employee;
  }*/
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
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
