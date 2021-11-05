import 'package:flutter/material.dart';
import 'package:itservpfeapp/constants.dart';
import 'package:itservpfeapp/datasource/getDataSource.dart';
import 'package:itservpfeapp/datasource/registerDatasource.dart';
import 'package:itservpfeapp/registrationAuthentification/SessionStorageService.dart';

class datasourceDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return datasourceDrawerState();
  }
}

class datasourceDrawerState extends State<datasourceDrawer>
    with SingleTickerProviderStateMixin {
  //final minimumPadding = 5.0;
  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Add to datasource',
    ),
    Tab(text: 'All Data'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<String> loadRole() async {
    var sessionStorageService = await SessionStorageService.getInstance();
    var role = sessionStorageService.retriveRole();
    return role;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadRole(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final isAdmin = asyncSnapshot.data == 'admin';
            return Scaffold(
              appBar: AppBar(
                  title: Text(
                      "Data Source"), // we show the progress in the title...
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // _createTable();
                        showDialog(context: context, builder: (BuildContext context) => registerDatasource(),);
                        // showDialogFunc(context, true, null);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        // _getEmployees();
                      },
                    )
                  ]),
              body:

                  ///test video
                  Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      if (isAdmin)
                        Container(
                            //color: Colors.grey[300],
                            //width: double.infinity,
                            //height: double.infinity,
                            // this is the data form right above the table
                            // child: registerDatasource(),
                            // decoration: BoxDecoration(
                            //   color: Colors.blueGrey.shade100,
                            //   borderRadius: BorderRadius.circular(20.0),
                            // ),
                            ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Container(
                        //height: 700,
                        // width: 400,
                        //color: Colors.blueGrey,
                        child: getDataSource(),
                        // decoration: BoxDecoration(
                        //   color: Colors.blueGrey.shade100,
                        //   borderRadius: BorderRadius.circular(20.0),
                        // ),
                      ),
                    ],
                  ),
                ),
              ),

              /*TabBarView(
              controller: _tabController,
              children: [
                
                Container(
                //color: Colors.grey[300],
                width: double.infinity,
                height: double.infinity,
                 child: registerDatasource(),
                 decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
             borderRadius: BorderRadius.circular(20.0),
             
            ),
           ),
                Container(
              height: 700,
              width: 400,
              //color: Colors.blueGrey,
              child: getDataSource(),
              decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
             borderRadius: BorderRadius.circular(20.0),
            ),),
                
              ]
                
                
                /*myTabs.map((Tab tab) {
                final String label = tab.text.toLowerCase();
                return Center(
                  child: Text(
                    'This is the $label tab',
                    style: const TextStyle(fontSize: 36),
                  ),
                );
              }).toList(),*/
            ),*/
            );
          }
          return Container();
        });

    /*Container(
      color: Colors.grey[300],
     width: double.infinity,
     height: double.infinity,
     child: Row(
    mainAxisAlignment:MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 700,
        width: 400,
        child: registerDatasource(),
        //color: Colors.blueGrey,
        decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
       borderRadius: BorderRadius.circular(20.0),
       
      ),

      ),
       SizedBox(width: 20,),
      Container(
        height: 700,
        width: 400,
        //color: Colors.blueGrey,
        child: getDataSource(),
        decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
       borderRadius: BorderRadius.circular(20.0),
      ),
      ),
    ],
  ),

    );*/

    /*Scaffold(
      appBar: AppBar(
        title: Text('Employee Management'),
      ),
      body: Center(child: Text('Welcome To amal app')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
              child: Text('Employee Management'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Register Employee'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => registerDatasource()));
              },
            ),
            ListTile(
              title: Text('Get all data'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getDataSource()));
              },
            )
          ],
        ),
      ),
    );*/
  }
}
