import 'dart:convert';

LogsModel logsModelJson(String str) => LogsModel.fromJson(json.decode(str));
String logsModelToJson(LogsModel data) => json.encode(data.toJson());

class LogsModel {
  int id;
  String d_log;
  String type;
  String sens;
  String ws;
  String methode;
  String sys_appelant;
  String c_retour;
  String operation;
  String txt_LOG;
  String request;
  String response;
  int id_dem;
  String bpm_uid;
  String ref_dem_src;
  String tags;

  LogsModel(
      {this.id,
      this.d_log,
      this.type,
      this.sens,
      this.ws,
      this.methode,
      this.sys_appelant,
      this.c_retour,
      this.operation,
      this.txt_LOG,
      this.request,
      this.response,
      this.id_dem,
      this.bpm_uid,
      this.ref_dem_src,
      this.tags});

  factory LogsModel.fromJson(Map<String, dynamic> json) => LogsModel(
      id: json["id"],
      //d_LOG: json["d_LOG"],
      type: json["type"],
      sens: json["sens"],
      ws: json["ws"],
      methode: json["methode"],
      sys_appelant: json["sys_appelant"],
      c_retour: json["c_RETOUR"],
      operation: json["operation"],
      txt_LOG: json["txt_LOG"],
      request: json["request"],
      response: json["response"],
      id_dem: json["id_DEM"],
      bpm_uid: json["bpm_UID"],
      ref_dem_src: json["ref_DEM_SRC"],
      tags: json["tags"]);
  Map<String, dynamic> toJson() => {
        'id': id,
        "d_log": d_log,
        "type": type,
        "sens": sens,
        "ws": ws,
        "methode": methode,
        "sys_appelant": sys_appelant,
        "c_retour": c_retour,
        "operation": operation,
        "txt_log": txt_LOG,
        "request": request,
        "response": response,
        /*"id_dem" : id_dem,
  "bpm_uid" : bpm_uid,*/
        "ref_dem_src": ref_dem_src,
        "tags": tags,
      };

  String get d1_log => d_log;
  String get Type => type;
  String get Sens => sens;
  String get Ws => ws;
  String get Methode => methode;
  String get Sys_appleant => sys_appelant;
  String get C_retour => c_retour;
  String get Operation => operation;
  String get Txt_log => txt_LOG;
  String get Request => request;
  String get Response => response;
  int get Id_dem => id_dem;
  String get Bpm_uid => bpm_uid;
  String get Ref_dem_src => ref_dem_src;
  String get tagss => tags;
}
