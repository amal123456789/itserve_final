import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itservpfeapp/logssql/registerl.dart';
import 'package:itservpfeapp/logssql/servicesLogsql.dart';
import 'package:itservpfeapp/models/Employee.dart';

//import 'package:itservpfeapp/models/Employee.dart';
import 'package:itservpfeapp/models/LogsModel.dart';
//import 'package:itservpfeapp/testing/Services.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class imlementationLogelastic extends StatefulWidget {
  //
  imlementationLogelastic() : super();

  final String title = 'Logs Management';

  @override
  imlementationLogelasticState createState() => imlementationLogelasticState();
}

class imlementationLogelasticState extends State<imlementationLogelastic> {
  List<LogsModel> _employees;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  //TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  //TextEditingController _lastNameController;
  //TextEditingController employeeNumber;
  TextEditingController idNumber;
  TextEditingController _d_LOGController;
  TextEditingController _tYPEController;
  TextEditingController _sENSController;
  TextEditingController _wSController;
  TextEditingController _mETHODEController;
  TextEditingController _sYS_APPELANTController;
  TextEditingController _c_RETOURController;
  TextEditingController _oPERATIONController;
  TextEditingController _tXT_LOGController;
  TextEditingController _rEQUESTController;
  TextEditingController _rESPONSEController;
  //TextEditingController _iD_DEMController;
  //TextEditingController _bPM_UIDController;
  TextEditingController _rEF_DEM_SRCController;

  DateTime dateController = DateTime.now();
  LogsModel _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    /*_firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    employeeNumber = TextEditingController();*/
    //employeeNumber =TextEditingController(text: _selectedEmployee.id.toString());
    _d_LOGController = TextEditingController();
    _tYPEController = TextEditingController();
    _sENSController = TextEditingController();
    _wSController = TextEditingController();
    _mETHODEController = TextEditingController();
    _sYS_APPELANTController = TextEditingController();
    _c_RETOURController = TextEditingController();
    _oPERATIONController = TextEditingController();
    _tXT_LOGController = TextEditingController();
    _rEQUESTController = TextEditingController();
    _rESPONSEController = TextEditingController();
    // _iD_DEMController = TextEditingController();
    // _bPM_UIDController = TextEditingController();
    _rEF_DEM_SRCController = TextEditingController();

    idNumber = TextEditingController();

    _getEmployees();
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

  /*_createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }*/

  // Now lets add an Employee
  _addEmployee() {
    if (_d_LOGController.text.isEmpty ||
        _tYPEController.text.isEmpty ||
        _sENSController.text.isEmpty ||
        _wSController.text.isEmpty ||
        _mETHODEController.text.isEmpty ||
        _sYS_APPELANTController.text.isEmpty ||
        _c_RETOURController.text.isEmpty ||
        _oPERATIONController.text.isEmpty ||
        _tXT_LOGController.text.isEmpty ||
        _rEQUESTController.text.isEmpty ||
        _rESPONSEController.text
            .isEmpty || /* _iD_DEMController.text.isEmpty || _bPM_UIDController.text.isEmpty ||*/ _rEF_DEM_SRCController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Employee...');
    ServicesLogelastic.addEmployee(
            _d_LOGController.text,
            _tYPEController.text,
            _sENSController.text,
            _wSController.text,
            _mETHODEController.text,
            _sYS_APPELANTController.text,
            _c_RETOURController.text,
            _oPERATIONController.text,
            _tXT_LOGController.text,
            _rEQUESTController.text,
            _rESPONSEController.text,
            /*int.parse(_iD_DEMController.text),
    _bPM_UIDController.text*/
            _rEF_DEM_SRCController.text,
            context)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getEmployees() {
    _showProgress('Loading Employees...');
    ServicesLogelastic.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${employees.length}");
    });
  }

