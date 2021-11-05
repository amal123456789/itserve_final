import 'dart:convert';

LogsModel logsModelJson(String str) => LogsModel.fromJson(json.decode(str));
String logsModelToJson(LogsModel data) => json.encode(data.toJson());

class LogsModel {
  int id;
  String d_LOG;
  String tYPE;
  String sENS;
  String wS;
  String mETHODE;
  String sYS_APPELANT;
  String c_RETOUR;
  String oPERATION;
  String tXT_LOG;
  String rEQUEST;
  String rESPONSE;
  int iD_DEM;
  String bPM_UID;
  String rEF_DEM_SRC;
  String tags;

  LogsModel(
      {this.id,
      this.d_LOG,
      this.tYPE,
      this.sENS,
      this.wS,
      this.mETHODE,
      this.sYS_APPELANT,
      this.c_RETOUR,
      this.oPERATION,
      this.tXT_LOG,
      this.rEQUEST,
      this.rESPONSE,
      this.iD_DEM,
      this.bPM_UID,
      this.rEF_DEM_SRC,
      this.tags});

  factory LogsModel.fromJson(Map<String, dynamic> json) => LogsModel(
      id: json["id"],
      //d_LOG: json["d_LOG"],
      tYPE: json["tYPE"],
      sENS: json["sENS"],
      wS: json["wS"],
      mETHODE: json["mETHODE"],
      sYS_APPELANT: json["sYS_APPELANT"],
      c_RETOUR: json["c_RETOUR"],
      oPERATION: json["oPERATION"],
      tXT_LOG: json["tXT_LOG"],
      rEQUEST: json["rEQUEST"],
      rESPONSE: json["rESPONSE"],
      iD_DEM: json["iD_DEM"],
      bPM_UID: json["bPM_UID"],
      rEF_DEM_SRC: json["rEF_DEM_SRC"],
      tags: json["tags"]);
  Map<String, dynamic> toJson() => {
        'id': id,
        "d_LOG": d_LOG,
        "type": tYPE,
        "sens": sENS,
        "ws": wS,
        "methode": mETHODE,
        "sys_APPELANT": sYS_APPELANT,
        "c_RETOUR": c_RETOUR,
        "operation": oPERATION,
        "txt_LOG": tXT_LOG,
        "request": rEQUEST,
        "response": rESPONSE,
        /*"iD_DEM" : iD_DEM,
  "bPM_UID" : bPM_UID,*/
        "ref_DEM_SRC": rEF_DEM_SRC,
        "tags": tags,
      };

  String get dlog => d_LOG;
  String get type => tYPE;
  String get sens => sENS;
  String get ws => wS;
  String get methode => mETHODE;
  String get sys_appelant => sYS_APPELANT;
  String get c_retour => c_RETOUR;
  String get operation => oPERATION;
  String get txt_log => tXT_LOG;
  String get request => rEQUEST;
  String get response => rESPONSE;
  int get id_dem => iD_DEM;
  String get bpm_uid => bPM_UID;
  String get ref_dem_src => rEF_DEM_SRC;
  String get tagss => tags;
}
