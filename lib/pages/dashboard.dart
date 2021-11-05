import 'package:flutter/material.dart';
// import 'dart:html';
import 'dart:ui' as ui;

import 'package:itservpfeapp/pages/webview_page.dart';

class Dashboard extends StatelessWidget {
  // final IFrameElement _iframeElement = IFrameElement();
  // Widget _iframeWidget;

  @override
  Widget build(BuildContext context) {
    final _width = (MediaQuery.of(context).size.width * 0.7).truncateToDouble();
    final _height =
        (MediaQuery.of(context).size.height * 0.55).truncateToDouble();
    // _iframeElement.height = (MediaQuery.of(context).size.width * 0.75).truncateToDouble().toString();
    // _iframeElement.width = (MediaQuery.of(context).size.height * 0.75).truncateToDouble().toString();
    // _iframeElement.src = "http://localhost:5601/app/dashboards#/view/68388270-fdf9-11eb-a865-bd1ad34d41ff?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15h,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,syncColors:!f,useMargins:!t),panels:!((embeddableConfig:(attributes:(references:!((id:f10729a0-fdf7-11eb-a865-bd1ad34d41ff,name:indexpattern-datasource-current-indexpattern,type:index-pattern),(id:f10729a0-fdf7-11eb-a865-bd1ad34d41ff,name:indexpattern-datasource-layer-cc975018-0d59-4e13-bade-ccb70c79fb17,type:index-pattern)),state:(datasourceStates:(indexpattern:(layers:(cc975018-0d59-4e13-bade-ccb70c79fb17:(columnOrder:!(ee31e75e-f764-4feb-852e-721a18f32241,'4fe790e8-bb14-488a-8930-6d98a037660b'),columns:('4fe790e8-bb14-488a-8930-6d98a037660b':(dataType:number,isBucketed:!f,label:'Count%20of%20records',operationType:count,scale:ratio,sourceField:Records),ee31e75e-f764-4feb-852e-721a18f32241:(dataType:string,isBucketed:!t,label:'Top%20values%20of%20operation.keyword',operationType:terms,params:(missingBucket:!f,orderBy:(columnId:'4fe790e8-bb14-488a-8930-6d98a037660b',type:column),orderDirection:desc,otherBucket:!t,size:5),scale:ordinal,sourceField:operation.keyword)),incompleteColumns:())))),filters:!(),query:(language:kuery,query:''),visualization:(layers:!((categoryDisplay:default,groups:!(ee31e75e-f764-4feb-852e-721a18f32241),layerId:cc975018-0d59-4e13-bade-ccb70c79fb17,legendDisplay:default,metric:'4fe790e8-bb14-488a-8930-6d98a037660b',nestedLegend:!f,numberDisplay:percent)),shape:donut)),title:'',type:lens,visualizationType:lnsPie),enhancements:()),gridData:(h:11,i:b8127ac3-b712-408b-8e67-7ccb1806e733,w:12,x:0,y:0),panelIndex:b8127ac3-b712-408b-8e67-7ccb1806e733,type:lens,version:'7.14.0'),(embeddableConfig:(attributes:(references:!((id:f10729a0-fdf7-11eb-a865-bd1ad34d41ff,name:indexpattern-datasource-current-indexpattern,type:index-pattern),(id:f10729a0-fdf7-11eb-a865-bd1ad34d41ff,name:indexpattern-datasource-layer-8bf87627-cb8e-404a-8fda-b172f8df97c7,type:index-pattern)),state:(datasourceStates:(indexpattern:(layers:('8bf87627-cb8e-404a-8fda-b172f8df97c7':(columnOrder:!('8ec038ff-1f4e-486f-b17c-f5eaf128c5f5',f16d9a81-a233-435d-b573-33e64d85c204),columns:('8ec038ff-1f4e-486f-b17c-f5eaf128c5f5':(dataType:string,isBucketed:!t,label:'Top%20values%20of%20operation.keyword',operationType:terms,params:(missingBucket:!f,orderBy:(columnId:f16d9a81-a233-435d-b573-33e64d85c204,type:column),orderDirection:desc,otherBucket:!t,size:5),scale:ordinal,sourceField:operation.keyword),f16d9a81-a233-435d-b573-33e64d85c204:(dataType:number,isBucketed:!f,label:'Count%20of%20records',operationType:count,scale:ratio,sourceField:Records)),incompleteColumns:())))),filters:!(),query:(language:kuery,query:''),visualization:(axisTitlesVisibilitySettings:(x:!t,yLeft:!t,yRight:!t),fittingFunction:None,gridlinesVisibilitySettings:(x:!t,yLeft:!t,yRight:!t),layers:!((accessors:!(f16d9a81-a233-435d-b573-33e64d85c204),layerId:'8bf87627-cb8e-404a-8fda-b172f8df97c7',position:top,seriesType:bar_stacked,showGridlines:!f,xAccessor:'8ec038ff-1f4e-486f-b17c-f5eaf128c5f5')),legend:(isVisible:!t,position:right),preferredSeriesType:bar_stacked,tickLabelsVisibilitySettings:(x:!t,yLeft:!t,yRight:!t),valueLabels:hide,yLeftExtent:(mode:full),yRightExtent:(mode:full))),title:'',type:lens,visualizationType:lnsXY),enhancements:()),gridData:(h:11,i:'5cb4499e-f024-43b6-99c4-a6274f0ef695',w:13,x:12,y:0),panelIndex:'5cb4499e-f024-43b6-99c4-a6274f0ef695',type:lens,version:'7.14.0'),(embeddableConfig:(attributes:(references:!((id:f10729a0-fdf7-11eb-a865-bd1ad34d41ff,name:indexpattern-datasource-current-indexpattern,type:index-pattern),(id:f10729a0-fdf7-11eb-a865-bd1ad34d41ff,name:indexpattern-datasource-layer-f8b7e889-897f-405d-a383-8c61ba10f8ee,type:index-pattern)),state:(datasourceStates:(indexpattern:(layers:(f8b7e889-897f-405d-a383-8c61ba10f8ee:(columnOrder:!(a0682838-e4b8-47d6-9bb2-774f28f18356,'5566a914-682f-4430-a122-b0ce49487176'),columns:('5566a914-682f-4430-a122-b0ce49487176':(dataType:number,isBucketed:!f,label:'Count%20of%20records',operationType:count,scale:ratio,sourceField:Records),a0682838-e4b8-47d6-9bb2-774f28f18356:(dataType:string,isBucketed:!t,label:'Top%20values%20of%20ws.keyword',operationType:terms,params:(missingBucket:!f,orderBy:(columnId:'5566a914-682f-4430-a122-b0ce49487176',type:column),orderDirection:desc,otherBucket:!t,size:5),scale:ordinal,sourceField:ws.keyword)),incompleteColumns:())))),filters:!(),query:(language:kuery,query:''),visualization:(axisTitlesVisibilitySettings:(x:!t,yLeft:!t,yRight:!t),fittingFunction:None,gridlinesVisibilitySettings:(x:!t,yLeft:!t,yRight:!t),layers:!((accessors:!('5566a914-682f-4430-a122-b0ce49487176'),layerId:f8b7e889-897f-405d-a383-8c61ba10f8ee,seriesType:bar_stacked,xAccessor:a0682838-e4b8-47d6-9bb2-774f28f18356)),legend:(isVisible:!t,position:right),preferredSeriesType:bar_stacked,tickLabelsVisibilitySettings:(x:!t,yLeft:!t,yRight:!t),valueLabels:hide,yLeftExtent:(mode:full),yRightExtent:(mode:full))),title:'',type:lens,visualizationType:lnsXY),enhancements:()),gridData:(h:8,i:'6779ee98-1a5f-451d-86b9-55fa651e09bb',w:14,x:0,y:11),panelIndex:'6779ee98-1a5f-451d-86b9-55fa651e09bb',type:lens,version:'7.14.0')),query:(language:kuery,query:''),tags:!(),timeRestore:!f,title:logs_dashboard,viewMode:view)";
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
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      //color: Colors.blueGrey.shade200,
      decoration: BoxDecoration(
        //color: Colors.blueGrey.shade100,
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
                child: Center(child: WebViewXPage()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
