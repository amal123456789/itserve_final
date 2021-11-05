import 'package:flutter/material.dart';
import 'package:itservpfeapp/constants.dart';
import 'package:itservpfeapp/migration/servicemig.dart';
import 'package:itservpfeapp/notifications/notificationApi.dart';
import 'package:itservpfeapp/pages/notifications.dart';
import 'package:itservpfeapp/regisANDsignin/button.dart';
import 'package:itservpfeapp/registrationAuthentification/AuthenticationHeaderService.dart';

import '../themes.dart';

class migrationLog extends StatefulWidget {
  //
  migrationLog() : super();

  final String title = 'Migration';

  @override
  migrationLogState createState() => migrationLogState();
}

class migrationLogState extends State<migrationLog> {
  final minimumPadding = 5.0;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;
  bool _isUpdating;
  @override
  void initState() {
    super.initState();
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _isUpdating = false;
    //_makemig();
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

/////

  // _makemig(){
  //   _showProgress('migration in progress...');
  //   servicemig.getMigration();
  // }
  _makemig() async {
    _showProgress('migration in progress...');
    var data = await servicemig.getMigration();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(
          title: 'Backend Response',
          content: data,
        );
      },
    );
    NotificationAPI.showNotification(
        title: "test", body: "meggage body", payload: "notifications");
  }

  _getFileconf() {
    _showProgress('Fichiers config configurez votre input datasource ...');
    servicemig.getfileforMigration();
  }

  getOnlyfileconf() {
    servicemig.getfileforMigrationOne();
  }

  migratSourceone() async {
    var data = await servicemig.getMigrationSOne();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(
          title: 'Backend Response',
          content: data,
        );
      },
    );
    NotificationAPI.showNotification(
        title: "test", body: "meggage body", payload: "notifications");
  }

  migrateSourcetwo() async {
    var data = await servicemig.getMigrationSTwo();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(
          title: 'Backend Response',
          content: data,
        );
      },
    );
    NotificationAPI.showNotification(
        title: "test", body: "meggage body", payload: "notifications");
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text('no data'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Migration of logs data form different datasources"), // we show the progress in the title...
        ),
        body: Container(
          child: Column(children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 20,
            //     vertical: 20,
            //   ),
            //   child: Text(
            //     "Migration of logs data form \ndifferent datasources",
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
            Container(
              height: 150,
              width: 600,
              //color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.all(40),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: ButtonCustom(
                              text: "Config file \nmultiple datasources",
                              width: 200,
                              height: 38,
                              bgColor: color3,
                              press: () {
                                // _getFileconf();

          String data ="""                                        
  input {
jdbc {
   jdbc_driver_library => "/etc/logstash/mysql-connector-java.jar"
   jdbc_connection_string => "jdbc:mysql://doadmin:0G6SGdpqMnzXWgiX@amal-flutter-do-user-9903532-0.b.db.ondigit>
    jdbc_driver_class => "com.mysql.jdbc.Driver"
    jdbc_user => "doadmin"
    jdbc_password => "0G6SGdpqMnzXWgiX"
   #schedule => "* * * * *"
    statement => "SELECT * FROM logs"
   tracking_column => id
   use_column_value => true
    tags => ["sourceOne"]
  }
jdbc {
   jdbc_driver_library => "/etc/logstash/mysql-connector-java.jar"
   jdbc_connection_string => "jdbc:mysql://doadmin:wVEE2JT97MAXxNif@amal-flutter-logs-do-user-9903532-0.b.db.on>
    jdbc_driver_class => "com.mysql.jdbc.Driver"
    jdbc_user => "doadmin"
    jdbc_password => "wVEE2JT97MAXxNif"
    #schedule => "* * * * *"
    statement => "SELECT * FROM logs"
    tracking_column => id
    use_column_value => true
    tags => ["sourceTwo"]
  }
}
output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "logs_new"
    document_id=> "%{id}"
  }
  stdout{
codec => rubydebug
  }
}
        
        """;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(
          title: 'Backend Response',
          content: data,
        );//go a
      },
    );                              }))),
                  Padding(
                      padding: EdgeInsets.all(40),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: ButtonCustom(
                              text: "Only one source \nconfig file",
                              width: 200,
                              height: 38,
                              bgColor: blueColor,
                              press: () {
                                // getOnlyfileconf();
                                 String data ="""                                        
  
   input {
 jdbc {
   jdbc_driver_library => "/etc/logstash/mysql-connector-java.jar"
   jdbc_connection_string => "jdbc:mysql://doadmin:0G6SGdpqMnzXWgiX@amal-flutter-do-user-9903532-0.b.db.ondigit>
    jdbc_driver_class => "com.mysql.jdbc.Driver"
    jdbc_user => "doadmin"
    jdbc_password => "0G6SGdpqMnzXWgiX"
    #schedule => "* * * * *"
    statement => "SELECT * FROM logs"
    tracking_column => id
    use_column_value => true
    tags => ["sourceOne"]
  }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "logs_new"
    document_id=> "%{id}"
  }
  stdout{
codec => rubydebug
  }
}
        
        """;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(
          title: 'Backend Response',
          content: data,
        );//go a
      },
    );


                              }))),
                ],
              ),
            ),
            Container(
              height: 300,
              width: 500,
              //color: Colors.blueAccent,
              child: ListView(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                children: <Widget>[
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    children: [
                      Text('Migrate from source one'),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      TextButton(
                          onPressed: () {
                            migratSourceone();
                          },
                          child: Text('Click here '))
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    children: [
                      Text('Migrate from source two'),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      TextButton(
                          onPressed: () {
                            migrateSourcetwo();
                          },
                          child: Text('Click here '))
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    children: [
                      Text('Migrate from Twice sources'),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      TextButton(
                          onPressed: () {
                            _makemig();
                          },
                          child: Text('Click here '))
                    ],
                  ),
                ],
              ),
            ),
          ]),

          /*ListView(
          padding: EdgeInsets.only(
            top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
              child: Text('Migration ',),
              
            ),
            ListTile(
              title: Text('Migrate Datasource'),
              onTap: () {
                _makemig();
               
              },
            ),
            ListTile(
              title: Text('Migrate Logs'),
              onTap: () {
                _makemig();

                
              },
            )
          ],
        ),*/
        ));
  }
}
/*children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.amber,
            child : TextButton( child: Text("Fichier config ici"),
            onPressed: () {
              _getFileconf();

            },
              
            ),
          ),*/
          