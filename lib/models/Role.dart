
import 'dart:convert';

Role roleJson(String str) =>
  Role.fromJson(json.decode(str));
String roleToJson(Role data) => 
json.encode(data.toJson());
enum RoleE {
admin,user, moderteur,
}
class Role{
  int id;
  RoleE name;
  Role({this.id,this.name});

factory Role.fromJson(Map<String , dynamic> json) => Role(
  id: json['id'],
  name: json["name"],
);

Map<String, dynamic> toJson() => {
  'id' : id,
  "name" : name,

};
int get idd => id;
String get rolee => name.toString() ;
}