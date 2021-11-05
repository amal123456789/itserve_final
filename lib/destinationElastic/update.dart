import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/destinationElastic/destinationElasticdrawer.dart';
import 'package:itservpfeapp/models/DataDestinationModel.dart';

import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class update extends StatefulWidget {
  DataDestinationModel datasource;

  @override
  State<StatefulWidget> createState() {
    return updateState(datasource);
  }

  update(this.datasource);
}

Future<DataDestinationModel> updates(
    DataDestinationModel datasource, BuildContext context) async {
  var Url = "http://165.227.228.41:8080/projetPfe/apidatadest/updateddtdest";
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
  DataDestinationModel datsource;
  final minimumPadding = 5.0;
  TextEditingController dataNumber;
  bool _isEnabled = false;
  TextEditingController urlController;
  TextEditingController sysnameController;
  TextEditingController syscodeController;
  //TextEditingController descriptionController;

  Future<List<DataDestinationModel>> datsources;

  updateState(this.datsource) {
    dataNumber =
        TextEditingController(text: this.datsource.idDestination.toString());
    urlController =
        TextEditingController(text: this.datsource.ipAdressDestination);
    sysnameController =
        TextEditingController(text: this.datsource.portDestination);
    syscodeController =
        TextEditingController(text: this.datsource.descritpionDestination);
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
                  context,
                  MaterialPageRoute(
                      builder: (context) => destinationElasticdrawer()));
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
                            labelText: ' ID',
                            hintText: 'Enter ID',
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
                            return 'please enter ipAdressDestination';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'ipAdressDestination',
                            hintText: 'Enter ipAdressDestination',
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
                            labelText: 'prop portDestination',
                            hintText: 'Enter portDestination ',
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
                            return 'please enter descritpionDestination';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'descritpionDestination',
                            hintText: 'Enter Your descritpionDestination',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String ipAdressDestination = urlController.text;
                        String portDestination = syscodeController.text;

                        String descritpionDestination = sysnameController.text;
                        //String description = descriptionController.text;

                        DataDestinationModel emp = new DataDestinationModel();
                        emp.idDestination = datsource.idDestination;
                        emp.ipAdressDestination = urlController.text;
                        emp.portDestination = sysnameController.text;
                        emp.descritpionDestination = syscodeController.text;
                        //emp.descritpionSource = descriptionController.text;

                        DataDestinationModel datas =
                            await updates(emp, context);
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
