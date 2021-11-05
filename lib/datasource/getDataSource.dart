import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
//import 'package:itservpfeapp/datasource/datasourceDrawer.dart';
import 'package:itservpfeapp/datasource/deletedatasource.dart';
import 'package:itservpfeapp/datasource/updateDatasource.dart';
import 'package:itservpfeapp/models/DatasourceModel.dart';
import 'package:itservpfeapp/models/PropertiesModel.dart';
import 'package:itservpfeapp/models/SourcePropertiesModel.dart';
import 'package:itservpfeapp/registrationAuthentification/SessionStorageService.dart';

import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class getDataSource extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllDataSourceState();
  }
}

Future<String> loadRole() async {
  var sessionStorageService = await SessionStorageService.getInstance();
  var role = sessionStorageService.retriveRole();
  return role;
}

class getAllDataSourceState extends State<getDataSource> {
  var datas = List<DatasourceModel>.generate(200, (index) => null);
  bool isAdmin = false;
  Future<List<DatasourceModel>> getDataSource() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get(
        'http://165.227.228.41:8080/projetPfe/getalldatasource',
        headers: headers);
    var jsonData = json.decode(data.body);

    List<DatasourceModel> datasource = [];
    for (var e in jsonData) {
      DatasourceModel datasources = new DatasourceModel();
      datasources.idSourceSequence = e["idSourceSequence"];
      datasources.schemaUrl = e["schemaUrl"];
      datasources.systemName = e["systemName"];
      datasources.systemCode = e["systemCode"];
      datasources.descritpionSource = e["descritpionSource"];
      datasources.idSourceprop = e["idSourceprop"];
      //datasources.descritpionSource = e["descritpionSource"];
      datasource.add(datasources);
    }
    isAdmin = await loadRole() == 'admin';

    return datasource;
  }

  DataTable _dataTable(List<DatasourceModel> data) {
    List<DataRow> rows = [];

    for (var rowData in data) {
      rows.add(DataRow(
        cells: [
          DataCell(Text(rowData.idSourceSequence.toString() ?? ''),
              onTap: () => showPropertiesDialogFunc(context, rowData, isAdmin)),
          DataCell(Text(rowData.schemaUrl ?? ''),
              onTap: () => showPropertiesDialogFunc(context, rowData, isAdmin)),
          DataCell(Text(rowData.systemName ?? ''),
              onTap: () => showPropertiesDialogFunc(context, rowData, isAdmin)),
          DataCell(Text(rowData.systemCode ?? ''),
              onTap: () => showPropertiesDialogFunc(context, rowData, isAdmin)),
          DataCell(Text(rowData.descritpionSource ?? ''),
              onTap: () => showPropertiesDialogFunc(context, rowData, isAdmin)),
        ],
      ));
    }
    return DataTable(
      columns: [
        DataColumn(
            label: Text('Id', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label:
                Text('schemaUrl', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label:
                Text('systemName', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label:
                Text('systemCode', style: TextStyle(color: Colors.blueAccent))),
        DataColumn(
            label: Text('descritpionSource',
                style: TextStyle(color: Colors.blueAccent))),
      ],
      rows: rows,
    );
  }
  // PaginatedDataTable _dataTable(List<DatasourceModel> data) {
  //   return PaginatedDataTable(
  //     header: Text('Data Sources'),
  //     rowsPerPage: 5,
  //     columns: [
  //       DataColumn(
  //           label: Text(
  //         'ID',
  //         style: TextStyle(color: Colors.blueGrey),
  //       )),
  //       DataColumn(
  //           label:
  //               Text('Schema url', style: TextStyle(color: Colors.blueGrey))),
  //       DataColumn(
  //           label:
  //               Text('System Name', style: TextStyle(color: Colors.blueGrey))),
  //       DataColumn(
  //           label:
  //               Text('System Code', style: TextStyle(color: Colors.blueGrey))),
  //       DataColumn(
  //           label:
  //               Text('Description', style: TextStyle(color: Colors.blueGrey))),
  //     ],
  //     source: _DataSource(context, data),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    double height = MediaQuery.of(context).size.height * 0.5;

    return /*Scaffold(
      appBar: new AppBar(
        title: new Text("All Dtasourcess Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => datasourceDrawer()));
          },
        ),
      ),
      body:*/
        Container(
      height: height,
      width: width,
      child: FutureBuilder(
        future: getDataSource(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: Icon(Icons.error)));
          }
          return Container(
              // color: Colors.black54,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Expanded(
                  child:
                      SingleChildScrollView(child: _dataTable(snapshot.data)),
                )
              ]));
          // return ListView.builder(
          //     itemCount: snapshot.data.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return GestureDetector(
          //         onTap: () {
          //           //showDialogFunc(context, snapshot.data[index], isAdmin);
          //           showPropertiesDialogFunc(
          //               context, snapshot.data[index], isAdmin);
          //         },
          //         child: Card(
          //           child: Row(
          //             children: <Widget>[
          //               Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: <Widget>[
          //                     SizedBox(
          //                       height: 10,
          //                     ),
          //                     Container(
          //                       width: 600,
          //                       child: ListTile(
          //                         title: Text('ID' +
          //                             '     ' +
          //                             'Schema url' +
          //                             '     ' +
          //                             'System Name' +
          //                             '  ' +
          //                             'System Code' +
          //                             '   ' +
          //                             'Description'),
          //                         subtitle: Text(
          //                             '${snapshot.data[index].idSourceSequence}' +
          //                                 '     ' +
          //                                 '${snapshot.data[index].schemaUrl}' +
          //                                 '     ' +
          //                                 '${snapshot.data[index].systemName}' +
          //                                 '     ' +
          //                                 '${snapshot.data[index].systemCode}' +
          //                                 '     ' +
          //                                 '${snapshot.data[index].descritpionSource}'),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //         /*child: ListTile(
          //             title: Text('ID' + '     ' + 'Schema url' + '     ' + 'System Name'+'  '+ 'System Code'+'   '+ 'Description'),
          //             subtitle: Text('${snapshot.data[index].idSourceSequence}' +
          //                 '${snapshot.data[index].schemaUrl}' +
          //                 '${snapshot.data[index].systemName}' +
          //                 '${snapshot.data[index].systemCode}' +
          //                 '${snapshot.data[index].descritpionSource}'),
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) =>
          //                           showDialogFunc(context, snapshot.data[index])));
          //             },*/
          //       );
          //     });
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  DatasourceModel datasource;

  DetailPage(this.datasource);

  deletedatas1(DatasourceModel datasource) async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    final url =
        Uri.parse('http://165.227.228.41:8080/projetPfe/deletedatasource');
    final request = http.Request("DELETE", url);
    request.headers.addAll(headers);
    request.body = jsonEncode(datasource);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(datasource.schemaUrl),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                /*
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => updateDatasource(datasource)));
              */
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text('schemaUrl' +
                  ' ' +
                  datasource.schemaUrl +
                  ' ' +
                  'systemName' +
                  datasource.systemName +
                  'systemCode' +
                  ' ' +
                  datasource.systemCode +
                  ' ' +
                  'descritpionSource' +
                  ' ' +
                  datasource.descritpionSource),
            ],
          ),
        ),
      ),
      /*  IconButton(
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                     deletedatas1(datasource);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => deletedatasource()));
                    }),*/

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deletedatas1(datasource);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => deletedatasource()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

