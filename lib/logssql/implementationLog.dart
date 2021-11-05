import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itservpfeapp/logssql/servicesLogsql.dart';
import 'package:itservpfeapp/models/Employee.dart';

//import 'package:itservpfeapp/models/Employee.dart';
import 'package:itservpfeapp/models/LogsModel.dart';
//import 'package:itservpfeapp/testing/Services.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class imlementationLog extends StatefulWidget {
  //
  imlementationLog() : super();

  final String title = 'Logs Management';

  @override
  imlementationLogState createState() => imlementationLogState();
}

class imlementationLogState extends State<imlementationLog> {
  List<LogsModel> _employees;
  List<LogsModel> _searchEmployees;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  //TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  //TextEditingController _lastNameController;
  //TextEditingController employeeNumber;
  LogsModel _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;
  DateTime dateController = DateTime.now();
  TextEditingController _searchLogsController;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _searchLogsController = TextEditingController();
    /*_firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    employeeNumber = TextEditingController();*/
    //employeeNumber =TextEditingController(text: _selectedEmployee.id.toString());

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

  _getEmployees() {
    _showProgress('Loading Logs...');
    ServicesLogsql.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
        _searchEmployees = employees;
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
    ServicesLogsql.updateEmployee(employee, context).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        // _clearValues();
      }
    });
  }

  _deleteEmployee(LogsModel employee) async {
    final url = Uri.parse('http://165.227.228.41:8080/projetPfe/deletelogs');
    var headers = await AuthenticationHeaderService.createAuthHeader();
    final request = http.Request("DELETE", url);
    request.headers.addAll(headers);
    request.body = jsonEncode(employee);
    final response = await request.send();
    _showProgress('Deleting Employee...');
    ServicesLogsql.deleteEmployees(employee).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh after delete...
      }
    });
  }

  _showValues(LogsModel log) {
    showDialogFunc(context, true, log);
    // idNumber.text = employee.id.toString();
    // //_d_LOGController.text = employee.d_LOG.toString();
    // _tYPEController.text = employee.tYPE;
    // _sENSController.text = employee.sENS;
    // _wSController.text = employee.wS;
    // _mETHODEController.text = employee.sYS_APPELANT;
    // _sYS_APPELANTController.text = employee.c_RETOUR;F
    // _c_RETOURController.text = employee.oPERATION;
    // _oPERATIONController.text = employee.oPERATION;
    // _tXT_LOGController.text = employee.tXT_LOG;
    // _rEQUESTController.text = employee.rEQUEST;
    // _rESPONSEController.text = employee.rESPONSE;
    // //_iD_DEMController.text = employee.iD_DEM.toString();
    // //_bPM_UIDController.text =employee.bPM_UID;
    // _rEF_DEM_SRCController.text = employee.rEF_DEM_SRC;
    // //dateController = employee.d_LOG;
  }

  PaginatedDataTable _dataTable() {
    return PaginatedDataTable(
      header: Text('Logs'),
      rowsPerPage: 7,
      columns: [
        DataColumn(
            label: Text('ID', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('Date', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('Sens', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('Web Service',
                style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('Methode', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('System Applecant',
                style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('Code Retour',
                style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label:
                Text('Operation', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('Text', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('Request', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label:
                Text('Response', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('Source/Destination',
                style: TextStyle(color: Colors.blueAccent))),
      ],
      source: _DataSource(context, _employees),
    );
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
          Container(
            width: 250,
            height: 7,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: _searchLogsController,
                onChanged: (text) {
                  if (text.isEmpty) {
                    setState(() {
                      _employees = _searchEmployees;
                    });
                  } else {
                    if (_employees.isNotEmpty &&
                        _searchLogsController.text.isNotEmpty) {
                      _employees = [];
                      for (int i = 0; i < _searchEmployees.length; i++) {
                        if (_searchEmployees[i]
                                .methode
                                .contains(_searchLogsController.text.trim()) ||
                            _searchEmployees[i]
                                .id
                                .toString()
                                .contains(_searchLogsController.text.trim())) {
                          setState(() {
                            _employees.add(_searchEmployees[i]);
                          });
                        }
                      }
                    }
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                    ),
                    hintText: 'Search log',
                    border: InputBorder.none),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ButtonTheme(
            minWidth: 20.0,
            height: 5.0,
            child: RaisedButton(
              onPressed: () {
                if (_employees.isNotEmpty &&
                    _searchLogsController.text.isNotEmpty) {
                  _employees = [];
                  for (int i = 0; i < _searchEmployees.length; i++) {
                    if (_searchEmployees[i]
                            .methode
                            .contains(_searchLogsController.text.trim()) ||
                        _searchEmployees[i]
                            .id
                            .toString()
                            .contains(_searchLogsController.text.trim())) {
                      setState(() {
                        _employees.add(_searchEmployees[i]);
                      });
                    }
                  }
                }
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Text("Search"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //_createTable();
              showDialogFunc(context, false, null);
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
            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            // _isUpdating
            //     ? Row(
            //         children: <Widget>[
            //           OutlineButton(
            //             child: Text('UPDATE'),
            //             onPressed: () async {
            //               //String id = employeeNumber.text.toString();
            //               //String id = employeeNumber.text.toString();
            //               DateTime d_LOG = _d_LOGController.text as DateTime;
            //               String tYPE = _tYPEController.text;
            //               String sENS = _sENSController.text;
            //               String wS = _wSController.text;
            //               String mETHODE = _mETHODEController.text;
            //               String sYS_APPELANT = _sYS_APPELANTController.text;
            //               String c_RETOUR = _c_RETOURController.text;
            //               String oPERATION = _oPERATIONController.text;
            //               String tXT_LOG = _tXT_LOGController.text;
            //               String rEQUEST = _rEQUESTController.text;
            //               String rESPONSE = _rESPONSEController.text;
            //               //String iD_DEM = _iD_DEMController.toString();
            //               //String bPM_UID = _bPM_UIDController.text;
            //               String rEF_DEM_SRC = _rEF_DEM_SRCController.text;
            //               LogsModel emp = new LogsModel();
            //               emp.d_LOG = _d_LOGController.text;
            //               emp.tYPE = _tYPEController.text;
            //               emp.sENS = _sENSController.text;
            //               emp.wS = _wSController.text;
            //               emp.mETHODE = _mETHODEController.text;
            //               emp.sYS_APPELANT = _sYS_APPELANTController.text;
            //               emp.c_RETOUR = _c_RETOURController.text;
            //               emp.tXT_LOG = _tXT_LOGController.text;
            //               emp.rEQUEST = _rEQUESTController.text;
            //               emp.rESPONSE = _rESPONSEController.text;
            //               //emp.iD_DEM = _iD_DEMController.text as int;
            //               //emp.bPM_UID = _bPM_UIDController.text;
            //               emp.rEF_DEM_SRC = _rEF_DEM_SRCController.text;
            //               LogsModel employees =
            //                   await _updateEmployee(emp, context);
            //               setState(() {
            //                 _selectedEmployee = employees;
            //               });
            //               _clearValues();
            //             },
            //           ),
            //           OutlineButton(
            //             child: Text('CANCEL'),
            //             onPressed: () {
            //               setState(() {
            //                 _isUpdating = false;
            //               });
            //               _clearValues();
            //             },
            //           ),
            //         ],
            //       )
            //     : Container(),
            Expanded(
              child: _dataTable(), //_dataBody(),
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

showDialogFunc(context, bool update, LogsModel log) {
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
  TextEditingController _rEF_DEM_SRCController;

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
  _rEF_DEM_SRCController = TextEditingController();

  idNumber = TextEditingController();
  DateTime dateController = DateTime.now();
  DateFormat dateFormat = new DateFormat('yyyy-MM-dd');

  if (update) {
    idNumber.text = log.id.toString();
    _d_LOGController.text = log.d_LOG.toString() ?? '';
    _tYPEController.text = log.tYPE ?? '';
    _sENSController.text = log.sENS ?? '';
    _wSController.text = log.wS ?? '';
    _mETHODEController.text = log.mETHODE ?? '';
    _sYS_APPELANTController.text = log.sYS_APPELANT ?? '';
    _c_RETOURController.text = log.c_RETOUR ?? '';
    _oPERATIONController.text = log.oPERATION ?? '';
    _tXT_LOGController.text = log.tXT_LOG ?? '';
    _rEQUESTController.text = log.rEQUEST ?? '';
    _rESPONSEController.text = log.rESPONSE ?? '';
    //_iD_DEMController.text = employee.iD_DEM.toString();
    //_bPM_UIDController.text =employee.bPM_UID;
    _rEF_DEM_SRCController.text = log.rEF_DEM_SRC ?? '';
  }

  Future<Null> selectTimePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateController,
      firstDate: DateTime(1940),
      lastDate: DateTime(2250),
    );
    if (picked != null && picked != dateController) {
      dateController = picked;
      String text = DateFormat().format(DateTime.now());
      //print(datasource.dateModif.toString());
    }
    _d_LOGController.text = dateFormat.format(dateController);
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
    ServicesLogsql.addEmployee(
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
        _clearValues();
      }
    });
  }

  _updateLog() {
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
    LogsModel logModel = new LogsModel();
    logModel.id = int.parse(idNumber.text);
    logModel.d_LOG = _d_LOGController.text;
    logModel.tYPE = _tYPEController.text;
    logModel.sENS = _sENSController.text;
    logModel.wS = _wSController.text;
    logModel.mETHODE = _mETHODEController.text;
    logModel.sYS_APPELANT = _sYS_APPELANTController.text;
    logModel.c_RETOUR = _c_RETOURController.text;
    logModel.oPERATION = _oPERATIONController.text;
    logModel.tXT_LOG = _tXT_LOGController.text;
    logModel.rEQUEST = _rEQUESTController.text;
    logModel.rESPONSE = _rESPONSEController.text;
    logModel.rEF_DEM_SRC = _rEF_DEM_SRCController.text;

    ServicesLogsql.updateEmployee(logModel, context);
  }

  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                        controller:
                                            _d_LOGController ?? 'default value',
                                        decoration: new InputDecoration(
                                            hintText: 'd_LOG',
                                            labelText: 'd_LOG'),
                                        onTap: () async {
                                          selectTimePicker(context);
                                        }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller:
                                          _tYPEController ?? 'default value',
                                      decoration: new InputDecoration(
                                          hintText: 'tYPE', labelText: 'tYPE'),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller:
                                          _sENSController ?? 'default value',
                                      decoration: new InputDecoration(
                                        hintText: 'sENS',
                                        labelText: 'sENS',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller:
                                          _wSController ?? 'default value',
                                      decoration: InputDecoration(
                                        hintText: 'wS',
                                        labelText: 'wS',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller:
                                          _mETHODEController ?? 'default value',
                                      decoration: new InputDecoration(
                                        hintText: 'mETHODE',
                                        labelText: 'mETHODE',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: _sYS_APPELANTController ??
                                          'default value',
                                      decoration: InputDecoration(
                                        hintText: 'sYS_APPELANT',
                                        labelText: 'sYS_APPELANT',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: _c_RETOURController ??
                                          'default value',
                                      decoration: InputDecoration(
                                        hintText: 'c_RETOUR',
                                        labelText: 'c_RETOUR',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: _oPERATIONController ??
                                          'default value',
                                      decoration: InputDecoration(
                                        hintText: 'oPERATION',
                                        labelText: 'oPERATION',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller:
                                          _tXT_LOGController ?? 'default value',
                                      decoration: InputDecoration(
                                        hintText: 'tXT_LOG',
                                        labelText: 'tXT_LOG',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller:
                                          _rEQUESTController ?? 'default value',
                                      decoration: InputDecoration(
                                        hintText: 'rEQUEST',
                                        labelText: 'rEQUEST',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: _rESPONSEController ??
                                          'default value',
                                      decoration: InputDecoration(
                                        hintText: 'rESPONSE',
                                        labelText: 'rESPONSE',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: _rEF_DEM_SRCController ??
                                          'default value',
                                      decoration: InputDecoration(
                                        hintText: 'rEF_DEM_SRC',
                                        labelText: 'rEF_DEM_SRC',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!update)
                        OutlineButton(
                          child: Text('ADD'),
                          onPressed: () {
                            _addEmployee();
                            _clearValues();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => imlementationLog()));
                          },
                        ),
                      if (update)
                        OutlineButton(
                          child: Text('UPDATE'),
                          onPressed: () {
                            _updateLog();
                            _clearValues();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => imlementationLog()));
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, List<LogsModel> employees) {
    _rows = employees;
  }

  final BuildContext context;
  List<LogsModel> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: false,
      // onSelectChanged: (value) {
      //   if (row.selected != value) {
      //     _selectedCount += value ? 1 : -1;
      //     assert(_selectedCount >= 0);
      //     row.selected = value;
      //     notifyListeners();
      //   }
      // },
      cells: [
        DataCell(Text(row.id.toString() ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.d_LOG ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.sENS ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.wS ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.mETHODE ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.sYS_APPELANT ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.c_RETOUR ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.oPERATION ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.tXT_LOG ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.rEQUEST ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.rESPONSE ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
        DataCell(Text(row.rEF_DEM_SRC ?? ''),
            onTap: () => showDialogFunc(context, true, row)),
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
