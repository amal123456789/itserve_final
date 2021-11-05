import 'dart:convert';

DataDestinationModel dataDestinationModelJson(String str) =>
 DataDestinationModel.fromJson(json.decode(str));
String dataDestinationModeToJson (DataDestinationModel data) => 
json.encode(data.toJson());




class DataDestinationModel {
    int idDestination;
  String ipAdressDestination;
  String portDestination;
  String descritpionDestination;
  //String numUserDestination;
  //String passwordDestination;

DataDestinationModel({this.idDestination, this.ipAdressDestination, this.portDestination,this.descritpionDestination});
factory DataDestinationModel.fromJson(Map<String , dynamic> json) => 
DataDestinationModel(
  idDestination: json["idDestination"],
  ipAdressDestination: json["ipAdressDestination"],
  portDestination: json["portDestination"],
  descritpionDestination: json["descritpionDestination"]
);
 Map<String, dynamic> toJson() => {
 'idDestination' : idDestination,
 "ipAdressDestination" : ipAdressDestination,
 "portDestination" : portDestination,
 "descritpionDestination" : descritpionDestination,


 };
 int get iddestination => idDestination;
 String get ipAdressdestination => ipAdressDestination;
 String get portdestination => portDestination;
 String get descritpiondestination => descritpionDestination;

}