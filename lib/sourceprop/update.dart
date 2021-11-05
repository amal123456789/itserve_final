import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itservpfeapp/models/SourcePropertiesModel.dart';
import 'package:itservpfeapp/sourceprop/drawer.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class update extends StatefulWidget {
  SourcePropertiesModel datasource;

  @override
  State<StatefulWidget> createState() {
    return updateState(datasource);
  }

  update(this.datasource);
}

Future<SourcePropertiesModel> updates(
    SourcePropertiesModel datasource, BuildContext context) async {
  var Url = "http://165.227.228.41:8080/projetPfe/updatesourceproperties";
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
  SourcePropertiesModel datsource;
  final minimumPadding = 5.0;
  TextEditingController dataNumber;
  bool _isEnabled = false;
  TextEditingController urlController;
  TextEditingController sysnameController;
  DateFormat syscodeController;
  TextEditingController datepickController;

  //TextEditingController descriptionController;

  Future<List<SourcePropertiesModel>> datsources;

  updateState(this.datsource) {
    dataNumber =
        TextEditingController(text: this.datsource.idSourceprop.toString());
    urlController = TextEditingController(text: this.datsource.value);
    sysnameController = TextEditingController(text: this.datsource.loginModif);
    syscodeController = DateFormat(this.datsource.dateModif.toString());
    //DateTime selectedDate = DateTime.now();
    datepickController =
        TextEditingController(text: this.datsource.dateModif.toString());
    //descriptionController = TextEditingController(text : this.datsource.descritpionSource);
  }
  /*Future<Null> selectTimePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
       initialDate: datsource.dateModif, 
      firstDate: DateTime(1940),
       lastDate: DateTime(2250),
       
       );
       if (picked != null && picked != datsource.dateModif){
         setState(() {
           datsource.dateModif =picked;
           print(datsource.dateModif.toString());
         });

       }

  }*/

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
                  context, MaterialPageRoute(builder: (context) => drawerS()));
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
                      readOnly: true,
                      controller: datepickController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter Date Modif';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Date modification',
                          hintText: 'Pick your Date',
                          icon: Icon(Icons.date_range_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        datepickController.text =
                            date.toString().substring(0, 10);
                      },
                    ),
                  ),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String value = urlController.text;
                        String loginModif = sysnameController.text;

                        String dateModif = datepickController.text;
                        //String description = descriptionController.text;

                        SourcePropertiesModel emp = new SourcePropertiesModel();
                        emp.idSourceprop = datsource.idSourceprop;
                        emp.value = urlController.text;
                        emp.loginModif = sysnameController.text;
                        emp.dateModif = datepickController.text as DateTime;
                        //emp.descritpionSource = descriptionController.text;

                        SourcePropertiesModel datas =
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
