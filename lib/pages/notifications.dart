import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itservpfeapp/migration/servicemig.dart';
import 'package:itservpfeapp/models/AlertModel.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class Notifications extends StatefulWidget {
  Notifications() : super();

  final String title = 'Notifications';

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  static List<AlertModel> _oldAlerts = [];
  List<AlertModel> _alerts;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;
  DateTime dateController = DateTime.now();

  @override
  void initState() {
    super.initState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text("Migration done"),
          content: new Text("Migrated successfully"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
    _alerts = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar

    _getAlerts();
    if (_oldAlerts != null) {
      if (_oldAlerts.length < _alerts.length) {
        print('old=' + _oldAlerts.length.toString());
        print('new=' + _alerts.length.toString());
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return MyAlertDialog(
              title: 'Migration performed',
              content: 'New Migration performed',
            );
          },
        );
      }
    }
    _oldAlerts = _alerts;
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

  _getAlerts() {
    _showProgress('Loading Alerts...');
    getAlerts().then((alerts) {
      setState(() {
        _alerts = alerts;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${alerts.length}");
    });
  }

  Future<List<AlertModel>> getAlerts() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get(
        'http://165.227.228.41:8080/projetPfe/apialertskibana/allhitalrts',
        headers: headers);
    var jsonData = json.decode(data.body);
    List<AlertModel> alerts = [];
    for (var e in jsonData) {
      AlertModel alert = new AlertModel();
      alert.id = e["id"];
      alert.name = e["name"];
      alert.action = e["action"];
      alert.message = e["message"];
      alerts.add(alert);
    }
    return alerts;
  }

  PaginatedDataTable _dataTable() {
    return PaginatedDataTable(
      header: Text('Alerts'),
      rowsPerPage: 7,
      columns: [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Action')),
        DataColumn(label: Text('Message')),
      ],
      source: _DataSource(context, _alerts),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _dataTable(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, List<AlertModel> alerts) {
    _rows = alerts;
  }

  final BuildContext context;
  List<AlertModel> _rows;

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
        DataCell(Text(row.id.toString() ?? '')),
        DataCell(Text(row.name ?? '')),
        DataCell(Text(row.action ?? '')),
        DataCell(Text(row.message ?? '')),
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
