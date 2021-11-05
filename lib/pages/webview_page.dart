import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    Key key,
  }) : super(key: key);

  @override
  _WebViewXPageState createState() => _WebViewXPageState();
}

class _WebViewXPageState extends State<WebViewXPage> {
  WebViewXController webviewController;
  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                buildSpace(direction: Axis.vertical, amount: 10.0, flex: false),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                  ),
                  child: _buildWebViewX(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebViewX() {
    return SingleChildScrollView(
      child: WebViewX(
        key: const ValueKey('webviewx'),
        initialSourceType: SourceType.URL,
        initialContent:
            "http://165.227.228.41:5601/app/dashboards#/view/1e193790-2895-11ec-9653-c5e3a1dd84c8?embed=true&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,syncColors:!f,useMargins:!t),panels:!((embeddableConfig:(attributes:(description:'methode%20selon%20code%20retour',references:!((id:b6b57f40-2769-11ec-91be-f595bdc8e18a,name:indexpattern-datasource-current-indexpattern,type:index-pattern),(id:b6b57f40-2769-11ec-91be-f595bdc8e18a,name:indexpattern-datasource-layer-8002249e-159d-4d5b-82e8-5309028c0d13,type:index-pattern),(id:b6b57f40-2769-11ec-91be-f595bdc8e18a,name:indexpattern-datasource-layer-8f83eca3-b8ee-4d50-903c-75bb085020f6,type:index-pattern)),state:(datasourceStates:(indexpattern:(layers:('8002249e-159d-4d5b-82e8-5309028c0d13':(columnOrder:!('0ae76557-81fd-4106-b4db-53b3e9a10fe9',b2d8baf2-886f-41ea-9ad1-c6fbfe14bdf6,'8de887f9-c0ae-4cc8-a8f0-b9b8f0f82db9'),columns:('0ae76557-81fd-4106-b4db-53b3e9a10fe9':(dataType:string,isBucketed:!t,label:'Top%20values%20of%20c_retour.keyword',operationType:terms,params:(missingBucket:!f,orderBy:(columnId:'8de887f9-c0ae-4cc8-a8f0-b9b8f0f82db9',type:column),orderDirection:desc,otherBucket:!t,size:5),scale:ordinal,sourceField:c_retour.keyword),'8de887f9-c0ae-4cc8-a8f0-b9b8f0f82db9':(dataType:number,isBucketed:!f,label:'Count%20of%20records',operationType:count,scale:ratio,sourceField:Records),b2d8baf2-886f-41ea-9ad1-c6fbfe14bdf6:(dataType:string,isBucketed:!t,label:'Top%20values%20of%20methode.keyword',operationType:terms,params:(missingBucket:!f,orderBy:(columnId:'8de887f9-c0ae-4cc8-a8f0-b9b8f0f82db9',type:column),orderDirection:desc,otherBucket:!t,size:5),scale:ordinal,sourceField:methode.keyword)),incompleteColumns:()),'8f83eca3-b8ee-4d50-903c-75bb085020f6':(columnOrder:!(),columns:())))),filters:!(),query:(language:kuery,query:''),visualization:(axisTitlesVisibilitySettings:(x:!t,yLeft:!t,yRight:!t),fittingFunction:None,gridlinesVisibilitySettings:(x:!t,yLeft:!t,yRight:!t),labelsOrientation:(x:0,yLeft:0,yRight:0),layers:!((accessors:!('8de887f9-c0ae-4cc8-a8f0-b9b8f0f82db9'),layerId:'8002249e-159d-4d5b-82e8-5309028c0d13',layerType:data,palette:(name:default,type:palette),position:top,seriesType:bar_stacked,showGridlines:!f,splitAccessor:b2d8baf2-886f-41ea-9ad1-c6fbfe14bdf6,xAccessor:'0ae76557-81fd-4106-b4db-53b3e9a10fe9',yConfig:!((color:%23d36dd6,forAccessor:'8de887f9-c0ae-4cc8-a8f0-b9b8f0f82db9'))),(accessors:!(),layerId:'8f83eca3-b8ee-4d50-903c-75bb085020f6',layerType:data,seriesType:bar_stacked)),legend:(isVisible:!t,position:right),preferredSeriesType:bar_stacked,tickLabelsVisibilitySettings:(x:!t,yLeft:!t,yRight:!t),valueLabels:hide,yLeftExtent:(mode:full),yRightExtent:(mode:full))),title:'code%20retour%20%2F%20methode',type:lens,visualizationType:lnsXY),enhancements:()),gridData:(h:9,i:'07465754-48fc-4ab9-aebb-0ad41e1774a7',w:24,x:0,y:0),panelIndex:'07465754-48fc-4ab9-aebb-0ad41e1774a7',type:lens,version:'7.15.0'),(embeddableConfig:(enhancements:(),savedVis:(data:(aggs:!((enabled:!t,id:'1',params:(),schema:metric,type:count),(enabled:!t,id:'2',params:(field:sys_appelant.keyword,size:9996),schema:group,type:significant_terms)),searchSource:(filter:!(),index:b6b57f40-2769-11ec-91be-f595bdc8e18a,query:(language:kuery,query:''))),description:'',params:(addLegend:!f,addTooltip:!t,metric:(colorSchema:'Green%20to%20Red',colorsRange:!((from:0,to:7),(from:7,to:65),(from:65,to:303),(from:303,to:377),(from:377,to:1130),(from:1130,to:1160),(from:1160,to:2100),(from:2100,to:4930),(from:4930,to:9998)),invertColors:!f,labels:(show:!t),metricColorMode:Background,percentageMode:!f,style:(bgColor:!f,bgFill:%23000,fontSize:32,labelColor:!f,subText:''),useRanges:!f),type:metric),title:'system%20appelant',type:metric,uiState:())),gridData:(h:9,i:'7881b9d3-2d5c-4d0c-abae-c3662f7dfff9',w:23,x:24,y:0),panelIndex:'7881b9d3-2d5c-4d0c-abae-c3662f7dfff9',type:visualization,version:'7.15.0'),(embeddableConfig:(enhancements:(),savedVis:(data:(aggs:!((enabled:!t,id:'1',params:(),schema:metric,type:count),(enabled:!t,id:'2',params:(field:methode.keyword,size:9998),schema:group,type:significant_terms)),searchSource:(filter:!(),index:b6b57f40-2769-11ec-91be-f595bdc8e18a,query:(language:kuery,query:''))),description:'',params:(addLegend:!t,addTimeMarker:!f,addTooltip:!t,categoryAxes:!((id:CategoryAxis-1,labels:(filter:!t,show:!t,truncate:100),position:right,scale:(type:linear),show:!f,style:(),title:(),type:category)),detailedTooltip:!t,grid:(categoryLines:!f),labels:(show:!t),legendPosition:right,maxLegendLines:5,orderBucketsBySum:!f,palette:(name:default,type:palette),radiusRatio:0,seriesParams:!((circlesRadius:3,data:(id:'1',label:Count),drawLinesBetweenPoints:!t,interpolate:linear,lineWidth:2,mode:stacked,show:!t,showCircles:!t,type:histogram,valueAxis:ValueAxis-1)),thresholdLine:(color:%23E7664C,show:!f,style:full,value:10,width:1),times:!(),truncateLegend:!t,type:histogram,valueAxes:!((id:ValueAxis-1,labels:(filter:!f,rotate:0,show:!t,truncate:100),name:LeftAxis-1,position:bottom,scale:(defaultYExtents:!f,mode:normal,setYExtents:!f,type:'square%20root'),show:!t,style:(),title:(text:Count),type:value))),title:methode,type:histogram,uiState:(vis:(colors:(POST-sendMission:%2354b399,completeTaskByInstanceIdActorIdPriority:%23c7988f,getEtat:%239170b8,getImPosition:%23d3a1bc))))),gridData:(h:7,i:'7b2c04a2-8728-4825-8f1e-64c03ff0e2d0',w:24,x:0,y:9),panelIndex:'7b2c04a2-8728-4825-8f1e-64c03ff0e2d0',type:visualization,version:'7.15.0'),(embeddableConfig:(enhancements:(),savedVis:(data:(aggs:!((enabled:!t,id:'1',params:(),schema:metric,type:count),(enabled:!t,id:'2',params:(field:operation.keyword,size:9998),schema:segment,type:significant_terms)),searchSource:(filter:!(),index:b6b57f40-2769-11ec-91be-f595bdc8e18a,query:(language:kuery,query:''))),description:'',params:(addLegend:!t,addTooltip:!t,distinctColors:!f,isDonut:!t,labels:(last_level:!f,percentDecimals:3,position:default,show:!t,truncate:1000,values:!t,valuesFormat:percent),legendPosition:right,maxLegendLines:5,nestedLegend:!t,palette:(name:default,type:palette),row:!t,truncateLegend:!t,type:pie),title:operation,type:pie,uiState:()),table:!n,vis:(colors:(isWithAdsl:%2354b399,recupEtatOt:%23d6bf57,resiliationServiceClient:%23aa6556),legendOpen:!t)),gridData:(h:16,i:'45a11854-1d1c-46f5-95b4-99cbdcb03201',w:23,x:24,y:9),panelIndex:'45a11854-1d1c-46f5-95b4-99cbdcb03201',type:visualization,version:'7.15.0'),(embeddableConfig:(enhancements:(),savedVis:(data:(aggs:!(),searchSource:(filter:!(),query:(language:kuery,query:''))),description:'',params:(axis_formatter:number,axis_position:left,axis_scale:normal,background_color_rules:!((id:c8ba7280-28fa-11ec-9df7-f98c072393af)),bar_color_rules:!((id:ced95f50-28fa-11ec-9df7-f98c072393af)),drop_last_bucket:0,gauge_color_rules:!((id:d3118ac0-28fa-11ec-9df7-f98c072393af)),gauge_inner_width:10,gauge_style:half,gauge_width:10,id:'0f5b062a-9436-4b39-ab67-1b3fc03eb135',index_pattern:'',interval:'',isModelInvalid:!f,max_bars:10,max_lines_legend:5,series:!((axis_position:left,chart_type:line,color:%2368BC00,fill:'1',formatter:number,hide_in_legend:0,id:'4884d772-b23d-432f-a099-4d0fe14920e1',label:'',line_width:'5',metrics:!((field:txt_log.keyword,id:'390dcd79-06d7-452d-b479-d76dc36b25e8',type:cardinality,unit:'')),offset_time:'1h',override_index_pattern:0,palette:(name:rainbow,params:(colors:!(%2368BC00,%23009CE0,%23B0BC00,%2316A5A5,%23D33115,%23E27300,%23FCC400,%237B64FF,%23FA28FF,%23333333,%23808080,%23194D33,%230062B1,%23808900,%230C797D,%239F0500,%23C45100,%23FB9E00,%23653294,%23AB149E,%230F1419,%23666666),gradient:!f),type:palette),point_size:'2',separate_axis:1,series_index_pattern:(id:b6b57f40-2769-11ec-91be-f595bdc8e18a),series_time_field:d_log,split_color_mode:!n,split_mode:terms,stacked:none,steps:0,terms_direction:desc,terms_field:d_log,terms_order_by:'390dcd79-06d7-452d-b479-d76dc36b25e8',terms_size:'5',type:timeseries)),show_grid:1,show_legend:1,time_field:'',time_range_mode:entire_time_range,tooltip_mode:show_all,truncate_legend:1,type:timeseries,use_kibana_indexes:!t),title:timeRange,type:metrics,uiState:())),gridData:(h:9,i:'35fe06ee-07df-4f91-b8e4-82a52846fd68',w:24,x:0,y:16),panelIndex:'35fe06ee-07df-4f91-b8e4-82a52846fd68',type:visualization,version:'7.15.0')),query:(language:kuery,query:''),tags:!(),timeRestore:!f,title:'dashbords%20admin%20',viewMode:view)&show-top-menu=true&show-query-input=true&show-time-filter=true",
        height: screenSize.height / 1.7,
        width: screenSize.width * 0.9,
        onWebViewCreated: (controller) => webviewController = controller,
        onPageStarted: (src) =>
            debugPrint('A new page has started loading: $src\n'),
        onPageFinished: (src) =>
            debugPrint('The page has finished loading: $src\n'),
      ),
    );
  }

  void _setUrl() {
    webviewController.loadContent(
      'https://flutter.dev',
      SourceType.URL,
    );
  }

  void _setUrlBypass() {
    webviewController.loadContent(
      'https://news.ycombinator.com/',
      SourceType.URL_BYPASS,
    );
  }

  void _reload() {
    webviewController.reload();
  }

  Widget buildSpace({
    Axis direction = Axis.horizontal,
    double amount = 0.2,
    bool flex = true,
  }) {
    return flex
        ? Flexible(
            child: FractionallySizedBox(
              widthFactor: direction == Axis.horizontal ? amount : null,
              heightFactor: direction == Axis.vertical ? amount : null,
            ),
          )
        : SizedBox(
            width: direction == Axis.horizontal ? amount : null,
            height: direction == Axis.vertical ? amount : null,
          );
  }
}
