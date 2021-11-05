import 'package:flutter/material.dart';
import 'package:itservpfeapp/property/getall.dart';
import 'package:itservpfeapp/property/register.dart';

class drawer extends StatefulWidget {
  const drawer({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return drawerState();
  }
}

class drawerState extends State<drawer> with SingleTickerProviderStateMixin {
  //final minimumPadding = 5.0;
  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: 'New Properties',
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    double height = MediaQuery.of(context).size.height * 0.5;
    return
        ///// test tabbar view
        Scaffold(
      appBar: AppBar(
        title: Text("Properties"),
        bottom: TabBar(
          //indicatorSize: TabBarIndicatorSize.label,
          //isScrollable: true,
          indicatorWeight: 5,
          indicatorColor: Colors.green,
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        Container(
          //color: Colors.grey[300],
          width: double.infinity,
          height: double.infinity,
          child: register(),
          // decoration: BoxDecoration(
          //   color: Colors.black87,
          //   borderRadius: BorderRadius.circular(20.0),
          // ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          //color: Colors.blueGrey,
          child: getalldata(),
          // decoration: BoxDecoration(
          //   color: Colors.black87,
          //   borderRadius: BorderRadius.circular(20.0),
          // ),
        ),
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
          ),
    );

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
