import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/models/logselasticmodel.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class ServiceelasticLog {
  static const ROOT = 'http://165.227.228.41:8080/projetPfe/apilogs/getalllogs'; 
  
   ///// worked
  static Future<List<LogsModel>> getEmployees() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get('http://165.227.228.41:8080/projetPfe/apilogs/allhitlog',
        headers: headers);

    var jsonData = json.decode(data.body);

    List<LogsModel> employee = [];
    for (var e in jsonData) {
      LogsModel employees = new LogsModel();
      employees.id = e["id"];
      employees.d_log = e["d_log"];
      print(employees.id);
      employees.type = e["type"];
      employees.sens = e["sens"];
      employees.ws = e["ws"];
      employees.methode = e["methode"];
      employees.sys_appelant = e["sys_appelant"];
      employees.c_retour = e["c_retour"];
      employees.operation = e["operation"];
      employees.txt_LOG = e["txt_log"];
      employees.request = e["request"];
      employees.response = e["response"];
      // employees.iD_DEM = e["iD_DEM"];
      // employees.bPM_UID = e["bPM_UID"];
      employees.ref_dem_src = e["ref_dem_src"];
      employees.tags = e["tags"];
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
      String tags,
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
          "tags": tags,
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
        style: Theme.of(context).textTheme.title,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
/// http://165.227.228.41:8080/projetPfe/apilogs/allhitlog
/// http://165.227.228.41:8080/projetPfe/http://165.227.228.41:8080/projetPfe/apilogs/addlog
/// http://165.227.228.41:8080/projetPfe/apilogs/updatelog
/// http://165.227.228.41:8080/projetPfe/apilogs/deletelog