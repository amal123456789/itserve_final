import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/datasource/datasourceDrawer.dart';
import 'package:itservpfeapp/models/DatasourceModel.dart';
import 'package:itservpfeapp/models/PropertiesModel.dart';
import 'package:itservpfeapp/models/SourcePropertiesModel.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class updateDatasource extends StatefulWidget {
  DatasourceModel datasource;
  SourcePropertiesModel sourcePropertiesModel;
  PropertiesModel propertiesModel;

  @override
  State<StatefulWidget> createState() {
    return updateDtasourceState(
        datasource, sourcePropertiesModel, propertiesModel);
  }

  updateDatasource(
      this.datasource, this.sourcePropertiesModel, this.propertiesModel);
}

Future<DatasourceModel> updateDatasources(
    DatasourceModel datasource, BuildContext context) async {
  var Url = "http://165.227.228.41:8080/projetPfe/updatedatasource";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response =
      await http.put(Url, headers: headers, body: jsonEncode(datasource));
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

Future<SourcePropertiesModel> updateSourceProperties(
    SourcePropertiesModel sourceProperties, BuildContext context) async {
  if (sourceProperties.idsourceprop != null) {
    var Url = "http://165.227.228.41:8080/projetPfe/updatesourceproperties";
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var response = await http.put(Url,
        headers: headers, body: jsonEncode(sourceProperties.toJson()));
    if (response.statusCode == 200) {
      print("SourceProperties updated");
    }
  } else {
    print("No SourceProperties found");
  }
}

Future<PropertiesModel> updateProperties(
    PropertiesModel properties, BuildContext context) async {
  if (properties.idProperty != null) {
    var Url = "http://165.227.228.41:8080/projetPfe/updateproperties";
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var response =
        await http.put(Url, headers: headers, body: jsonEncode(properties));
    if (response.statusCode == 200) {
      print("Properties Updated");
    }
  } else {
    print("No Properties Found");
  }
}

class updateDtasourceState extends State<updateDatasource> {
  DatasourceModel datsource;
  SourcePropertiesModel sourcePropertiesModel;
  PropertiesModel propertiesModel;
  final minimumPadding = 5.0;
  TextEditingController dataNumber;
  bool _isEnabled = false;
  TextEditingController urlController;
  TextEditingController sysnameController;
  TextEditingController syscodeController;
  TextEditingController descriptionController;

  TextEditingController valueController;
  TextEditingController loginModifController;
  TextEditingController dateModifController;

  TextEditingController codePropController;
  TextEditingController propNameController;
  TextEditingController classeController;

  Future<List<DatasourceModel>> datsources;

  updateDtasourceState(
      this.datsource, this.sourcePropertiesModel, this.propertiesModel) {
    dataNumber =
        TextEditingController(text: this.datsource.idSourceSequence.toString());
    urlController = TextEditingController(text: this.datsource.schemaUrl);
    sysnameController = TextEditingController(text: this.datsource.systemName);
    syscodeController = TextEditingController(text: this.datsource.systemCode);
    descriptionController =
        TextEditingController(text: this.datsource.descritpionSource);

    valueController =
        TextEditingController(text: this.sourcePropertiesModel.value);
    loginModifController =
        TextEditingController(text: this.sourcePropertiesModel.loginModif);
    dateModifController =
        TextEditingController(text: this.sourcePropertiesModel.datemodif);

    codePropController =
        TextEditingController(text: this.propertiesModel.codeProp);
    propNameController =
        TextEditingController(text: this.propertiesModel.propName);
    classeController = TextEditingController(text: this.propertiesModel.classe);
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
                  MaterialPageRoute(builder: (context) => datasourceDrawer()));
            },
          ),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(minimumPadding * 2),
                child: ListView(children: <Widget>[
                  Text("Data Source",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontStyle: FontStyle.normal)),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding + 2, bottom: minimumPadding),
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
                          top: minimumPadding, bottom: minimumPadding + 2),
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
                  Text("Source Properties",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontStyle: FontStyle.normal)),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding + 2, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: valueController,
                        decoration: InputDecoration(
                            labelText: 'value',
                            hintText: 'Enter value ',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: loginModifController,
                        decoration: InputDecoration(
                            labelText: 'loginModif',
                            hintText: 'Enter loginModif ',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding + 2),
                      child: TextFormField(
                        style: textStyle,
                        controller: dateModifController,
                        enabled: _isEnabled,
                        decoration: InputDecoration(
                            labelText: 'dateModif',
                            hintText: 'Enter dateModif ',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Text("Properties",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontStyle: FontStyle.normal)),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding + 2, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: codePropController,
                        decoration: InputDecoration(
                            labelText: 'codeProp',
                            hintText: 'Enter codeProp ',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: propNameController,
                        decoration: InputDecoration(
                            labelText: 'propName',
                            hintText: 'Enter propName ',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: classeController,
                        decoration: InputDecoration(
                            labelText: 'classe',
                            hintText: 'Enter classe ',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        DatasourceModel emp = new DatasourceModel();
                        emp.idSourceSequence = datsource.idSourceSequence;
                        emp.schemaUrl = urlController.text;
                        emp.systemName = sysnameController.text;
                        emp.systemCode = syscodeController.text;
                        emp.descritpionSource = descriptionController.text;
                        emp.idSourceprop = this.datsource.idSourceprop;

                        SourcePropertiesModel spm = new SourcePropertiesModel();
                        spm.dateModif = new DateTime.now();
                        spm.loginModif = loginModifController.text;
                        spm.value = valueController.text;
                        spm.idSourceprop =
                            this.sourcePropertiesModel.idSourceprop;
                        spm.properties = this.propertiesModel.idProperty;

                        PropertiesModel pm = new PropertiesModel();
                        pm.classe = classeController.text;
                        pm.codeProp = codePropController.text;
                        pm.propName = propNameController.text;
                        pm.idProperty = this.propertiesModel.idProperty;

                        PropertiesModel pm1 =
                            await updateProperties(pm, context);
                        SourcePropertiesModel spm1 =
                            await updateSourceProperties(spm, context);
                        DatasourceModel datas =
                            await updateDatasources(emp, context);
                        setState(() {
                          datsource = datas;
                          sourcePropertiesModel = spm1;
                          propertiesModel = pm1;
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
