import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itservpfeapp/destinationElastic/update.dart';
import 'package:itservpfeapp/models/User.dart';
import 'package:itservpfeapp/models/UserModel.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class users extends StatefulWidget {
  users() : super();

  final String title = 'Users';

  @override
  usersState createState() => usersState();
}

class usersState extends State<users> {
  List<User> _alerts;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;
  DateTime dateController = DateTime.now();

  @override
  void initState() {
    super.initState();
    _alerts = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar

    _getUsers();
  }

  ///////////////dat date date
  Future<Null> selectTimePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateController,
      firstDate: DateTime(1940),
      lastDate: DateTime(2250),
    );
    if (picked != null && picked != dateController) {
      setState(() {
        dateController = picked;
        String text = DateFormat().format(DateTime.now());
        //print(datasource.dateModif.toString());
      });
    }
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _getUsers() {
    _showProgress('Loading Users...');
    getAlerts().then((alerts) {
      setState(() {
        _alerts = alerts;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${alerts.length}");
    });
  }

  Future<List<User>> getAlerts() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get('http://165.227.228.41:8080/projetPfe/getusers',
        headers: headers);
    var jsonData = json.decode(data.body);
    List<User> alerts = [];
    for (var e in jsonData) {
      User alert = User();
      alert.id = e["id"];
      alert.username = e["username"];
      alert.email = e["email"];
      alert.role = e["role"] == 'admin' ? Role.admin : Role.user;
      alerts.add(alert);
    }
    return alerts;
  }

    _deleteUser(User user) async {
    final url = Uri.parse('http://165.227.228.41:8080/projetPfe/delete-user');
    var headers = await AuthenticationHeaderService.createAuthHeader();
    final request = http.Request("DELETE", url);
    request.headers.addAll(headers);
    request.body = jsonEncode(<String, dynamic>{
        "id":user.id,
        "username": user.username,
        "email": user.email,
        "role": [user.role.toString().split('.').last],
      });
    final response = await request.send();
    if(response.statusCode==200){
          _showProgress('Deleting User...');

       getAlerts();
    }else{
          // _showProgress('Delete Failed !');

    }
  }

  // PaginatedDataTable _dataTable() {
  //   return PaginatedDataTable(
  //     header: Text('Users'),
  //     rowsPerPage: 8,
  //     columns: [
  //       DataColumn(
  //           label: Text(
  //         'Username',
  //         style: TextStyle(backgroundColor: Colors.blueGrey),
  //       )),
  //       DataColumn(
  //           label: Text('Role',
  //               style: TextStyle(backgroundColor: Colors.blueGrey))),
  //       DataColumn(
  //           label: Text('Email',
  //               style: TextStyle(backgroundColor: Colors.blueGrey))),
  //     ],
  //     source: _DataSource(context, _alerts),
  //   );
  // }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: _alerts.length,
                itemBuilder: (BuildContext ctx, index) {
                  final myCard = _alerts[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                              ),
                              SizedBox(width: 200,),
                              InkWell(child: Icon(Icons.edit),
                              onTap: (){
                                showDialogFunc(context, myCard);
                              },)

                            ],
                          ),
                          SizedBox(height: 25),
                          Text('Username: ${myCard.username}'),
                          Text(
                              'Role: ${myCard.role.toString().split('.').last ?? ''}'),
                          Text('Email: ${myCard.email}'),
                          
                         Padding(
                           padding: const EdgeInsets.only(left: 250),
                           child: InkWell(child: Icon(Icons.delete),
                           onTap: (){
                             _deleteUser(myCard);
                           },
                           ),
                         ),                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, List<UserModel> alerts) {
    _rows = alerts;
  }

  final BuildContext context;
  List<UserModel> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: false,
      cells: [
        DataCell(Text(row.firstName ?? '')),
        DataCell(Text(row.role.toString().split('.').last ?? '')),
        DataCell(Text(row.mail ?? '')),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
showDialogFunc(context, User data) {
  TextStyle textStyle = Theme.of(context).textTheme.subtitle2;
  final minimumPadding = 5.0;
  TextEditingController usernameController = TextEditingController(text: data.username);
  TextEditingController emailController = TextEditingController(text: data.email);
  TextEditingController roleController = TextEditingController(text: data.role.toString().split('.').last ?? '');

  _updateUser(User user) async {
    final url = Uri.parse('http://165.227.228.41:8080/projetPfe/update-user');
    var headers = await AuthenticationHeaderService.createAuthHeader();
    final request = http.Request("PUT", url);
    request.headers.addAll(headers);
    request.body = jsonEncode(<String, dynamic>{
        "id":user.id,
        "username": user.username,
        "email": user.email,
        "role": [user.role.toString().split('.').last],
      });
    final response = await request.send();
    if(response.statusCode==200){
       Navigator.push(context, MaterialPageRoute(builder: (context) => users()));
    }
  }


  return showDialog(
    context: context,
    builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Update Data'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => users()));
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
                        controller: usernameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your User Name';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'User Name',
                            hintText: 'Enter User Name',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: emailController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter email';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: roleController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter role';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Role',
                            hintText: 'Enter Role',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        User emp = new User();
                        emp.id = data.id;
                        emp.username = usernameController.text;
                        emp.email = emailController.text;
                        emp.role = roleController.text == 'admin' ? Role.admin : Role.user;

                        await _updateUser(emp);
                      })
                ]))));
    },
  );
}
