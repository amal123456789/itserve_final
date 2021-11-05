import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itservpfeapp/elasticdatasource/deleteDsE.dart';
import 'package:itservpfeapp/elasticdatasource/updateDSElastic.dart';
import 'package:itservpfeapp/models/DatasourceModel.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

class getDSElastic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllDSElasticState();
  }
}

class getAllDSElasticState extends State<getDSElastic> {
  var datas = List<DatasourceModel>.generate(200, (index) => null);

  Future<List<DatasourceModel>> getDSElastic() async {
    var headers = await AuthenticationHeaderService.createAuthHeader();
    var data = await http.get(
        'http://165.227.228.41:8080/projetPfe/apidatasource/allhitsource',
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
      //datasources.descritpionSource = e["descritpionSource"];
      datasource.add(datasources);
    }
    return datasource;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;

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
      child: FutureBuilder(
        future: getDSElastic(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: Icon(Icons.error)));
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    showDialogFunc(context, snapshot.data[index]);
                  },
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: width,
                                child: ListTile(
                                  title: Text('ID' +
                                      '     ' +
                                      'Schema url' +
                                      '     ' +
                                      'System Name' +
                                      '  ' +
                                      'System Code' +
                                      '   ' +
                                      'Description'),
                                  subtitle: Text(
                                      '${snapshot.data[index].idSourceSequence}' +
                                          '${snapshot.data[index].schemaUrl}' +
                                          '${snapshot.data[index].systemName}' +
                                          '${snapshot.data[index].systemCode}' +
                                          '${snapshot.data[index].descritpionSource}'),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  /*child: ListTile(
                      title: Text('ID' + '     ' + 'Schema url' + '     ' + 'System Name'+'  '+ 'System Code'+'   '+ 'Description'),
                      subtitle: Text('${snapshot.data[index].idSourceSequence}' +
                          '${snapshot.data[index].schemaUrl}' +
                          '${snapshot.data[index].systemName}' +
                          '${snapshot.data[index].systemCode}' +
                          '${snapshot.data[index].descritpionSource}'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    showDialogFunc(context, snapshot.data[index])));
                      },*/
                );
              });
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  DatasourceModel datasource;

  DetailPage(this.datasource);

  deletedatas1(DatasourceModel datasource) async {
    final url = Uri.parse('http://165.227.228.41:8080/projetPfe/apidatasource/deleteds');
    var headers = await AuthenticationHeaderService.createAuthHeader();
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => updateDSElastic(datasource)));
              }),
        ],
      ),
      body: Container(
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => deleteDSe()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

showDialogFunc(context, DatasourceModel data) {
  //DataSource dataSource;
  deleteDatasource1(DatasourceModel employee) async {
    final url = Uri.parse('http://165.227.228.41:8080/projetPfe/apidatasource/deleteds');
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
                                        updateDSElastic(data)));
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
                                        builder: (context) => deleteDSe()));
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
