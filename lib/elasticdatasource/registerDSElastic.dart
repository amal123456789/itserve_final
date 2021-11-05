import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itservpfeapp/models/DatasourceModel.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class registerDSElastic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerDSElasticState();
  }
}

Future<DatasourceModel> registerDSElastics(String schemaUrl, String systemName,
    String systemCode, String descritpionSource, BuildContext context) async {
  var Url = "http://165.227.228.41:8080/projetPfe/apidatasource/ajouterdtsource";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response = await http.post(Url,
      headers: headers,
      body: jsonEncode(<String, String>{
        "schemaUrl": schemaUrl,
        "systemName": systemName,
        "systemCode": systemCode,
        "descritpionSource": descritpionSource
      }));

  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(title: 'Backend Response', content: response.body);
      },
    );
  }
}

class registerDSElasticState extends State<registerDSElastic> {
  final minimumPadding = 2.0;

  TextEditingController urlController = TextEditingController();
  TextEditingController sysnameController = TextEditingController();
  TextEditingController syscodeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DatasourceModel datasource;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 700,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(minimumPadding * 2),
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: urlController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your schema url';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'schema url',
                            hintText: 'Enter schema url',
                            labelStyle: textStyle,
                            icon: Icon(Icons.link),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: sysnameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'system name',
                            hintText: 'Enter Your system name',
                            labelStyle: textStyle,
                            icon: Icon(Icons.emoji_symbols_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: syscodeController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your system ncode';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'system code',
                            hintText: 'Enter Your system code',
                            labelStyle: textStyle,
                            icon: Icon(Icons.code_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        //maxLines: 7,
                        style: textStyle,
                        controller: descriptionController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your description';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'description',
                            hintText: 'Enter Your description',
                            labelStyle: textStyle,
                            icon: Icon(Icons.edit_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                      )),
                  RaisedButton(
                      child: Text('Submit'),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.amber)),
                      onPressed: () async {
                        String schemaUrl = urlController.text;
                        String systemName = sysnameController.text;
                        String systemCode = syscodeController.text;
                        String descritpionSource = descriptionController.text;

                        DatasourceModel datas = await registerDSElastics(
                            schemaUrl,
                            systemName,
                            systemCode,
                            descritpionSource,
                            context);
                        urlController.text = '';
                        sysnameController.text = '';
                        syscodeController.text = '';
                        descriptionController.text = '';
                        setState(() {
                          datasource = datas;
                        });
                      }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
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
