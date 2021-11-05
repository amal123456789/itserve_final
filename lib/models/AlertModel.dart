import 'dart:convert';

AlertModel alertModelJson(String str) =>
    AlertModel.fromJson(json.decode(str));
String alertModelToJson(AlertModel data) =>
    json.encode(data.toJson());

class AlertModel {
  int id;
  String name;
  String action;
  String message;

  AlertModel(
      {this.id,
      this.name,
      this.action,
      this.message});
  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      AlertModel(
          id: json["id"],
          name: json["name"],
          action: json["action"],
          message: json["message"]);
  Map<String, dynamic> toJson() => {
        'id': id,
        "name": name,
        "action": action,
        "message": message
      };
}
