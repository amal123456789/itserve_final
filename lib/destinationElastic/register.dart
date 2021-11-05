import 'package:flutter/material.dart';
import 'package:itservpfeapp/models/DataDestinationModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerState();
  }
}

Future<DataDestinationModel> registers(
    String ipAdressDestination,
    String portDestination,
    String descritpionDestination,
    BuildContext context) async {
  var Url = "http://165.227.228.41:8080/projetPfe/apidatadest/ajouterdtdest";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response = await http.post(Url,
      headers: headers,
      body: jsonEncode(<String, String>{
        "ipAdressDestination": ipAdressDestination,
        "portDestination": portDestination,
        "descritpionDestination": descritpionDestination
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

class registerState extends State<register> {
  final minimumPadding = 2.0;

  TextEditingController urlController = TextEditingController();
  TextEditingController sysnameController = TextEditingController();
  TextEditingController syscodeController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();

  DataDestinationModel datasource;
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
                            return 'please enter your ipAdressDestination';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'ipAdressDestination',
                            hintText: 'ipAdressDestination',
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
                            return 'please enter portDestination';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'portDestination',
                            hintText: 'portDestination',
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
                            return 'please enter descritpionDestination';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'descritpionDestination',
                            hintText: 'Enter Your descritpionDestination',
                            labelStyle: textStyle,
                            icon: Icon(Icons.code_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                      )),
                  RaisedButton(
                      child: Text('Submit'),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.amber)),
                      onPressed: () async {
                        String ipAdressDestination = urlController.text;
                        String portDestination = sysnameController.text;
                        String descritpionDestination = syscodeController.text;
                        //String descritpionSource = descriptionController.text;

                        DataDestinationModel datas = await registers(
                            ipAdressDestination,
                            portDestination,
                            descritpionDestination,
                            context);
                        urlController.text = '';
                        sysnameController.text = '';
                        syscodeController.text = '';
                        //descriptionController.text ='';
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
