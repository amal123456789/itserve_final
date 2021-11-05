import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itservpfeapp/models/SourcePropertiesModel.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerState();
  }
}

Future<SourcePropertiesModel> registers(String value, String loginModif,
    String dateModif, BuildContext context) async {
  var Url = "http://165.227.228.41:8080/projetPfe/apisourceproperty/ajoutersourceprop";
  var headers = await AuthenticationHeaderService.createAuthHeader();
  var response = await http.post(Url,
      headers: headers,
      body: jsonEncode(<String, String>{
        "value": value,
        "loginModif": loginModif,
        "dateModif": dateModif
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
  //TextEditingController syscodeController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  TextEditingController datepickController = TextEditingController();
  //DateTime.tryParse(datepickController.text);
  DateTime dateController = new DateTime.now();

//DateFormat syscodeController;
  SourcePropertiesModel datasource;
  String getText() {
    if (datepickController == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateController);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  Future<Null> selectTimePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateController,
      firstDate: DateTime(1940),
      lastDate: DateTime(2250),
    );
    if (picked != null && picked != datepickController) {
      setState(() {
        dateController = picked;
        String text = new DateFormat().add_yMd().format(dateController);
        //print(datasource.dateModif.toString());
      });
    }
  }

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
                            return 'please enter value';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'value',
                            hintText: 'value',
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
                            return 'please enter loginModif';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'loginModif',
                            hintText: 'Enter Your loginModif',
                            labelStyle: textStyle,
                            icon: Icon(Icons.login_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                      )),
/////// daaaaateeee
                  Padding(
                    padding: EdgeInsets.only(
                        top: minimumPadding, bottom: minimumPadding),
                    child: TextFormField(
                      style: textStyle,
                      //readOnly: true,
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
                        //datepickController.text = DateFormat().add_yMd().format(datasource.dateModif);
                        datepickController.text =
                            date.toString().substring(0, 10);
                      },
                    ),
                  ),
                  RaisedButton(
                      child: Text('Submit'),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.amber)),
                      onPressed: () async {
                        String value = urlController.text;
                        String loginModif = sysnameController.text;
                        String dateModif = datepickController.toString();
                        //DateTime dd = new DateFormat().add_yMd().format(datepickController.text);
                        //String descritpionSource = descriptionController.text;

                        SourcePropertiesModel datas = await registers(
                            value, loginModif, dateModif, context);
                        urlController.text = '';
                        sysnameController.text = '';
                        datepickController.text = '';
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
