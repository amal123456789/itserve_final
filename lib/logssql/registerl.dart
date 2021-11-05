import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/models/LogsModel.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class ServicesLogelastic {
  static const ROOT = 'http://165.227.228.41:8080/projetPfe/getalllogs';
  static const _CREATE_TABLE_ACTION =
      'http://165.227.228.41:8080/projetPfe/getallemployees';
  static const _GET_ALL_ACTION =
      'http://165.227.228.41:8080/projetPfe/getallemployees';
  static const _ADD_EMP_ACTION = 'http://165.227.228.41:8080/projetPfe/addlogs';
  static const _UPDATE_EMP_ACTION =
      'http://165.227.228.41:8080/projetPfe/updatelogs';
  static const _DELETE_EMP_ACTION =
      'http://165.227.228.41:8080/projetPfe/deletelogs';

  /*static Future<List<Employee>> getEmployees() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(_GET_ALL_ACTION, body: map);
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Employee> list = parseResponse(response.body);
        return list;
      } else {
        return List<Employee>();
      }
    } catch (e) {
      return List<Employee>(); // return an empty list on exception/error
    }
  }*/ ///// worked
  static Future<List<LogsModel>> getEmployees() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get(
        'http://165.227.228.41:8080/projetPfe/apilogs/allhitlog',
        headers: headers);
    var jsonData = json.decode(data.body);

    List<LogsModel> employee = [];
    for (var e in jsonData) {
      LogsModel employees = new LogsModel();
      employees.id = e["id"];
      employees.d_LOG = e["d_LOG"];
      employees.tYPE = e["tYPE"];
      employees.sENS = e["sENS"];
      employees.wS = e["wS"];
      employees.mETHODE = e["mETHODE"];
      employees.sYS_APPELANT = e["sYS_APPELANT"];
      employees.c_RETOUR = e["c_RETOUR"];
      employees.oPERATION = e["oPERATION"];
      employees.tXT_LOG = e["tXT_LOG"];
      employees.rEQUEST = e["rEQUEST"];
      employees.rESPONSE = e["rESPONSE"];
      // employees.iD_DEM = e["iD_DEM"];
      // employees.bPM_UID = e["bPM_UID"];
      employees.rEF_DEM_SRC = e["rEF_DEM_SRC"];
      employee.add(employees);
    }
    return employee;
  }

  static List<LogsModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<LogsModel>((json) => LogsModel.fromJson(json)).toList();
  }

  // Method to add employee to the database...
  //worked
  static Future<String> addEmployee(
      String d_LOG,
      String tYPE,
      String sENS,
      String wS,
      String mETHODE,
      String sYS_APPELANT,
      String c_RETOUR,
      String oPERATION,
      String tXT_LOG,
      String rEQUEST,
      String rESPONSE,
      /*int iD_DEM,String bPM_UID,*/ String rEF_DEM_SRC,
      BuildContext context) async {
    var Url = "http://165.227.228.41:8080/projetPfe/apilogs/addlog";
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var response = await http.post(Url,
        headers: headers,
        body: jsonEncode(<String, String>{
          "d_LOG": d_LOG.toString(),
          "tYPE": tYPE,
          "sENS": sENS,
          "wS": wS,
          "mETHODE": mETHODE,
          "sYS_APPELANT": sYS_APPELANT,
          "c_RETOUR": c_RETOUR,
          "oPERATION": oPERATION,
          "tXT_LOG": tXT_LOG,
          "rEQUEST": rEQUEST,
          "rESPONSE": rESPONSE,
          // "iD_DEM" : iD_DEM.toString(),
          //"bPM_UID" : bPM_UID,
          "rEF_DEM_SRC": rEF_DEM_SRC,
        }));

    String responseString = response.body;
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
              title: 'Backend Response', content: response.body);
        },
      );
    }
  }

  // Method to update an Employee in Database...
  ////// worked nicely
  static Future<LogsModel> updateEmployee(
      LogsModel employee, BuildContext context) async {
    var Url = "http://165.227.228.41:8080/projetPfe/apilogs/updatelog";
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var response =
        await http.put(Url, headers: headers, body: jsonEncode(employee));
    String responseString = response.body;

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return MyAlertDialog(
                title: 'Backend Response', content: response.body);
          });
    }
  }

  // Method to Delete an Employee from Database...
  /* static Future<String> deleteEmployee(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['id'] = id;
      final response = await http.post(ROOT, body: map);
      print('deleteEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }*/

////test test
//worked
  static Future<LogsModel> deleteEmployees(LogsModel employee) async {
    var Url = "http://165.227.228.41:8080/projetPfe/apilogs/deletelog";
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var response = await http.delete(
      Url,
      headers: headers,
    );
    return LogsModel.fromJson(jsonDecode(response.body));
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
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
/// http://165.227.228.41:8080/projetPfe/apilogs/allhitlog
/// http://165.227.228.41:8080/projetPfe/apilogs/addlog
/// http://165.227.228.41:8080/projetPfe/apilogs/updatelog
/// http://165.227.228.41:8080/projetPfe/apilogs/deletelog