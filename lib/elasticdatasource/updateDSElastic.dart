import 'package:flutter/material.dart';
import 'package:itservpfeapp/elasticdatasource/dataDrawerE.dart';
import 'package:itservpfeapp/models/DatasourceModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class updateDSElastic extends StatefulWidget {
  DatasourceModel datasource;

  @override
  State<StatefulWidget> createState() {
    return updateDSElasticState(datasource);
  }

  updateDSElastic(this.datasource);
}

Future<DatasourceModel> updateDatasources(
    DatasourceModel datasource, BuildContext context) async {
  var Url = "http://165.227.228.41:8080/projetPfe/apidatasource/updatedatasourceelastic";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response =
      await http.put(Url, headers: headers, body: jsonEncode(datasource));
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

class updateDSElasticState extends State<updateDSElastic> {
  DatasourceModel datsource;
  final minimumPadding = 5.0;
  TextEditingController dataNumber;
  bool _isEnabled = false;
  TextEditingController urlController;
  TextEditingController sysnameController;
  TextEditingController syscodeController;
  TextEditingController descriptionController;

  Future<List<DatasourceModel>> datsources;

  updateDSElasticState(this.datsource) {
    dataNumber =
        TextEditingController(text: this.datsource.idSourceSequence.toString());
    urlController = TextEditingController(text: this.datsource.schemaUrl);
    sysnameController = TextEditingController(text: this.datsource.systemName);
    syscodeController = TextEditingController(text: this.datsource.systemCode);
    descriptionController =
        TextEditingController(text: this.datsource.descritpionSource);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Data'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => dataDrawerE()));
            },
          ),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(minimumPadding * 2),
                child: ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: dataNumber,
                        enabled: _isEnabled,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your ID';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Sequence ID',
                            hintText: 'Enter squence ID',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: urlController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter schema url';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Url schema',
                            hintText: 'Enter Schema url',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: sysnameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter system name';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'sYstem name',
                            hintText: 'Enter System name',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: syscodeController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter system code';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'sYstem code',
                            hintText: 'Enter Your System code',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: descriptionController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter description';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter description ',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String schemaUrl = urlController.text;
                        String syscode = syscodeController.text;

                        String sysname = sysnameController.text;
                        String description = descriptionController.text;

                        DatasourceModel emp = new DatasourceModel();
                        emp.idSourceSequence = datsource.idSourceSequence;
                        emp.schemaUrl = urlController.text;
                        emp.systemName = sysnameController.text;
                        emp.systemCode = syscodeController.text;
                        emp.descritpionSource = descriptionController.text;

                        DatasourceModel datas =
                            await updateDatasources(emp, context);
                        setState(() {
                          datsource = datas;
                        });
                      })
                ]))));
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
