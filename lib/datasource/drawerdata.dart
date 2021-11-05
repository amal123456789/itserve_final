import 'package:flutter/material.dart';
import 'package:itservpfeapp/datasource/getDataSource.dart';
import 'package:itservpfeapp/datasource/registerDatasource.dart';

class drawerdata extends StatefulWidget {
  const drawerdata({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return drawerdataState();
  }
}

class drawerdataState extends State<drawerdata>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              child: Column(
            children: [
              Container(
                child: registerDatasource(),
              ),
              Container(
                child: getDataSource(),
              ),
            ],
          )),
        ),
      ),
    ));
  }
}
