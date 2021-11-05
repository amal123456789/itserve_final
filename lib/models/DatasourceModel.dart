import 'dart:convert';

DatasourceModel datasourceModelJson(String str) =>
    DatasourceModel.fromJson(json.decode(str));
String datasourceModelToJson(DatasourceModel data) =>
    json.encode(data.toJson());

class DatasourceModel {
  int idSourceSequence;
  String schemaUrl;
  String systemName;
  String systemCode;
  String descritpionSource;
  int idSourceprop;

  DatasourceModel(
      {this.idSourceSequence,
      this.schemaUrl,
      this.systemName,
      this.systemCode,
      this.descritpionSource,
      this.idSourceprop});
  factory DatasourceModel.fromJson(Map<String, dynamic> json) =>
      DatasourceModel(
          idSourceSequence: json["idSourceSequence"],
          schemaUrl: json["schemaUrl"],
          systemName: json["systemName"],
          systemCode: json["systemCode"],
          descritpionSource: json["descritpionSource"],
          idSourceprop: json["idSourceprop"]);
  Map<String, dynamic> toJson() => {
        'idSourceSequence': idSourceSequence,
        "schemaUrl": schemaUrl,
        "systemName": systemName,
        "systemCode": systemCode,
        "descritpionSource": descritpionSource,
        "idSourceprop": idSourceprop
      };
  // int get idsourcesequence => idSourceSequence;
  String get schemaurl => schemaUrl;
  String get systemname => systemName;
  String get syscode => systemCode;
  String get descritpionsource => descritpionSource;
}
