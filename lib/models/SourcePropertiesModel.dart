import 'dart:convert';

SourcePropertiesModel sourcePropertiesModelJson(String str) =>
    SourcePropertiesModel.fromJson(json.decode(str));
String sourcePropertiesModelToJson(SourcePropertiesModel data) =>
    json.encode(data.toJson());

class SourcePropertiesModel {
  int idSourceprop;
  String value;
  String loginModif;
  DateTime dateModif = DateTime.now();
  int properties;
  //String dateModif;

  SourcePropertiesModel(
      {this.idSourceprop,
      this.value,
      this.loginModif,
      this.dateModif,
      this.properties});
  factory SourcePropertiesModel.fromJson(Map<String, dynamic> json) =>
      SourcePropertiesModel(
          idSourceprop: json["idSourceprop"],
          value: json["value"],
          loginModif: json["loginModif"],
          dateModif: json["dateModif"],
          properties: json["properties"]);
  Map<String, dynamic> toJson() => {
        'idSourceprop': idSourceprop,
        "value": value,
        "loginModif": loginModif,
        "dateModif": dateModif.toString(),
        "properties": properties
      };
  int get idsourceprop => idSourceprop;
  String get values => value;
  String get loginmodif => loginModif;
  String get datemodif => dateModif.toString();
  int get propertiess => properties;
}
