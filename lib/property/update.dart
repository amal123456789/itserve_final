import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/models/PropertiesModel.dart';
import 'package:itservpfeapp/property/drawer.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class update extends StatefulWidget {
  PropertiesModel datasource;

  @override
  State<StatefulWidget> createState() {
    return updateState(datasource);
  }

  update(this.datasource);
}

Future<PropertiesModel> updates(
    PropertiesModel datasource, BuildContext context) async {
  var Url = "http://165.227.228.41:8080/projetPfe/updateproperties";
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

class updateState extends State<update> {
  PropertiesModel datsource;
  final minimumPadding = 5.0;
  TextEditingController dataNumber;
  bool _isEnabled = false;
  TextEditingController urlController;
  TextEditingController sysnameController;
  TextEditingController syscodeController;
  //TextEditingController descriptionController;

  Future<List<PropertiesModel>> datsources;

  updateState(this.datsource) {
    dataNumber =
        TextEditingController(text: this.datsource.idProperty.toString());
    urlController = TextEditingController(text: this.datsource.propName);
    sysnameController = TextEditingController(text: this.datsource.codeProp);
    syscodeController = TextEditingController(text: this.datsource.classe);
    //descriptionController = TextEditingController(text : this.datsource.descritpionSource);
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => drawer()));
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
                            return 'please enter propname';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'propname',
                            hintText: 'Enter propname',
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
                            return 'please enter prop code';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'prop code',
                            hintText: 'Enter prop code',
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
                            return 'please enter classe';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'classe',
                            hintText: 'Enter Your classe',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String propName = urlController.text;
                        String codeProp = syscodeController.text;

                        String classe = sysnameController.text;
                        //String description = descriptionController.text;

                        PropertiesModel emp = new PropertiesModel();
                        emp.idProperty = datsource.idProperty;
                        emp.propName = urlController.text;
                        emp.codeProp = sysnameController.text;
                        emp.classe = syscodeController.text;
                        //emp.descritpionSource = descriptionController.text;

                        PropertiesModel datas = await updates(emp, context);
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
