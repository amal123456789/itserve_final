import 'dart:convert';

UserModel userModelJson(String str) =>
  UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => 
json.encode(data.toJson());
enum Role {
admin,user, moderteur,
}
class UserModel{
  int id;
  String cin;
  String firstName;
  String lastName;
  String phone;
  String mail;
  String login;
  String password;
  Role role;

  UserModel({this.id,this.cin,this.firstName,this.lastName,this.phone,this.mail,this.login,this.password,this.role});

 factory UserModel.fromJson(Map<String , dynamic> json) => UserModel(
  id: json["id"],
  cin: json["cin"],
  firstName: json["firstName"],
  lastName: json["lastName"],
  phone: json["phone"],
  mail: json["mail"],
  login: json["login"],
  password: json[""],
  role: json[""],
  );
  Map<String, dynamic> toJson() => {
  'id' : id,
  "cin" : cin,
  "firstName" :firstName,
  "lastName" : lastName,
  "phone" : phone,
  "mail" : mail,
  "login" : login,
  "password" : password,
  "role" : role,


  };
  
  int get idd => id;
  String get cinn => cin;
  String get firstname => firstName;
  String get lastname => lastName;
  String get phonee => phone;
  String get maill => mail;
  String get loginn => login;
  String get passwordd => password;
  String get rolee => role.toString() ;

}
