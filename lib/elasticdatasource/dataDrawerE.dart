import 'package:flutter/material.dart';
import 'package:itservpfeapp/elasticdatasource/getDSElastic.dart';
import 'package:itservpfeapp/elasticdatasource/registerDSElastic.dart';


class dataDrawerE extends StatefulWidget {
    const dataDrawerE({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return dataDrawerEState();
  }
}

class dataDrawerEState extends State<dataDrawerE> with SingleTickerProviderStateMixin {
  //final minimumPadding = 5.0;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Add to datasource elastic ',),
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
    return 
    ///// test tabbar view 
    Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          //indicatorSize: TabBarIndicatorSize.label,
          //isScrollable: true,
          indicatorWeight: 5,
          indicatorColor: Colors.black,
          controller: _tabController,
          tabs: myTabs,
        ),
        ),
      body: TabBarView(
        controller: _tabController,
        children: [
          
          Container(
          //color: Colors.grey[300],
          width: double.infinity,
          height: double.infinity,
           child: registerDSElastic(),
           decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
       borderRadius: BorderRadius.circular(20.0),
       
      ),
     ),
          Container(
        height: 700,
        width: 400,
        //color: Colors.blueGrey,
        child: getDSElastic(),
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