  _updateEmployee(LogsModel employee, BuildContext context) {
    setState(() {
      //employeeNumber = TextEditingController(text: this._selectedEmployee.id.toString());
      //_firstNameController = TextEditingController(text: this._selectedEmployee.firstName);
      // _lastNameController = TextEditingController(text: this._selectedEmployee.lastName);
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    ServicesLogelastic.updateEmployee(employee, context).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteEmployee(LogsModel employee) async {
    final url = Uri.parse('http://165.227.228.41:8080/projetPfe/apilogs/deletelog');
    var headers = await AuthenticationHeaderService.createAuthHeader();
    final request = http.Request("DELETE", url);
    request.headers.addAll(headers);
    request.body = jsonEncode(employee);
    final response = await request.send();
    _showProgress('Deleting Employee...');
    ServicesLogelastic.deleteEmployees(employee).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    //_d_LOGController.text = '';
    _tYPEController.text = '';
    _sENSController.text = '';
    _wSController.text = '';
    _mETHODEController.text = '';
    _sYS_APPELANTController.text = '';
    _c_RETOURController.text = '';
    _oPERATIONController.text = '';
    _tXT_LOGController.text = '';
    _rEQUESTController.text = '';
    _rESPONSEController.text = '';
    //_iD_DEMController.text = '';
    //_bPM_UIDController.text = '';
    _rEF_DEM_SRCController.text = '';
  }

  _showValues(LogsModel employee) {
    idNumber.text = employee.id.toString();
    //_d_LOGController.text = employee.d_LOG.toString();
    _tYPEController.text = employee.tYPE;
    _sENSController.text = employee.sENS;
    _wSController.text = employee.wS;
    _mETHODEController.text = employee.sYS_APPELANT;
    _sYS_APPELANTController.text = employee.c_RETOUR;
    _c_RETOURController.text = employee.oPERATION;
    _oPERATIONController.text = employee.oPERATION;
    _tXT_LOGController.text = employee.tXT_LOG;
    _rEQUESTController.text = employee.rEQUEST;
    _rESPONSEController.text = employee.rESPONSE;
    //_iD_DEMController.text = employee.iD_DEM.toString();
    //_bPM_UIDController.text =employee.bPM_UID;
    _rEF_DEM_SRCController.text = employee.rEF_DEM_SRC;
    //dateController = employee.d_LOG;
  }


  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID' ?? 'default value'),
            ),
            DataColumn(
              label: Text('d_LOG' ?? 'default value'),
            ),
            DataColumn(
              label: Text('sENS' ?? 'default value'),
            ),
            DataColumn(
              label: Text('wS' ?? 'default value'),
            ),
            DataColumn(
              label: Text('mETHODE' ?? 'default value'),
            ),
            DataColumn(
              label: Text('sYS_APPELANT' ?? 'default value'),
            ),
            DataColumn(
              label: Text('c_RETOUR' ?? 'default value'),
            ),
            DataColumn(
              label: Text('oPERATION' ?? 'default value'),
            ),
            DataColumn(
              label: Text('tXT_LOG' ?? 'default value'),
            ),
            DataColumn(
              label: Text('rEQUEST' ?? 'default value'),
            ),
            DataColumn(
              label: Text('rESPONSE' ?? 'default value'),
            ),
            /*DataColumn(
              label: Text('ID_DEM'  ?? 'default value'),
            ),
            DataColumn(
              label: Text('BPM_UID'  ?? 'default value'),
            ),*/
            DataColumn(
              label: Text('rEF_DEM_SRC' ?? 'default value'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _employees
              .map(
                (employee) => DataRow(cells: [
                  DataCell(
                    Text(employee.id.toString() ?? 'default value'),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.d_LOG.toString() ?? 'default value',
                    ),
                    onTap: () {
                      selectTimePicker(context);
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.tYPE ?? 'default value',
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(employee.sENS ?? 'default value'),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.wS ?? 'default value',
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.mETHODE ?? 'default value',
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.sYS_APPELANT ?? 'default value',
                    ),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.c_RETOUR ?? 'default value',
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.oPERATION ?? 'default value',
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.tXT_LOG ?? 'default value',
                    ),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.rEQUEST ?? 'default value',
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  /* DataCell(
                    Text(
                      employee.iD_DEM.toString()  ?? 'default value',
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.bPM_UID  ?? 'default value',
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),*/
                  DataCell(
                    Text(
                      employee.rEF_DEM_SRC ?? 'default value',
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteEmployee(employee);
                    },
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //_createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 355,
              width: 750,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 350,
                    width: 375,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                              controller: _d_LOGController ?? 'default value',
                              decoration: InputDecoration.collapsed(
                                hintText: 'd_LOG',
                              ),
                              onTap: () async {
                                selectTimePicker(context);
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _tYPEController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'tYPE',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _sENSController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'sENS',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _wSController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'wS',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _mETHODEController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'mETHODE',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller:
                                _sYS_APPELANTController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'sYS_APPELANT',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 350,
                    width: 375,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _c_RETOURController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'c_RETOUR',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _oPERATIONController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'oPERATION',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _tXT_LOGController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'tXT_LOG',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _rEQUESTController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'rEQUEST',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _rESPONSEController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'rESPONSE',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller:
                                _rEF_DEM_SRCController ?? 'default value',
                            decoration: InputDecoration.collapsed(
                              hintText: 'rEF_DEM_SRC',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _iD_DEMController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Idem ',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _bPM_UIDController,
                decoration: InputDecoration.collapsed(
                  hintText: 'bpm',
                ),
              ),
            ),*/
            OutlineButton(
              child: Text('ADD'),
              onPressed: () {
                setState(() {
                  _addEmployee();
                });
                _clearValues();
              },
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlineButton(
                        child: Text('UPDATE'),
                        onPressed: () async {
                          //String id = employeeNumber.text.toString();
                          //String id = employeeNumber.text.toString();
                          DateTime d_LOG = _d_LOGController.text as DateTime;
                          String tYPE = _tYPEController.text;
                          String sENS = _sENSController.text;
                          String wS = _wSController.text;
                          String mETHODE = _mETHODEController.text;
                          String sYS_APPELANT = _sYS_APPELANTController.text;
                          String c_RETOUR = _c_RETOURController.text;
                          String oPERATION = _oPERATIONController.text;
                          String tXT_LOG = _tXT_LOGController.text;
                          String rEQUEST = _rEQUESTController.text;
                          String rESPONSE = _rESPONSEController.text;
                          //String iD_DEM = _iD_DEMController.toString();
                          //String bPM_UID = _bPM_UIDController.text;
                          String rEF_DEM_SRC = _rEF_DEM_SRCController.text;
                          LogsModel emp = new LogsModel();
                          emp.d_LOG = _d_LOGController.text;
                          emp.tYPE = _tYPEController.text;
                          emp.sENS = _sENSController.text;
                          emp.wS = _wSController.text;
                          emp.mETHODE = _mETHODEController.text;
                          emp.sYS_APPELANT = _sYS_APPELANTController.text;
                          emp.c_RETOUR = _c_RETOURController.text;
                          emp.tXT_LOG = _tXT_LOGController.text;
                          emp.rEQUEST = _rEQUESTController.text;
                          emp.rESPONSE = _rESPONSEController.text;
                          //emp.iD_DEM = _iD_DEMController.text as int;
                          //emp.bPM_UID = _bPM_UIDController.text;
                          emp.rEF_DEM_SRC = _rEF_DEM_SRCController.text;
                          LogsModel employees =
                              await _updateEmployee(emp, context);
                          setState(() {
                            _selectedEmployee = employees;
                          });
                          _clearValues();
                        },
                      ),
                      OutlineButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                      ),
                    ],
                  )
                : Container(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
}

