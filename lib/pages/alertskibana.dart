// import 'dart:html';

import 'package:flutter/material.dart';

class AlertKibana extends StatelessWidget {
  // final IFrameElement _iframeElement = IFrameElement();
  // Widget _iframeWidget;

  @override
  Widget build(BuildContext context) {
    final _width =
        (MediaQuery.of(context).size.width * 0.47).truncateToDouble();
    final _height =
        (MediaQuery.of(context).size.height * 0.75).truncateToDouble();
    // _iframeElement.height = (MediaQuery.of(context).size.width * 0.75).truncateToDouble().toString();
    // _iframeElement.width = (MediaQuery.of(context).size.height * 0.75).truncateToDouble().toString();
    // _iframeElement.src = "http://localhost:5601/app/management/insightsAndAlerting/triggersActions/alerts";
    // _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    // ui.platformViewRegistry.registerViewFactory(
    //   'iframeElement',
    //   (int viewId) => _iframeElement,
    // );

    // _iframeWidget = HtmlElementView(
    //   key: UniqueKey(),
    //   viewType: 'iframeElement',
    // );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      //color: Colors.blueGrey.shade200,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(20.0),
      ),
      alignment: Alignment.centerRight,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25.0,
          ),
          Row(
            children: [
              SizedBox(
                  height: _height,
                  width: _width,
                  child:
                      Text('replace this with new dashboard') //_iframeWidget,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
