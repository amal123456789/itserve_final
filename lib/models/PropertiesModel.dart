
import 'dart:convert';


PropertiesModel propertiesModelJson(String str) =>
  PropertiesModel.fromJson(json.decode(str));
String propertiesModelToJson(PropertiesModel data) => 
json.encode(data.toJson());


class PropertiesModel{
  int idProperty;
  String codeProp;
  String propName;
  String classe;

PropertiesModel({this.idProperty, this.codeProp,this.propName, this.classe});

factory PropertiesModel.fromJson(Map<String ,dynamic> json) => PropertiesModel(
  idProperty: json["idProperty"],
  codeProp: json["codeProp"],
  propName: json["propName"],
  classe: json[""]
);
Map<String ,dynamic> toJson() => {
'idProperty' : idProperty,
"codeProp": codeProp,
"propName" : propName,
"classe" :classe,
};

String get codeprop => codeProp;
String get propname => propName;
String get classes => classe;
}