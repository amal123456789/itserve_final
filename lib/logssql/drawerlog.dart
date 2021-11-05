import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itservpfeapp/constants.dart';
import 'package:itservpfeapp/logssql/implementationLog.dart';

class drawerlog extends StatefulWidget{
  const drawerlog({Key key}) : super (key: key);

  @override
  State<StatefulWidget> createState() {
    return drawerlogState();
  }
}
class drawerlogState extends State<drawerlog> with SingleTickerProviderStateMixin {
 static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Add to datasource',),
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
     Scaffold(
            
            /*appBar: AppBar(
              backgroundColor: Colors.amber,
              bottom: TabBar(
                //indicatorSize: TabBarIndicatorSize.label,
                //isScrollable: true,
                indicatorWeight: 5,
                indicatorColor: Colors.black,
                controller: _tabController,
                tabs: myTabs,
              ),
              ),*/
            body: 
            ///test video 
            Container(
              
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                  //color: Colors.grey[300],
                  //width: double.infinity,
                  //height: double.infinity,
                   child: imlementationLog(),
                   decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
             borderRadius: BorderRadius.circular(20.0),
             
            ),
           ),
           /*SizedBox(height: defaultPadding,),
                  Container(
                //height: 700,
             // width: 400,
                //color: Colors.blueGrey,
                child: getDataSource(),
                decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
             borderRadius: BorderRadius.circular(20.0),
            ),),*/
                    


                  ],
                ),
              ),
            ),
     );
  }
  }