showDialogFunc(context, DatasourceModel data, bool isAdmin) {
  //DataSource dataSource;
  deleteDatasource1(DatasourceModel employee) async {
    final url =
        Uri.parse('http://165.227.228.41:8080/projetPfe/deletedatasource');
    var headers = await AuthenticationHeaderService.createAuthHeader();
    final request = http.Request("DELETE", url);
    request.headers.addAll(headers);
    request.body = jsonEncode(employee);
    final response = await request.send();
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
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isAdmin)
                      Container(
                        child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              /*
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          updateDatasource(data)));
                            */
                            }),
                      ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('SchemaUrl :' + ' ',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal)),
                          Text(data.schemaUrl + ' ',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('systemName :' + ' ',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal)),
                          Text(data.systemName,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('systemCode: ' + ' ',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal)),
                          Text(data.systemCode + ' ',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('descritpionSource:' + ' ',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal)),
                          Text(data.descritpionSource,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (isAdmin)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.amber,
                                ),
                                onPressed: () {
                                  deleteDatasource1(data);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              deletedatasource()));
                                }),
                          ],
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

// show datashource properties
showPropertiesDialogFunc(
    context, DatasourceModel datasourceModel, bool isAdmin) {
  //DataSource dataSource;
  deleteDatasource1() async {
    final url = Uri.parse(
        'http://165.227.228.41:8080/projetPfe/deletedatasource/' +
            datasourceModel.idSourceSequence.toString());
    var headers = await AuthenticationHeaderService.createAuthHeader();
    final request = http.Request("DELETE", url);
    request.headers.addAll(headers);
    final response = await request.send();
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return MyAlertDialog(
                title: 'Backend Response', content: response.toString());
          });
    }
  }

  SourcePropertiesModel spm = new SourcePropertiesModel();
  PropertiesModel pm = new PropertiesModel();

  Future<String> getSourceProperties() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get(
        'http://165.227.228.41:8080/projetPfe/getsourceprop/' +
            datasourceModel.idSourceprop.toString(),
        headers: headers);
    var jsonData = json.decode(data.body);
    spm.idSourceprop = jsonData["idSourceprop"];
    spm.value = jsonData["value"];
    spm.loginModif = jsonData["loginModif"];
    spm.dateModif = DateTime.parse(jsonData["dateModif"].toString());
    if (jsonData["properties"] == null) {
      //pm.idProperty = ;
      pm.codeProp = "";
      pm.propName = "";
      pm.classe = "";
    } else {
      pm.idProperty = jsonData["properties"]["idProperty"];
      pm.codeProp = jsonData["properties"]["codeProp"];
      pm.propName = jsonData["properties"]["propName"];
      pm.classe = jsonData["properties"]["classe"];
    }
    return "true";
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
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              height: 500,
              width: MediaQuery.of(context).size.width * 0.7,
              child: FutureBuilder(
                  future: getSourceProperties(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(child: Center(child: Icon(Icons.error)));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (isAdmin)
                              Container(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  updateDatasource(
                                                      datasourceModel,
                                                      spm,
                                                      pm)));
                                    }),
                              ),
                          ],
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Source Properties :' + ' ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontStyle: FontStyle.normal)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('value :' + ' ',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal)),
                                  Text(spm.value + ' ',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('loginModif :' + ' ',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal)),
                                  Text(spm.loginModif,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('dateModif: ' + ' ',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal)),
                                  Text(spm.dateModif.toString(),
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text('Properties:' + ' ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontStyle: FontStyle.normal)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('codeProp: ' + ' ',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal)),
                                  Text(pm.codeProp,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('propName: ' + ' ',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal)),
                                  Text(pm.propName,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('classe: ' + ' ',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal)),
                                  Text(pm.classe,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                              SizedBox(height: 20),
                              if (isAdmin)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.amber,
                                        ),
                                        onPressed: () {
                                          deleteDatasource1();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      getDataSource()));
                                        }),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            )),
      );
    },
  );
}
